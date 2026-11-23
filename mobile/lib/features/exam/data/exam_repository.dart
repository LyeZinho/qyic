import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids.dart';
import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../../decks/domain/deck.dart';
import '../../study/data/study_repository.dart';
import '../domain/exam.dart';

class ExamRepository {
  ExamRepository(this._db, this._study, this._clock);

  final AppDatabase _db;
  final StudyRepository _study;
  final Clock _clock;

  Stream<List<ExamPreset>> watchPresets() {
    final presets = _db.select(_db.examPresets)
      ..orderBy([(p) => OrderingTerm.asc(p.createdAtMs)]);
    return presets.watch().asyncMap((rows) async {
      final decks = await _db.select(_db.examPresetDecks).get();
      final byPreset = <String, Set<String>>{};
      for (final row in decks) {
        (byPreset[row.presetId] ??= {}).add(row.deckId);
      }
      return [
        for (final row in rows) _presetFromRow(row, byPreset[row.id] ?? {}),
      ];
    });
  }

  /// Inserts or updates [preset]; returns its id.
  Future<String> savePreset(ExamPreset preset) {
    if (preset.validate().isNotEmpty) {
      throw ArgumentError.value(preset, 'preset', 'is invalid');
    }
    final nowMs = _clock().millisecondsSinceEpoch;
    final id = preset.id ?? newUuid();
    return _db.transaction(() async {
      final existing = await (_db.select(
        _db.examPresets,
      )..where((p) => p.id.equals(id))).getSingleOrNull();
      await _db
          .into(_db.examPresets)
          .insertOnConflictUpdate(
            ExamPresetsCompanion.insert(
              id: id,
              name: preset.name.trim(),
              selection: preset.selection.value,
              questionCount: preset.questionCount,
              timeLimitSeconds: preset.timeLimit?.inSeconds ?? 0,
              secondsPerQuestion: preset.timePerQuestion?.inSeconds ?? 0,
              quizTypes: quizTypeMask(preset.quizTypes),
              includeNew: preset.includeNew,
              autoRate: preset.autoRate,
              allowHints: preset.allowHints,
              createdAtMs: existing?.createdAtMs ?? nowMs,
              updatedAtMs: nowMs,
            ),
          );
      await (_db.delete(
        _db.examPresetDecks,
      )..where((d) => d.presetId.equals(id))).go();
      await _db.batch(
        (batch) => batch.insertAll(_db.examPresetDecks, [
          for (final deckId in preset.deckIds)
            ExamPresetDecksCompanion.insert(presetId: id, deckId: deckId),
        ]),
      );
      return id;
    });
  }

  Future<void> deletePreset(String id) =>
      (_db.delete(_db.examPresets)..where((p) => p.id.equals(id))).go();

  /// Up to `preset.questionCount` items for an exam, ordered by
  /// `preset.selection`. Unlike regular study, cards need not be due.
  Future<List<StudyItem>> loadQueue(
    ExamPreset preset, {
    required DateTime now,
    required FsrsScheduler scheduler,
    math.Random? random,
  }) async {
    if (preset.quizTypes.isEmpty) return const [];
    final types = [for (final type in preset.quizTypes) type.value];
    final decks = preset.deckIds.toList();
    final rows = await _db
        .customSelect(
          'SELECT c.* FROM card_states c '
          'JOIN quizzes q ON q.id = c.quiz_id AND q.deleted_at_ms IS NULL '
          'JOIN decks d ON d.id = c.deck_id AND d.deleted_at_ms IS NULL '
          'WHERE q.type IN (${_placeholders(types.length)}) '
          '${preset.includeNew ? '' : 'AND c.reps > 0 '}'
          '${decks.isEmpty ? '' : 'AND c.deck_id IN (${_placeholders(decks.length, from: types.length + 1)}) '}',
          variables: [
            for (final type in types) Variable.withInt(type),
            for (final deck in decks) Variable.withString(deck),
          ],
          readsFrom: {_db.cardStates, _db.quizzes, _db.decks},
        )
        .map((row) => _db.cardStates.map(row.data))
        .get();

    final cards = [
      for (final row in rows) (row.quizId, StudyRepository.cardFromRow(row)),
    ];
    switch (preset.selection) {
      case ExamSelection.weakest:
        // Unseen cards have no retrievability; they follow every seen card.
        double recall(SchedulingCard card) =>
            card.isNew ? 2 : scheduler.retrievability(card, now);
        cards.sort((a, b) => recall(a.$2).compareTo(recall(b.$2)));
      case ExamSelection.random:
        cards.shuffle(random ?? math.Random.secure());
      case ExamSelection.dueFirst:
        cards.sort((a, b) => a.$2.due.compareTo(b.$2.due));
    }

    final picked = cards.take(preset.questionCount).toList();
    final quizzes = await _study.quizzesById([for (final c in picked) c.$1]);
    return [
      for (final (quizId, card) in picked)
        if (quizzes[quizId] case final quiz?) StudyItem(quiz: quiz, card: card),
    ];
  }

