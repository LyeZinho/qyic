import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../../decks/data/quiz_rows.dart';
import '../../decks/domain/deck.dart';
import '../domain/review_mode.dart';

/// A quiz together with its current scheduling state.
class StudyItem {
  const StudyItem({required this.quiz, required this.card});

  final Quiz quiz;
  final SchedulingCard card;
}

class StudyCounts {
  const StudyCounts({required this.due, required this.fresh});

  /// Previously studied cards due now.
  final int due;

  /// Never-seen cards available today, already capped by the daily limit.
  final int fresh;

  int get total => due + fresh;
}

class StudyRepository {
  StudyRepository(this._db);

  final AppDatabase _db;

  /// Learning and relearning cards due within this window are shown early
  /// rather than ending the session while their short steps elapse.
  static const learnAhead = Duration(minutes: 20);

  /// Builds a session queue for one deck, or for every deck when [deckId] is
  /// null: due cards by due date, then new cards up to today's remaining
  /// allowance.
  Future<List<StudyItem>> loadQueue({
    required String? deckId,
    required DateTime now,
    required int newCardsPerDay,
    Set<QuizType>? types,
  }) async {
    final nowMs = now.millisecondsSinceEpoch;
    final remainingNew = math.max(
      0,
      newCardsPerDay - await _newCardsIntroducedOn(now),
    );

    final due = await _cardRows(
      where:
          'c.reps > 0 AND (c.due_at_ms <= ?1 OR '
          '(c.phase != ?2 AND c.due_at_ms <= ?3))',
      orderBy: 'c.due_at_ms',
      deckId: deckId,
      types: types,
      variables: [
        Variable.withInt(nowMs),
        Variable.withInt(CardPhase.review.value),
        Variable.withInt(nowMs + learnAhead.inMilliseconds),
      ],
    );
    final fresh = remainingNew == 0
        ? const <CardStateRow>[]
        : await _cardRows(
            where: 'c.reps = 0',
            orderBy: 'd.created_at_ms, d.id, q.position',
            deckId: deckId,
            types: types,
            limit: remainingNew,
          );

    final rows = [...due, ...fresh];
    final quizzes = await quizzesById(rows.map((row) => row.quizId).toList());
    return [
      for (final row in rows)
        if (quizzes[row.quizId] case final quiz?)
          StudyItem(quiz: quiz, card: cardFromRow(row)),
    ];
  }

  Stream<StudyCounts> watchCounts({
    required String? deckId,
    required DateTime now,
    required int newCardsPerDay,
    Set<QuizType>? types,
  }) {
    final nowMs = now.millisecondsSinceEpoch;
    final deckFilter = deckId == null ? '' : 'AND c.deck_id = ?3 ';
    final type = _typeFilter(types, deckId == null ? 3 : 4);
    return _db
        .customSelect(
          'SELECT '
          'COALESCE(SUM(c.reps > 0 AND c.due_at_ms <= ?1), 0) AS due, '
          'COALESCE(SUM(c.reps = 0), 0) AS fresh, '
          '$_introducedTodaySql AS introduced '
          '$_activeCardsFrom WHERE 1 = 1 $deckFilter${type.clause}',
          variables: [
            Variable.withInt(nowMs),
            Variable.withInt(_startOfLocalDay(now).millisecondsSinceEpoch),
            if (deckId != null) Variable.withString(deckId),
            ...type.variables,
          ],
          readsFrom: {_db.cardStates, _db.quizzes, _db.decks, _db.reviewEvents},
        )
        .watchSingle()
        .map((row) {
          final remaining = math.max(
            0,
            newCardsPerDay - row.read<int>('introduced'),
          );
          return StudyCounts(
            due: row.read<int>('due'),
            fresh: math.min(row.read<int>('fresh'), remaining),
          );
        });
  }

  /// Applies [rating] to the quiz's scheduling state and appends the matching
  /// review event, atomically. Returns the new state.
  Future<SchedulingCard> recordReview({
    required String quizId,
    required Rating rating,
    required DateTime reviewedAt,
    required Duration duration,
    required String clientId,
    required FsrsScheduler scheduler,
    ReviewMode mode = ReviewMode.standard,
  }) {
    return _db.transaction(() async {
      final row = await (_db.select(
        _db.cardStates,
      )..where((c) => c.quizId.equals(quizId))).getSingle();
      final current = cardFromRow(row);
      final next = scheduler.review(current, rating, reviewedAt);
      final lapsed =
          current.phase == CardPhase.review && rating == Rating.again;

      await (_db.update(
        _db.cardStates,
      )..where((c) => c.quizId.equals(quizId))).write(
        CardStatesCompanion(
          phase: Value(next.phase.value),
          step: Value(next.step),
          stability: Value(next.stability),
          difficulty: Value(next.difficulty),
          dueAtMs: Value(next.due.millisecondsSinceEpoch),
          lastReviewedAtMs: Value(next.lastReview!.millisecondsSinceEpoch),
          reps: Value(row.reps + 1),
          lapses: Value(row.lapses + (lapsed ? 1 : 0)),
        ),
      );

      final maxSeq = _db.reviewEvents.clientSeq.max();
      final seqRow =
          await (_db.selectOnly(_db.reviewEvents)
                ..addColumns([maxSeq])
                ..where(_db.reviewEvents.clientId.equals(clientId)))
              .getSingle();
      await _db
          .into(_db.reviewEvents)
          .insert(
            ReviewEventsCompanion.insert(
              clientId: clientId,
              clientSeq: (seqRow.read(maxSeq) ?? 0) + 1,
              quizId: quizId,
              deckId: row.deckId,
              rating: rating.value,
              reviewedAtMs: reviewedAt.millisecondsSinceEpoch,
              durationMs: duration.inMilliseconds,
              mode: Value(mode.value),
            ),
          );
      return next;
    });
  }

