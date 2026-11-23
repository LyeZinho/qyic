import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/decks/data/deck_repository.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/decks/data/starter_deck.dart';
import 'package:qyic/features/study/data/study_repository.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late TestClock clock;
  late StudyRepository study;
  late List<String> quizIds;
  final scheduler = FsrsScheduler();

  setUp(() async {
    db = inMemoryDatabase();
    clock = TestClock(DateTime.utc(2026, 5, 1, 12));
    study = StudyRepository(db);
    final content = starterDeck(clock.now);
    quizIds = content.quizzes.map((q) => q.id).toList();
    await DeckRepository(db, clock.call).installContent(content);
  });

  tearDown(() => db.close());

  Future<SchedulingCard> review(String quizId, Rating rating) =>
      study.recordReview(
        quizId: quizId,
        rating: rating,
        reviewedAt: clock.now,
        duration: const Duration(seconds: 8),
        clientId: 'device-1',
        scheduler: scheduler,
      );

  test('new cards are capped by the daily allowance', () async {
    final queue = await study.loadQueue(
      deckId: null,
      now: clock.now,
      newCardsPerDay: 3,
    );
    expect(queue.map((item) => item.quiz.id), quizIds.take(3));
    final flashcards = await study.loadQueue(
      deckId: null,
      now: clock.now,
      newCardsPerDay: 100,
      types: {QuizType.flashcard},
    );
    expect(flashcards, isNotEmpty);
    expect(
      flashcards.every((item) => item.quiz.type == QuizType.flashcard),
      isTrue,
    );
    expect(queue.every((item) => item.card.isNew), isTrue);
  });

  test('cards introduced today count against the allowance', () async {
    await review(quizIds[0], Rating.easy);
    await review(quizIds[1], Rating.easy);

    final queue = await study.loadQueue(
      deckId: null,
      now: clock.now,
      newCardsPerDay: 3,
    );
    expect(queue.map((item) => item.quiz.id), [quizIds[2]]);

    final counts = await study
        .watchCounts(deckId: null, now: clock.now, newCardsPerDay: 3)
        .first;
    expect(counts.fresh, 1);
    expect(counts.due, 0);
  });

  test('recordReview updates state and appends sequenced events', () async {
    final first = await review(quizIds[0], Rating.again);
    expect(first.phase, CardPhase.learning);
    expect(first.due, clock.now.add(const Duration(minutes: 1)));

    clock.advance(const Duration(minutes: 1));
    await review(quizIds[0], Rating.good);

    final events = await (db.select(
      db.reviewEvents,
    )..orderBy([(e) => OrderingTerm.asc(e.clientSeq)])).get();
    expect(events.map((e) => e.clientSeq), [1, 2]);
    expect(events.map((e) => e.rating), [1, 3]);
    expect(events.first.deckId, isNotEmpty);
    expect(events.first.durationMs, 8000);

    final row = await (db.select(
      db.cardStates,
    )..where((c) => c.quizId.equals(quizIds[0]))).getSingle();
    expect(row.reps, 2);
    expect(row.lapses, 0);
  });

  test('learning cards within the learn-ahead window are due', () async {
    await review(quizIds[0], Rating.good);

    final queue = await study.loadQueue(
      deckId: null,
      now: clock.now,
      newCardsPerDay: 0,
    );
    expect(queue.map((item) => item.quiz.id), [quizIds[0]]);
  });

  test('graduated cards return once their interval passes', () async {
    await review(quizIds[0], Rating.easy);
    final later = await study.loadQueue(
      deckId: null,
      now: clock.now.add(const Duration(hours: 1)),
      newCardsPerDay: 0,
    );
    expect(later, isEmpty);

    final row = await (db.select(
      db.cardStates,
    )..where((c) => c.quizId.equals(quizIds[0]))).getSingle();
    final due = DateTime.fromMillisecondsSinceEpoch(row.dueAtMs, isUtc: true);
    final queue = await study.loadQueue(
      deckId: null,
      now: due,
      newCardsPerDay: 0,
    );
    expect(queue.single.card.phase, CardPhase.review);
  });

  test('a lapse in review increments lapses', () async {
    final graduated = await review(quizIds[0], Rating.easy);
    clock.now = graduated.due;
    final lapsed = await review(quizIds[0], Rating.again);
    expect(lapsed.phase, CardPhase.relearning);

    final row = await (db.select(
      db.cardStates,
    )..where((c) => c.quizId.equals(quizIds[0]))).getSingle();
    expect(row.lapses, 1);
  });
}
