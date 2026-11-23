import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ids.dart';
import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../../settings/settings_repository.dart';
import '../../study/data/study_repository.dart';
import '../../study/domain/grading.dart';
import '../../study/domain/review_mode.dart';
import '../data/exam_repository.dart';
import '../domain/exam.dart';

enum ExamPhase {
  /// The current question is on screen and its timer (if any) runs.
  answering,

  /// Answered; waiting for the learner's rating (self-graded cards, or any
  /// card when auto-rating is off).
  rating,

  /// Answered and recorded; showing feedback until the learner moves on.
  feedback,
}

class ExamAnswer {
  const ExamAnswer({
    required this.item,
    required this.outcome,
    required this.rating,
    required this.timedOut,
  });

  final StudyItem item;
  final GradeOutcome outcome;
  final Rating rating;
  final bool timedOut;

  /// Objectively correct, or a self-graded card the learner did not fail.
  bool get isCorrect => switch (outcome) {
    GradeOutcome.correct => true,
    GradeOutcome.incorrect => false,
    GradeOutcome.selfGraded => rating != Rating.again,
  };
}

class ExamSessionState {
  const ExamSessionState({
    required this.preset,
    required this.queue,
    required this.answers,
    required this.startedAt,
    required this.questionStartedAt,
    required this.phase,
    this.pendingOutcome,
    this.timeUp = false,
    this.isSaving = false,
    this.endReason,
    this.finishedAt,
  });

  final ExamPreset preset;
  final List<StudyItem> queue;
  final List<ExamAnswer> answers;
  final DateTime startedAt;
  final DateTime questionStartedAt;
  final ExamPhase phase;

  /// The outcome awaiting a rating in [ExamPhase.rating].
  final GradeOutcome? pendingOutcome;

  /// The whole-exam limit passed while a card was being rated or reviewed;
  /// the exam ends once that card is done.
  final bool timeUp;
  final bool isSaving;
  final ExamEndReason? endReason;
  final DateTime? finishedAt;

  bool get isFinished => endReason != null;

  /// Index of the question on screen.
  int get index =>
      phase == ExamPhase.feedback ? answers.length - 1 : answers.length;

  StudyItem? get current => index < queue.length ? queue[index] : null;
  int get correctCount => answers.where((a) => a.isCorrect).length;

  /// The answer to the question on screen, once it has been recorded.
  ExamAnswer? get currentAnswer =>
      phase == ExamPhase.feedback ? answers.last : null;

  DateTime? get deadline => switch (preset.timeLimit) {
    final limit? => startedAt.add(limit),
    null => null,
  };

  DateTime? get questionDeadline => switch (preset.timePerQuestion) {
    final limit? when phase == ExamPhase.answering => questionStartedAt.add(
      limit,
    ),
    _ => null,
  };

  ExamSessionState copyWith({
    List<ExamAnswer>? answers,
    DateTime? questionStartedAt,
    ExamPhase? phase,
    GradeOutcome? Function()? pendingOutcome,
    bool? timeUp,
    bool? isSaving,
    ExamEndReason? endReason,
    DateTime? finishedAt,
  }) => ExamSessionState(
    preset: preset,
    queue: queue,
    answers: answers ?? this.answers,
    startedAt: startedAt,
    questionStartedAt: questionStartedAt ?? this.questionStartedAt,
    phase: phase ?? this.phase,
    pendingOutcome: pendingOutcome != null
        ? pendingOutcome()
        : this.pendingOutcome,
    timeUp: timeUp ?? this.timeUp,
    isSaving: isSaving ?? this.isSaving,
    endReason: endReason ?? this.endReason,
    finishedAt: finishedAt ?? this.finishedAt,
  );
}

/// Drives one exam. Reviews are real (`ReviewMode.exam`): they update the
/// FSRS schedule and count towards progress like regular study.
class ExamSessionController extends AsyncNotifier<ExamSessionState> {
  ExamSessionController(this.preset);

  final ExamPreset preset;

  late FsrsScheduler _scheduler;
  late String _clientId;
  Timer? _questionTimer;
  Timer? _examTimer;

  Clock get _clock => ref.read(clockProvider);

  @override
  Future<ExamSessionState> build() async {
    ref.onDispose(() {
      _questionTimer?.cancel();
      _examTimer?.cancel();
    });
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final settings = await settingsRepository.load();
    _scheduler = settings.scheduler();
    _clientId = await settingsRepository.clientId();

    final now = _clock();
    final queue = await ref
        .read(examRepositoryProvider)
        .loadQueue(preset, now: now, scheduler: _scheduler);
    final started = _clock();
    final session = ExamSessionState(
      preset: preset,
      queue: queue,
      answers: const [],
      startedAt: started,
      questionStartedAt: started,
      phase: ExamPhase.answering,
      endReason: queue.isEmpty ? ExamEndReason.completed : null,
      finishedAt: queue.isEmpty ? started : null,
    );
    if (queue.isNotEmpty) {
      if (preset.timeLimit case final limit?) {
        _examTimer = Timer(limit, _onExamTimeUp);
      }
      _armQuestionTimer();
    }
    return session;
  }

