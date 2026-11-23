import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/app/bootstrap.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/exam/data/exam_repository.dart';
import 'package:qyic/features/exam/domain/exam.dart';
import 'package:qyic/features/settings/settings_repository.dart';
import 'package:qyic/features/study/data/study_repository.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late TestClock clock;
  late ProviderContainer container;
  late ExamRepository exams;
  late FsrsScheduler scheduler;
  late List<QuizRow> quizzes;

  List<String> idsOf(QuizType type) => [
    for (final quiz in quizzes)
      if (quiz.type == type.value) quiz.id,
  ];

  Future<void> review(String quizId, Rating rating) async {
    final settings = container.read(settingsRepositoryProvider);
    await container
        .read(studyRepositoryProvider)
        .recordReview(
          quizId: quizId,
          rating: rating,
          reviewedAt: clock.now,
          duration: const Duration(seconds: 5),
          clientId: await settings.clientId(),
          scheduler: scheduler,
        );
  }

  Future<List<String>> queue(ExamPreset preset) async => [
    for (final item in await exams.loadQueue(
      preset,
      now: clock.now,
      scheduler: scheduler,
    ))
      item.quiz.id,
  ];

  setUp(() async {
    db = inMemoryDatabase();
    clock = TestClock(DateTime.utc(2026, 5, 1, 12));
    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(clock.call),
      ],
    );
    await container.read(appBootstrapProvider.future);
    exams = container.read(examRepositoryProvider);
    scheduler = (await container.read(settingsRepositoryProvider).load())
        .scheduler();
    quizzes = await db.select(db.quizzes).get();
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('loadQueue', () {
    test('draws only studied cards unless new cards are included', () async {
      const preset = ExamPreset(name: 'Mock');
      expect(await queue(preset), isEmpty);
      // The starter deck has two cards of each type; flashcards are not in
      // the default type set.
      expect(await queue(preset.copyWith(includeNew: true)), hasLength(8));
      expect(
        await queue(
          preset.copyWith(includeNew: true, quizTypes: {QuizType.flashcard}),
        ),
        unorderedEquals(idsOf(QuizType.flashcard)),
      );
    });

    test('orders by predicted recall or due date', () async {
      final [weak, strong] = idsOf(QuizType.multipleChoice);
      final [medium, _] = idsOf(QuizType.trueFalse);
      await review(weak, Rating.again);
      await review(medium, Rating.good);
      await review(strong, Rating.easy);
      clock.advance(const Duration(days: 3));

      const preset = ExamPreset(name: 'Mock');
      expect(await queue(preset), [weak, medium, strong]);
      expect(await queue(preset.copyWith(selection: ExamSelection.dueFirst)), [
        weak,
        medium,
        strong,
      ]);

      // Unseen cards follow every seen card.
      final withNew = await queue(preset.copyWith(includeNew: true));
      expect(withNew.take(3), [weak, medium, strong]);
      expect(withNew, hasLength(8));
    });

    test('filters by deck and caps the question count', () async {
      const preset = ExamPreset(name: 'Mock', includeNew: true);
      final deckId = quizzes.first.deckId;
      expect(await queue(preset.copyWith(deckIds: {deckId})), hasLength(8));
      expect(await queue(preset.copyWith(deckIds: {'not-installed'})), isEmpty);
      expect(await queue(preset.copyWith(questionCount: 5)), hasLength(5));
    });
  });

  test('presets are saved, updated, and deleted with their decks', () async {
    final deckId = quizzes.first.deckId;
    final id = await exams.savePreset(
      ExamPreset(
        name: '  Weekly  ',
        deckIds: {deckId},
        selection: ExamSelection.random,
        timeLimit: const Duration(minutes: 15),
        timePerQuestion: null,
        quizTypes: const {QuizType.matching},
        allowHints: true,
      ),
    );

    var saved = (await exams.watchPresets().first).single;
    expect(saved.id, id);
    expect(saved.name, 'Weekly');
    expect(saved.deckIds, {deckId});
    expect(saved.selection, ExamSelection.random);
    expect(saved.timeLimit, const Duration(minutes: 15));
    expect(saved.timePerQuestion, isNull);
    expect(saved.quizTypes, {QuizType.matching});
    expect(saved.allowHints, isTrue);

    await exams.savePreset(saved.copyWith(deckIds: {}, questionCount: 50));
    saved = (await exams.watchPresets().first).single;
    expect(saved.id, id);
    expect(saved.deckIds, isEmpty);
    expect(saved.questionCount, 50);

    expect(
      () => exams.savePreset(saved.copyWith(name: '')),
      throwsArgumentError,
    );

    await exams.deletePreset(id);
    expect(await exams.watchPresets().first, isEmpty);
  });

  test('recent runs are listed newest first', () async {
    ExamRun run(String id, DateTime startedAt) => ExamRun(
      id: id,
      presetId: null,
      name: 'Quick exam',
      startedAt: startedAt,
      finishedAt: startedAt.add(const Duration(minutes: 3)),
      questionCount: 10,
      answeredCount: 10,
      correctCount: 7,
      endReason: ExamEndReason.completed,
    );
    await exams.saveRun(run('old', clock.now));
    await exams.saveRun(run('new', clock.now.add(const Duration(hours: 1))));

    final runs = await exams.watchRecentRuns().first;
    expect(runs.map((r) => r.id), ['new', 'old']);
    expect(runs.first.startedAt, clock.now.add(const Duration(hours: 1)));
    expect(runs.first.endReason, ExamEndReason.completed);
  });
}