  Future<int> _newCardsIntroducedOn(DateTime now) async {
    final row = await _db
        .customSelect(
          'SELECT $_introducedTodaySql AS introduced',
          variables: [
            Variable.withInt(now.millisecondsSinceEpoch),
            Variable.withInt(_startOfLocalDay(now).millisecondsSinceEpoch),
          ],
        )
        .getSingle();
    return row.read<int>('introduced');
  }

  Future<List<CardStateRow>> _cardRows({
    required String where,
    required String orderBy,
    required String? deckId,
    Set<QuizType>? types,
    List<Variable> variables = const [],
    int? limit,
  }) {
    final type = _typeFilter(types, variables.length + 1);
    final deckFilter = deckId == null ? '' : 'AND c.deck_id = ?${type.next} ';
    final limitClause = limit == null ? '' : 'LIMIT $limit';
    return _db
        .customSelect(
          'SELECT c.* $_activeCardsFrom '
          'WHERE $where ${type.clause}$deckFilter ORDER BY $orderBy $limitClause',
          variables: [
            ...variables,
            ...type.variables,
            if (deckId != null) Variable.withString(deckId),
          ],
          readsFrom: {_db.cardStates, _db.quizzes, _db.decks},
        )
        .map((row) => _db.cardStates.map(row.data))
        .get();
  }

  /// Loads quizzes with their options. Ids that do not exist are omitted.
  Future<Map<String, Quiz>> quizzesById(List<String> ids) async {
    if (ids.isEmpty) return const {};
    final quizzes = await (_db.select(
      _db.quizzes,
    )..where((q) => q.id.isIn(ids))).get();
    final options =
        await (_db.select(_db.quizOptions)
              ..where((o) => o.quizId.isIn(ids))
              ..orderBy([(o) => OrderingTerm.asc(o.position)]))
            .get();
    final optionsByQuiz = <String, List<QuizOptionRow>>{};
    for (final option in options) {
      (optionsByQuiz[option.quizId] ??= []).add(option);
    }
    return {
      for (final quiz in quizzes)
        quiz.id: quizFromRows(quiz, optionsByQuiz[quiz.id] ?? const []),
    };
  }

  static SchedulingCard cardFromRow(CardStateRow row) => SchedulingCard(
    phase: CardPhase.fromValue(row.phase),
    step: row.step,
    stability: row.stability,
    difficulty: row.difficulty,
    due: DateTime.fromMillisecondsSinceEpoch(row.dueAtMs, isUtc: true),
    lastReview: row.lastReviewedAtMs == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            row.lastReviewedAtMs!,
            isUtc: true,
          ),
  );

  static DateTime _startOfLocalDay(DateTime now) {
    final local = now.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  /// `AND q.type IN (?n, ...)` starting at placeholder [from]. An empty set
  /// matches nothing; null leaves the query unfiltered.
  static ({String clause, List<Variable<int>> variables, int next}) _typeFilter(
    Set<QuizType>? types,
    int from,
  ) {
    if (types == null) return (clause: '', variables: const [], next: from);
    if (types.isEmpty) {
      return (clause: 'AND 0 ', variables: const [], next: from);
    }
    final placeholders = [
      for (var index = 0; index < types.length; index++) '?${from + index}',
    ].join(', ');
    return (
      clause: 'AND q.type IN ($placeholders) ',
      variables: [for (final type in types) Variable<int>(type.value)],
      next: from + types.length,
    );
  }

  /// Cards whose quiz and deck are not tombstoned.
  static const _activeCardsFrom =
      'FROM card_states c '
      'JOIN quizzes q ON q.id = c.quiz_id AND q.deleted_at_ms IS NULL '
      'JOIN decks d ON d.id = c.deck_id AND d.deleted_at_ms IS NULL ';

  /// Quizzes whose first-ever review falls on the current local day.
  /// Binds `?2` to the start of that day in epoch ms.
  static const _introducedTodaySql =
      '(SELECT COUNT(*) FROM (SELECT MIN(reviewed_at_ms) AS first '
      'FROM review_events GROUP BY quiz_id) WHERE first >= ?2)';
}

final studyRepositoryProvider = Provider<StudyRepository>(
  (ref) => StudyRepository(ref.watch(databaseProvider)),
);
