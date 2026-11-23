import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../../progress/data/progress_repository.dart';
import '../../progress/domain/progression.dart';
import '../../settings/settings_repository.dart';
import '../data/study_repository.dart';
import '../domain/grading.dart';
import '../domain/study_scope.dart';

class StudySessionState {
  const StudySessionState({
    required this.queue,
    required this.ratings,
    required this.startedAt,
    required this.levelBefore,
    this.finishedAt,
    this.isSaving = false,
  });

  /// Remaining items; the first one is on screen.
  final List<StudyItem> queue;

  /// Ratings recorded so far, in order.
  final List<Rating> ratings;
  final DateTime startedAt;
  final DateTime? finishedAt;

  /// Level when the session started, to detect level-ups.
  final int levelBefore;
  final bool isSaving;

  StudyItem? get current => queue.isEmpty ? null : queue.first;
  bool get isFinished => queue.isEmpty;
  int get completed => ratings.length;
  int get total => completed + queue.length;

  int get xpEarned =>
      ratings.fold(0, (sum, rating) => sum + Progression.xpFor(rating));

  double get accuracy => ratings.isEmpty
      ? 0
      : ratings.where((r) => r != Rating.again).length / ratings.length;

  StudySessionState copyWith({
    List<StudyItem>? queue,
    List<Rating>? ratings,
    DateTime? finishedAt,
    bool? isSaving,
  }) => StudySessionState(
    queue: queue ?? this.queue,
    ratings: ratings ?? this.ratings,
    startedAt: startedAt,
    levelBefore: levelBefore,
    finishedAt: finishedAt ?? this.finishedAt,
    isSaving: isSaving ?? this.isSaving,
  );
}

/// Drives one study session.
class StudySessionController extends AsyncNotifier<StudySessionState> {
  StudySessionController(this.request);

  final StudyRequest request;

  late FsrsScheduler _scheduler;
  late String _clientId;
  late DateTime _shownAt;

  Clock get _clock => ref.read(clockProvider);

  @override
  Future<StudySessionState> build() async {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final settings = await settingsRepository.load();
    _scheduler = settings.scheduler();
    _clientId = await settingsRepository.clientId();

    final now = _clock();
    final queue = await ref
        .read(studyRepositoryProvider)
        .loadQueue(
          deckId: request.deckId,
          now: now,
          newCardsPerDay: settings.newCardsPerDay,
          types: request.scope.quizTypes,
        );
    final progress = await ref.read(progressRepositoryProvider).load(now);
    _shownAt = _clock();

    return StudySessionState(
      queue: queue,
      ratings: const [],
      startedAt: now,
      levelBefore: progress.level.level,
      finishedAt: queue.isEmpty ? now : null,
    );
  }

  /// Next state of the current card for each rating, for button labels.
  Map<Rating, SchedulingCard> previewCurrent() {
    final current = state.requireValue.current;
    if (current == null) return const {};
    return _scheduler.preview(current.card, _clock());
  }

  /// Persists [rating] for the current card and advances the queue.
  Future<void> rate(Rating rating, GradeOutcome outcome) async {
    final session = state.requireValue;
    final current = session.current;
    if (current == null || session.isSaving) return;
    if (!outcome.allowedRatings.contains(rating)) {
      throw ArgumentError.value(rating, 'rating', 'not allowed for $outcome');
    }

    state = AsyncData(session.copyWith(isSaving: true));
    final reviewedAt = _clock();
    final SchedulingCard next;
    try {
      next = await ref
          .read(studyRepositoryProvider)
          .recordReview(
            quizId: current.quiz.id,
            rating: rating,
            reviewedAt: reviewedAt,
            duration: reviewedAt.difference(_shownAt),
            clientId: _clientId,
            scheduler: _scheduler,
          );
    } catch (_) {
      if (ref.mounted) state = AsyncData(session.copyWith(isSaving: false));
      rethrow;
    }
    if (!ref.mounted) return;

    final requeue =
        next.phase != CardPhase.review &&
        !next.due.isAfter(reviewedAt.add(StudyRepository.learnAhead));
    final queue = [
      ...session.queue.skip(1),
      if (requeue) StudyItem(quiz: current.quiz, card: next),
    ];

    _shownAt = _clock();
    state = AsyncData(
      session.copyWith(
        queue: queue,
        ratings: [...session.ratings, rating],
        finishedAt: queue.isEmpty ? _shownAt : null,
        isSaving: false,
      ),
    );
  }
}

final studySessionProvider = AsyncNotifierProvider.autoDispose
    .family<StudySessionController, StudySessionState, StudyRequest>(
      StudySessionController.new,
    );