  Future<void> saveRun(ExamRun run) => _db
      .into(_db.examRuns)
      .insert(
        ExamRunsCompanion.insert(
          id: run.id,
          presetId: Value(run.presetId),
          name: run.name,
          startedAtMs: run.startedAt.millisecondsSinceEpoch,
          finishedAtMs: run.finishedAt.millisecondsSinceEpoch,
          questionCount: run.questionCount,
          answeredCount: run.answeredCount,
          correctCount: run.correctCount,
          endReason: run.endReason.value,
        ),
      );

  Stream<List<ExamRun>> watchRecentRuns({int limit = 10}) {
    final query = _db.select(_db.examRuns)
      ..orderBy([(r) => OrderingTerm.desc(r.startedAtMs)])
      ..limit(limit);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          ExamRun(
            id: row.id,
            presetId: row.presetId,
            name: row.name,
            startedAt: _utc(row.startedAtMs),
            finishedAt: _utc(row.finishedAtMs),
            questionCount: row.questionCount,
            answeredCount: row.answeredCount,
            correctCount: row.correctCount,
            endReason: ExamEndReason.fromValue(row.endReason),
          ),
      ],
    );
  }

  static int quizTypeMask(Set<QuizType> types) =>
      types.fold(0, (mask, type) => mask | (1 << type.value));

  static Set<QuizType> quizTypesFromMask(int mask) => {
    for (final type in QuizType.values)
      if (mask & (1 << type.value) != 0) type,
  };

  static ExamPreset _presetFromRow(ExamPresetRow row, Set<String> deckIds) =>
      ExamPreset(
        id: row.id,
        name: row.name,
        deckIds: deckIds,
        selection: ExamSelection.fromValue(row.selection),
        questionCount: row.questionCount,
        timeLimit: row.timeLimitSeconds == 0
            ? null
            : Duration(seconds: row.timeLimitSeconds),
        timePerQuestion: row.secondsPerQuestion == 0
            ? null
            : Duration(seconds: row.secondsPerQuestion),
        quizTypes: quizTypesFromMask(row.quizTypes),
        includeNew: row.includeNew,
        autoRate: row.autoRate,
        allowHints: row.allowHints,
      );

  static String _placeholders(int count, {int from = 1}) =>
      List.generate(count, (index) => '?${from + index}').join(', ');

  static DateTime _utc(int ms) =>
      DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
}

final examRepositoryProvider = Provider<ExamRepository>(
  (ref) => ExamRepository(
    ref.watch(databaseProvider),
    ref.watch(studyRepositoryProvider),
    ref.watch(clockProvider),
  ),
);

final examPresetsProvider = StreamProvider<List<ExamPreset>>(
  (ref) => ref.watch(examRepositoryProvider).watchPresets(),
);

final recentExamRunsProvider = StreamProvider.autoDispose<List<ExamRun>>(
  (ref) => ref.watch(examRepositoryProvider).watchRecentRuns(),
);
