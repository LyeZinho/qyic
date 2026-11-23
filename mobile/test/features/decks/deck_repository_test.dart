import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/features/decks/data/deck_repository.dart';
import 'package:qyic/features/decks/data/starter_deck.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/decks/domain/quiz_validation.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late TestClock clock;
  late DeckRepository repository;

  setUp(() {
    db = inMemoryDatabase();
    clock = TestClock(DateTime.utc(2026, 5, 1, 12));
    repository = DeckRepository(db, clock.call);
  });

  tearDown(() => db.close());

  Quiz flashcard(String deckId, String id, {String front = 'Front'}) => Quiz(
    id: id,
    deckId: deckId,
    type: QuizType.flashcard,
    position: 0,
    question: front,
    explanation: 'Back',
    options: const [],
  );

  test('installContent is idempotent and keeps scheduling state', () async {
    final content = starterDeck(clock.now);
    await repository.installContent(content);
    await (db.update(db.cardStates)
          ..where((c) => c.quizId.equals(content.quizzes.first.id)))
        .write(const CardStatesCompanion(reps: Value(3)));

    await repository.installContent(content);

    final summaries = await repository.watchSummaries(clock.now).first;
    expect(summaries, hasLength(1));
    expect(summaries.single.quizCount, content.quizzes.length);
    final state = await (db.select(
      db.cardStates,
    )..where((c) => c.quizId.equals(content.quizzes.first.id))).getSingle();
    expect(state.reps, 3);
  });

  test('reinstalling without a quiz tombstones it', () async {
    final content = starterDeck(clock.now);
    await repository.installContent(content);
    await repository.installContent(
      DeckContent(
        deck: content.deck,
        quizzes: content.quizzes.skip(1).toList(),
      ),
    );

    final quizzes = await repository.watchQuizzes(content.deck.id).first;
    expect(quizzes.map((q) => q.id), isNot(contains(content.quizzes.first.id)));
    final removed = await (db.select(
      db.quizzes,
    )..where((q) => q.id.equals(content.quizzes.first.id))).getSingle();
    expect(removed.deletedAtMs, isNotNull);
  });

  test('saveQuiz appends, preserves options and creates a new card', () async {
    final deckId = await repository.createDeck(title: ' Rust ');
    await repository.saveQuiz(flashcard(deckId, 'q1'));
    await repository.saveQuiz(
      const Quiz(
        id: 'q2',
        deckId: '',
        type: QuizType.multipleChoice,
        position: 0,
        question: 'Which trait?',
        explanation: '',
        options: [
          QuizOption(id: 'a', text: 'Sync'),
          QuizOption(id: 'b', text: 'Send', isCorrect: true),
        ],
      ).copyWithDeck(deckId),
    );

    final quizzes = await repository.watchQuizzes(deckId).first;
    expect(quizzes.map((q) => q.id), ['q1', 'q2']);
    expect(quizzes.last.options.map((o) => o.text), ['Sync', 'Send']);

    final summary = (await repository.watchSummaries(clock.now).first).single;
    expect(summary.deck.title, 'Rust');
    expect(summary.newCount, 2);
    expect(summary.dueCount, 0);
  });

  test('saveQuiz rejects invalid content', () async {
    final deckId = await repository.createDeck(title: 'Deck');
    expect(
      () => repository.saveQuiz(flashcard(deckId, 'q1', front: ' ')),
      throwsA(isA<QuizValidationException>()),
    );
  });

  test('deleteDeck hides the deck but keeps rows', () async {
    final deckId = await repository.createDeck(title: 'Deck');
    await repository.saveQuiz(flashcard(deckId, 'q1'));
    await repository.deleteDeck(deckId);

    expect(await repository.watchSummaries(clock.now).first, isEmpty);
    expect(await repository.watchDeck(deckId).first, isNull);
    expect(await db.select(db.cardStates).get(), hasLength(1));
  });
}

extension on Quiz {
  Quiz copyWithDeck(String deckId) => Quiz(
    id: id,
    deckId: deckId,
    type: type,
    position: position,
    question: question,
    explanation: explanation,
    options: options,
  );
}