  /// Reports the learner's answer to the current question.
  Future<void> answer(GradeOutcome outcome) async {
    final session = state.requireValue;
    if (session.phase != ExamPhase.answering || session.isFinished) return;
    _questionTimer?.cancel();

    final rating = preset.autoRate
        ? autoRating(
            outcome,
            _clock().difference(session.questionStartedAt),
            preset.timePerQuestion,
          )
        : null;
    if (rating == null) {
      state = AsyncData(
        session.copyWith(
          phase: ExamPhase.rating,
          pendingOutcome: () => outcome,
        ),
      );
      return;
    }
    await _record(session, outcome, rating, timedOut: false);
  }

  /// Rates the answered question in [ExamPhase.rating] and moves on.
  Future<void> rate(Rating rating) async {
    final session = state.requireValue;
    final outcome = session.pendingOutcome;
    if (session.phase != ExamPhase.rating || outcome == null) return;
    if (!outcome.allowedRatings.contains(rating)) {
      throw ArgumentError.value(rating, 'rating', 'not allowed for $outcome');
    }
    if (await _record(session, outcome, rating, timedOut: false)) next();
  }

  /// Leaves [ExamPhase.feedback] for the next question, or ends the exam.
  void next() {
    final session = state.requireValue;
    if (session.phase != ExamPhase.feedback || session.isSaving) return;
    if (session.timeUp) {
      unawaited(finish(ExamEndReason.timeUp));
      return;
    }
    if (session.answers.length == session.queue.length) {
      unawaited(finish(ExamEndReason.completed));
      return;
    }
    state = AsyncData(
      session.copyWith(phase: ExamPhase.answering, questionStartedAt: _clock()),
    );
    _armQuestionTimer();
  }

  /// Ends the exam and stores it in the history. Unanswered questions are
  /// left unreviewed.
  Future<void> finish(ExamEndReason reason) async {
    final session = state.requireValue;
    if (session.isFinished) return;
    _questionTimer?.cancel();
    _examTimer?.cancel();

    final finishedAt = _clock();
    state = AsyncData(
      session.copyWith(endReason: reason, finishedAt: finishedAt),
    );
    if (session.answers.isEmpty) return;
    await ref
        .read(examRepositoryProvider)
        .saveRun(
          ExamRun(
            id: newUuid(),
            presetId: preset.id,
            name: preset.name,
            startedAt: session.startedAt,
            finishedAt: finishedAt,
            questionCount: session.queue.length,
            answeredCount: session.answers.length,
            correctCount: session.correctCount,
            endReason: reason,
          ),
        );
  }

  /// Next state of the current card for each rating, for button labels.
  Map<Rating, SchedulingCard> previewCurrent() {
    final current = state.requireValue.current;
    if (current == null) return const {};
    return _scheduler.preview(current.card, _clock());
  }

  void _armQuestionTimer() {
    _questionTimer?.cancel();
    if (preset.timePerQuestion case final limit?) {
      _questionTimer = Timer(limit, _onQuestionTimeUp);
    }
  }

  void _onQuestionTimeUp() {
    final session = state.value;
    if (session == null ||
        session.phase != ExamPhase.answering ||
        session.isFinished) {
      return;
    }
    unawaited(
      _record(session, GradeOutcome.incorrect, Rating.again, timedOut: true),
    );
  }

  void _onExamTimeUp() {
    final session = state.value;
    if (session == null || session.isFinished) return;
    if (session.phase == ExamPhase.answering && !session.isSaving) {
      unawaited(finish(ExamEndReason.timeUp));
    } else {
      state = AsyncData(session.copyWith(timeUp: true));
    }
  }

  /// Persists one review and switches to [ExamPhase.feedback]. Returns
  /// false if saving failed (the state is restored and the error rethrown).
  Future<bool> _record(
    ExamSessionState session,
    GradeOutcome outcome,
    Rating rating, {
    required bool timedOut,
  }) async {
    final item = session.current;
    if (item == null || session.isSaving) return false;
    state = AsyncData(session.copyWith(isSaving: true));
    final reviewedAt = _clock();
    try {
      await ref
          .read(studyRepositoryProvider)
          .recordReview(
            quizId: item.quiz.id,
            rating: rating,
            reviewedAt: reviewedAt,
            duration: reviewedAt.difference(session.questionStartedAt),
            clientId: _clientId,
            scheduler: _scheduler,
            mode: ReviewMode.exam,
          );
    } catch (_) {
      if (ref.mounted) state = AsyncData(session.copyWith(isSaving: false));
      rethrow;
    }
    if (!ref.mounted) return false;

    // Re-read: the exam timer may have flagged time-up while saving.
    final latest = state.requireValue;
    state = AsyncData(
      latest.copyWith(
        answers: [
          ...latest.answers,
          ExamAnswer(
            item: item,
            outcome: outcome,
            rating: rating,
            timedOut: timedOut,
          ),
        ],
        phase: ExamPhase.feedback,
        pendingOutcome: () => null,
        isSaving: false,
      ),
    );
    return true;
  }
}

final examSessionProvider = AsyncNotifierProvider.autoDispose
    .family<ExamSessionController, ExamSessionState, ExamPreset>(
      ExamSessionController.new,
    );
