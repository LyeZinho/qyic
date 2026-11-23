import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../settings/settings_repository.dart';
import '../../study/data/study_repository.dart';
import '../../study/domain/study_scope.dart';
import '../data/deck_repository.dart';
import '../domain/deck.dart';

final deckSummariesProvider = StreamProvider.autoDispose<List<DeckSummary>>(
  (ref) => ref.watch(deckRepositoryProvider).watchSummaries(watchNow(ref)),
);

final deckProvider = StreamProvider.autoDispose.family<Deck?, String>(
  (ref, deckId) => ref.watch(deckRepositoryProvider).watchDeck(deckId),
);

final deckStatsProvider = StreamProvider.autoDispose.family<DeckStats?, String>(
  (ref, deckId) =>
      ref.watch(deckRepositoryProvider).watchStats(deckId, watchNow(ref)),
);

final deckQuizSummariesProvider = StreamProvider.autoDispose
    .family<List<QuizSummary>, String>(
      (ref, deckId) =>
          ref.watch(deckRepositoryProvider).watchQuizSummaries(deckId),
    );

/// What a study session would contain right now.
final studyCountsProvider = StreamProvider.autoDispose
    .family<StudyCounts, StudyRequest>((ref, request) async* {
      final now = watchNow(ref);
      final repository = ref.watch(studyRepositoryProvider);
      final settings = await ref.watch(settingsProvider.future);
      yield* repository.watchCounts(
        deckId: request.deckId,
        now: now,
        newCardsPerDay: settings.newCardsPerDay,
        types: request.scope.quizTypes,
      );
    });
