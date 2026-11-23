import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/app/bootstrap.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/exam/application/exam_session_controller.dart';
import 'package:qyic/features/exam/data/exam_repository.dart';
import 'package:qyic/features/exam/domain/exam.dart';
import 'package:qyic/features/study/domain/grading.dart';
import 'package:qyic/features/study/domain/review_mode.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late TestClock clock;
  late ProviderContainer container;

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
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  /// Starts an exam and keeps its auto-dispose provider alive.
  Future<(ExamSessionController, ExamSessionState Function())> start(
    ExamPreset preset,
  ) async {
    final provider = examSessionProvider(preset);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(provider.future);
    return (
      container.read(provider.notifier),
      () => container.read(provider).requireValue,
    );
  }

  /// Timers and unawaited saves complete on the real event loop.
  Future<void> until(bool Function() condition) async {
    for (var attempt = 0; attempt < 200; attempt++) {
      if (condition()) return;
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }
    fail('Condition not reached');
  }

  Future<List<ReviewEventRow>> reviews() => db.select(db.reviewEvents).get();

  Future<List<ExamRun>> runs() =>
      container.read(examRepositoryProvider).watchRecentRuns().first;

  /// [ExamSessionController.finish] stores the run after ending the exam.
  Future<List<ExamRun>> savedRuns() => container
      .read(examRepositoryProvider)
      .watchRecentRuns()
      .firstWhere((runs) => runs.isNotEmpty);

  test('auto-rates objective answers and records exam reviews', () async {
    final (controller, state) = await start(
      const ExamPreset(
        name: 'Mock',
        includeNew: true,
        quizTypes: {QuizType.multipleChoice},
      ),
    );
    expect(state().queue, hasLength(2));

    await controller.answer(GradeOutcome.correct);
    expect(state().phase, ExamPhase.feedback);
    expect(state().currentAnswer!.rating, Rating.good);
    controller.next();
    expect(state().phase, ExamPhase.answering);
    expect(state().index, 1);

    await controller.answer(GradeOutcome.incorrect);
    expect(state().currentAnswer!.rating, Rating.again);
    controller.next();
    await until(() => state().isFinished);

    expect(state().endReason, ExamEndReason.completed);
    expect(state().correctCount, 1);
    final events = await reviews();
    expect(events.map((e) => e.mode), [
      ReviewMode.exam.value,
      ReviewMode.exam.value,
    ]);
    final [run] = await savedRuns();
    expect((run.questionCount, run.answeredCount, run.correctCount), (2, 2, 1));
    expect(run.presetId, isNull);
  });

  test('self-graded cards ask for a rating and then move on', () async {
    final (controller, state) = await start(
      const ExamPreset(
        name: 'Mock',
        includeNew: true,
        quizTypes: {QuizType.flashcard},
      ),
    );

    await controller.answer(GradeOutcome.selfGraded);
    expect(state().phase, ExamPhase.rating);
    expect(await reviews(), isEmpty);

    await controller.rate(Rating.good);
    expect(state().phase, ExamPhase.answering);
    expect(state().index, 1);

    await controller.answer(GradeOutcome.selfGraded);
    await controller.rate(Rating.again);
    await until(() => state().isFinished);
    expect(state().answers.map((a) => a.isCorrect), [true, false]);
  });

  test('an expired question counts as a wrong answer', () async {
    final (_, state) = await start(
      const ExamPreset(
        name: 'Mock',
        includeNew: true,
        quizTypes: {QuizType.trueFalse},
        timePerQuestion: Duration(milliseconds: 20),
      ),
    );

    await until(() => state().phase == ExamPhase.feedback);
    final answer = state().currentAnswer!;
    expect(answer.timedOut, isTrue);
    expect(answer.outcome, GradeOutcome.incorrect);
    expect(answer.rating, Rating.again);
  });

  test('the exam deadline waits for the card being reviewed', () async {
    final (controller, state) = await start(
      const ExamPreset(
        name: 'Mock',
        includeNew: true,
        quizTypes: {QuizType.matching},
        timeLimit: Duration(milliseconds: 40),
        timePerQuestion: null,
      ),
    );

    await controller.answer(GradeOutcome.correct);
    await until(() => state().timeUp);
    expect(state().isFinished, isFalse);

    controller.next();
    await until(() => state().isFinished);
    expect(state().endReason, ExamEndReason.timeUp);
    final [run] = await savedRuns();
    expect((run.questionCount, run.answeredCount), (2, 1));
    expect(run.endReason, ExamEndReason.timeUp);
  });

  test('stopping before any answer keeps no history', () async {
    final (controller, state) = await start(
      const ExamPreset(name: 'Mock', includeNew: true),
    );
    await controller.finish(ExamEndReason.stopped);
    expect(state().endReason, ExamEndReason.stopped);
    expect(await runs(), isEmpty);
  });
}
