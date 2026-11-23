import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/app/bootstrap.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/progress/data/progress_repository.dart';
import 'package:qyic/features/settings/settings_repository.dart';
import 'package:qyic/features/study/application/study_session_controller.dart';
import 'package:qyic/features/study/domain/grading.dart';
import 'package:qyic/features/study/domain/study_scope.dart';

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
    await container.read(settingsRepositoryProvider).setNewCardsPerDay(2);
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('a session re-queues learning cards until they graduate', () async {
    final provider = studySessionProvider(const StudyRequest());
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    final controller = container.read(provider.notifier);
    var session = await container.read(provider.future);
    expect(session.queue, hasLength(2));
    expect(session.levelBefore, 1);

    // Wrong answer: Again keeps the card in the session.
    final first = session.current!.quiz.id;
    await expectLater(
      controller.rate(Rating.good, GradeOutcome.incorrect),
      throwsArgumentError,
    );
    await controller.rate(Rating.again, GradeOutcome.incorrect);
    session = container.read(provider).requireValue;
    expect(session.queue.last.quiz.id, first);
    expect(session.total, 3);

    // Easy graduates both cards immediately.
    while (!session.isFinished) {
      clock.advance(const Duration(seconds: 30));
      await controller.rate(Rating.easy, GradeOutcome.selfGraded);
      session = container.read(provider).requireValue;
    }

    expect(session.ratings, [Rating.again, Rating.easy, Rating.easy]);
    expect(session.accuracy, closeTo(2 / 3, 1e-9));
    expect(session.finishedAt, isNotNull);

    final progress = await container
        .read(progressRepositoryProvider)
        .load(clock.now);
    expect(progress.totalReviews, 3);
    expect(progress.totalXp, session.xpEarned);
  });
}
