import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids.dart';
import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../domain/deck.dart';
import '../domain/quiz_validation.dart';
import 'quiz_rows.dart';

/// Per-deck counts shown in lists. "Due" counts cards that were already
/// studied and are scheduled at or before `now`; "new" cards were never seen.
class DeckSummary {
  const DeckSummary({
    required this.deck,
    required this.quizCount,
    required this.dueCount,
    required this.newCount,
    required this.learnedCount,
  });

  final Deck deck;
  final int quizCount;
  final int dueCount;
  final int newCount;

  /// Cards that graduated to the review phase.
  final int learnedCount;

  double get learnedFraction => quizCount == 0 ? 0 : learnedCount / quizCount;
}

class DeckStats {
  const DeckStats({
    required this.summary,
    required this.matureCount,
    required this.recentReviews,
    required this.recentRecalls,
    required this.typeCounts,
  });

  /// Stability (days) from which a card counts as mature.
  static const matureStabilityDays = 21.0;

  /// Window for [retention].
  static const retentionWindow = Duration(days: 30);

  final DeckSummary summary;
  final int matureCount;
  final int recentReviews;
  final int recentRecalls;
  final Map<QuizType, int> typeCounts;

  /// Share of reviews in [retentionWindow] not rated Again; null without data.
  double? get retention =>
      recentReviews == 0 ? null : recentRecalls / recentReviews;

  double get matureFraction =>
      summary.quizCount == 0 ? 0 : matureCount / summary.quizCount;
}

class DeckRepository {
  DeckRepository(this._db, this._clock);

  final AppDatabase _db;
  final Clock _clock;

  Stream<List<DeckSummary>> watchSummaries(DateTime now) {
    return _db
        .customSelect(
          '$_summarySelect WHERE d.deleted_at_ms IS NULL '
          'GROUP BY d.id ORDER BY d.updated_at_ms DESC',
          variables: [Variable.withInt(now.millisecondsSinceEpoch)],
          readsFrom: {_db.decks, _db.quizzes, _db.cardStates},
        )
        .watch()
        .map((rows) => rows.map(_summaryFromRow).toList());
  }

  Stream<DeckStats?> watchStats(String deckId, DateTime now) {
    final nowMs = now.millisecondsSinceEpoch;
    final summary = _db
        .customSelect(
          '$_summarySelect WHERE d.id = ?2 AND d.deleted_at_ms IS NULL '
          'GROUP BY d.id',
          variables: [Variable.withInt(nowMs), Variable.withString(deckId)],
          readsFrom: {_db.decks, _db.quizzes, _db.cardStates, _db.reviewEvents},
        )
        .watchSingleOrNull();

    return summary.asyncMap((row) async {
      if (row == null) return null;
      final extra = await _db
          .customSelect(
            'SELECT '
            '(SELECT COUNT(*) FROM card_states c JOIN quizzes q '
            '   ON q.id = c.quiz_id AND q.deleted_at_ms IS NULL '
            '   WHERE c.deck_id = ?1 AND c.stability >= ?2) AS mature, '
            '(SELECT COUNT(*) FROM review_events '
            '   WHERE deck_id = ?1 AND reviewed_at_ms >= ?3) AS reviews, '
            '(SELECT COUNT(*) FROM review_events '
            '   WHERE deck_id = ?1 AND reviewed_at_ms >= ?3 AND rating > ?4) '
            '   AS recalls',
            variables: [
              Variable.withString(deckId),
              Variable.withReal(DeckStats.matureStabilityDays),
              Variable.withInt(
                now.subtract(DeckStats.retentionWindow).millisecondsSinceEpoch,
              ),
              Variable.withInt(Rating.again.value),
            ],
          )
          .getSingle();
      final types = await _db
          .customSelect(
            'SELECT type, COUNT(*) AS n FROM quizzes '
            'WHERE deck_id = ?1 AND deleted_at_ms IS NULL GROUP BY type',
            variables: [Variable.withString(deckId)],
          )
          .get();

      return DeckStats(
        summary: _summaryFromRow(row),
        matureCount: extra.read<int>('mature'),
        recentReviews: extra.read<int>('reviews'),
        recentRecalls: extra.read<int>('recalls'),
        typeCounts: {
          for (final type in types)
            QuizType.fromValue(type.read<int>('type')): type.read<int>('n'),
        },
      );
    });
  }

  Stream<Deck?> watchDeck(String deckId) {
    final query = _db.select(_db.decks)
      ..where((d) => d.id.equals(deckId) & d.deletedAtMs.isNull());
    return query.watchSingleOrNull().map(
      (row) => row == null ? null : _deckFromRow(row),
    );
  }

  /// Quiz prompts in deck order, without their options. A full deck can hold
  /// thousands of quizzes; joining every option here would rebuild that whole
  /// payload on every change.
  Stream<List<QuizSummary>> watchQuizSummaries(String deckId) {
    final query = _db.select(_db.quizzes)
      ..where((q) => q.deckId.equals(deckId) & q.deletedAtMs.isNull())
      ..orderBy([(q) => OrderingTerm.asc(q.position)]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          QuizSummary(
            id: row.id,
            type: QuizType.fromValue(row.type),
            question: row.question,
          ),
      ],
    );
  }

  Stream<List<Quiz>> watchQuizzes(String deckId) {
    final query =
        _db.select(_db.quizzes).join([
            leftOuterJoin(
              _db.quizOptions,
              _db.quizOptions.quizId.equalsExp(_db.quizzes.id),
            ),
          ])
          ..where(
            _db.quizzes.deckId.equals(deckId) &
                _db.quizzes.deletedAtMs.isNull(),
          )
          ..orderBy([
            OrderingTerm.asc(_db.quizzes.position),
            OrderingTerm.asc(_db.quizOptions.position),
          ]);
    return query.watch().map(_groupQuizzes);
  }

  Future<Quiz?> loadQuiz(String quizId) async {
    final quiz =
        await (_db.select(_db.quizzes)
              ..where((q) => q.id.equals(quizId) & q.deletedAtMs.isNull()))
            .getSingleOrNull();
    if (quiz == null) return null;
    final options = await _optionsFor([quizId]);
    return quizFromRows(quiz, options[quizId] ?? const []);
  }

  /// Installed content version and live quiz ids of [deckId]; a null
  /// version means the deck is not installed (or was deleted).
  Future<({int? version, Set<String> quizIds})> installedState(
    String deckId,
  ) async {
    final deck =
        await (_db.select(_db.decks)
              ..where((d) => d.id.equals(deckId) & d.deletedAtMs.isNull()))
            .getSingleOrNull();
    if (deck == null) return (version: null, quizIds: const <String>{});
    final ids =
        await (_db.selectOnly(_db.quizzes)
              ..addColumns([_db.quizzes.id])
              ..where(
                _db.quizzes.deckId.equals(deckId) &
                    _db.quizzes.deletedAtMs.isNull(),
              ))
            .map((row) => row.read(_db.quizzes.id)!)
            .get();
    return (version: deck.version, quizIds: ids.toSet());
  }

  Future<String> createDeck({
    required String title,
    String description = '',
    String author = '',
  }) async {
    final id = newUuid();
    final nowMs = _clock().millisecondsSinceEpoch;
    await _db
        .into(_db.decks)
        .insert(
          DecksCompanion.insert(
            id: id,
            title: _requireTitle(title),
            description: Value(description.trim()),
            author: Value(author.trim()),
            createdAtMs: nowMs,
            updatedAtMs: nowMs,
          ),
        );
    return id;
  }

  Future<void> updateDeck(
    String deckId, {
    required String title,
    required String description,
  }) {
    return (_db.update(_db.decks)..where((d) => d.id.equals(deckId))).write(
      DecksCompanion(
        title: Value(_requireTitle(title)),
        description: Value(description.trim()),
        updatedAtMs: Value(_clock().millisecondsSinceEpoch),
      ),
    );
  }

  /// Tombstones the deck and its quizzes; review history is kept.
  Future<void> deleteDeck(String deckId) {
    final nowMs = _clock().millisecondsSinceEpoch;
    return _db.transaction(() async {
      await (_db.update(
        _db.quizzes,
      )..where((q) => q.deckId.equals(deckId) & q.deletedAtMs.isNull())).write(
        QuizzesCompanion(deletedAtMs: Value(nowMs), updatedAtMs: Value(nowMs)),
      );
      await (_db.update(_db.decks)..where((d) => d.id.equals(deckId))).write(
        DecksCompanion(deletedAtMs: Value(nowMs), updatedAtMs: Value(nowMs)),
      );
    });
  }

  /// Inserts or updates [quiz]. New quizzes are appended to the deck and get
  /// a fresh scheduling state.
  ///
  /// Throws [QuizValidationException] when the content is invalid.
  Future<void> saveQuiz(Quiz quiz) {
    final issues = validateQuiz(quiz);
    if (issues.isNotEmpty) throw QuizValidationException(issues);

    final now = _clock();
    return _db.transaction(() async {
      final existing = await (_db.select(
        _db.quizzes,
      )..where((q) => q.id.equals(quiz.id))).getSingleOrNull();
      final position = existing?.position ?? await _nextPosition(quiz.deckId);
      await _writeQuiz(
        quiz.copyWith(position: position),
        now,
        createdAtMs: existing?.createdAtMs,
      );
      await _touchDeck(quiz.deckId, now);
    });
  }

  Future<void> deleteQuiz(String quizId) {
    final nowMs = _clock().millisecondsSinceEpoch;
    return _db.transaction(() async {
      final quiz = await (_db.select(
        _db.quizzes,
      )..where((q) => q.id.equals(quizId))).getSingle();
      await (_db.update(_db.quizzes)..where((q) => q.id.equals(quizId))).write(
        QuizzesCompanion(deletedAtMs: Value(nowMs), updatedAtMs: Value(nowMs)),
      );
      await _touchDeck(quiz.deckId, _clock());
    });
  }

  /// Installs or updates deck content in one transaction, idempotent by deck
  /// id (`docs/deck-format.md` §5). Learner progress for existing quizzes is
  /// preserved; quizzes missing from [content] are tombstoned.
  ///
  /// Throws [QuizValidationException] for invalid content and [StateError]
  /// when a quiz id already belongs to a different deck.
  Future<void> installContent(DeckContent content) {
    final deck = content.deck;
    for (final quiz in content.quizzes) {
      final issues = validateQuiz(quiz);
      if (issues.isNotEmpty) throw QuizValidationException(issues);
      if (quiz.deckId != deck.id) {
        throw ArgumentError.value(quiz.deckId, 'quiz.deckId', 'not ${deck.id}');
      }
    }

    final now = _clock();
    final nowMs = now.millisecondsSinceEpoch;
    final ids = [for (final quiz in content.quizzes) quiz.id];
    return _db.transaction(() async {
      final foreign =
          await (_db.selectOnly(_db.quizzes)
                ..addColumns([_db.quizzes.id])
                ..where(
                  _db.quizzes.id.isIn(ids) &
                      _db.quizzes.deckId.equals(deck.id).not(),
                )
                ..limit(1))
              .getSingleOrNull();
      if (foreign != null) {
        throw StateError(
          'Quiz ${foreign.read(_db.quizzes.id)} belongs to another deck.',
        );
      }

      final createdAt = {
        for (final row
            in await (_db.selectOnly(_db.quizzes)
                  ..addColumns([_db.quizzes.id, _db.quizzes.createdAtMs])
                  ..where(_db.quizzes.deckId.equals(deck.id)))
                .get())
          row.read(_db.quizzes.id)!: row.read(_db.quizzes.createdAtMs)!,
      };
      final deckQuizIds = _db.selectOnly(_db.quizzes)
        ..addColumns([_db.quizzes.id])
        ..where(_db.quizzes.deckId.equals(deck.id));

      await _db.batch((batch) {
        batch.insertAllOnConflictUpdate(_db.decks, [
          DecksCompanion.insert(
            id: deck.id,
            title: _requireTitle(deck.title),
            description: Value(deck.description),
            author: Value(deck.author),
            locale: Value(deck.locale),
            version: Value(deck.version),
            createdAtMs: deck.createdAt.millisecondsSinceEpoch,
            updatedAtMs: nowMs,
            deletedAtMs: const Value(null),
          ),
        ]);
        batch.insertAllOnConflictUpdate(_db.quizzes, [
          for (final (index, quiz) in content.quizzes.indexed)
            _quizCompanion(
              quiz.copyWith(position: index),
              nowMs,
              createdAt[quiz.id],
            ),
        ]);
        batch.deleteWhere(
          _db.quizOptions,
          (o) => o.quizId.isInQuery(deckQuizIds),
        );
        batch.insertAll(_db.quizOptions, [
          for (final quiz in content.quizzes) ..._optionCompanions(quiz),
        ]);
        batch.insertAll(_db.cardStates, [
          for (final quiz in content.quizzes) _freshCardState(quiz, now),
        ], mode: InsertMode.insertOrIgnore);
        batch.update(
          _db.quizzes,
          QuizzesCompanion(
            deletedAtMs: Value(nowMs),
            updatedAtMs: Value(nowMs),
          ),
          where: (q) =>
              q.deckId.equals(deck.id) &
              q.id.isNotIn(ids) &
              q.deletedAtMs.isNull(),
        );
      });
    });
  }

  Future<void> _writeQuiz(
    Quiz quiz,
    DateTime now, {
    required int? createdAtMs,
  }) async {
    await _db
        .into(_db.quizzes)
        .insertOnConflictUpdate(
          _quizCompanion(quiz, now.millisecondsSinceEpoch, createdAtMs),
        );
    await _db.batch((batch) {
      batch.deleteWhere(_db.quizOptions, (o) => o.quizId.equals(quiz.id));
      batch.insertAll(_db.quizOptions, _optionCompanions(quiz));
      batch.insert(
        _db.cardStates,
        _freshCardState(quiz, now),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  static QuizzesCompanion _quizCompanion(
    Quiz quiz,
    int nowMs,
    int? createdAtMs,
  ) => QuizzesCompanion.insert(
    id: quiz.id,
    deckId: quiz.deckId,
    type: quiz.type.value,
    position: quiz.position,
    question: quiz.question.trim(),
    explanation: Value(quiz.explanation.trim()),
    hint: Value(quiz.hint.trim()),
    createdAtMs: createdAtMs ?? nowMs,
    updatedAtMs: nowMs,
    deletedAtMs: const Value(null),
  );

  static List<QuizOptionsCompanion> _optionCompanions(Quiz quiz) => [
    for (final (index, option) in quiz.options.indexed)
      QuizOptionsCompanion.insert(
        quizId: quiz.id,
        id: option.id,
        position: index,
        body: option.text.trim(),
        prompt: Value(option.prompt.trim()),
        mediaPath: Value(option.mediaPath),
        isCorrect: Value(option.isCorrect),
      ),
  ];

  /// Only inserted when the quiz has no state yet, so progress survives.
  static CardStatesCompanion _freshCardState(Quiz quiz, DateTime now) {
    final fresh = SchedulingCard.fresh(now);
    return CardStatesCompanion.insert(
      quizId: quiz.id,
      deckId: quiz.deckId,
      phase: fresh.phase.value,
      step: Value(fresh.step),
      dueAtMs: fresh.due.millisecondsSinceEpoch,
    );
  }

  Future<int> _nextPosition(String deckId) async {
    final max = _db.quizzes.position.max();
    final row =
        await (_db.selectOnly(_db.quizzes)
              ..addColumns([max])
              ..where(_db.quizzes.deckId.equals(deckId)))
            .getSingle();
    final current = row.read(max);
    return current == null ? 0 : current + 1;
  }

  Future<void> _touchDeck(String deckId, DateTime now) =>
      (_db.update(_db.decks)..where((d) => d.id.equals(deckId))).write(
        DecksCompanion(updatedAtMs: Value(now.millisecondsSinceEpoch)),
      );

  Future<Map<String, List<QuizOptionRow>>> _optionsFor(
    List<String> quizIds,
  ) async {
    final rows =
        await (_db.select(_db.quizOptions)
              ..where((o) => o.quizId.isIn(quizIds))
              ..orderBy([(o) => OrderingTerm.asc(o.position)]))
            .get();
    final grouped = <String, List<QuizOptionRow>>{};
    for (final row in rows) {
      (grouped[row.quizId] ??= []).add(row);
    }
    return grouped;
  }

  List<Quiz> _groupQuizzes(List<TypedResult> rows) {
    final quizzes = <String, QuizRow>{};
    final options = <String, List<QuizOptionRow>>{};
    for (final row in rows) {
      final quiz = row.readTable(_db.quizzes);
      quizzes.putIfAbsent(quiz.id, () => quiz);
      final option = row.readTableOrNull(_db.quizOptions);
      if (option != null) (options[quiz.id] ??= []).add(option);
    }
    return [
      for (final quiz in quizzes.values)
        quizFromRows(quiz, options[quiz.id] ?? const []),
    ];
  }

  // `?1` is the reference time in epoch ms.
  static const _summarySelect =
      'SELECT d.*, '
      'COUNT(q.id) AS quiz_count, '
      'COALESCE(SUM(c.reps > 0 AND c.due_at_ms <= ?1), 0) AS due_count, '
      'COALESCE(SUM(c.reps = 0), 0) AS new_count, '
      'COALESCE(SUM(c.phase = 2), 0) AS learned_count '
      'FROM decks d '
      'LEFT JOIN quizzes q ON q.deck_id = d.id AND q.deleted_at_ms IS NULL '
      'LEFT JOIN card_states c ON c.quiz_id = q.id ';

  DeckSummary _summaryFromRow(QueryRow row) => DeckSummary(
    deck: _deckFromRow(_db.decks.map(row.data)),
    quizCount: row.read<int>('quiz_count'),
    dueCount: row.read<int>('due_count'),
    newCount: row.read<int>('new_count'),
    learnedCount: row.read<int>('learned_count'),
  );

  static String _requireTitle(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(title, 'title', 'must not be empty');
    }
    return trimmed;
  }

  static Deck _deckFromRow(DeckRow row) => Deck(
    id: row.id,
    title: row.title,
    description: row.description,
    author: row.author,
    locale: row.locale,
    version: row.version,
    createdAt: _utc(row.createdAtMs),
    updatedAt: _utc(row.updatedAtMs),
  );

  static DateTime _utc(int ms) =>
      DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
}

final deckRepositoryProvider = Provider<DeckRepository>(
  (ref) =>
      DeckRepository(ref.watch(databaseProvider), ref.watch(clockProvider)),
);
