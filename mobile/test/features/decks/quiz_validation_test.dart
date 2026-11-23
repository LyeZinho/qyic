import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/features/decks/data/starter_deck.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/decks/domain/quiz_validation.dart';

Quiz _quiz(
  QuizType type, {
  String question = 'Question?',
  String explanation = 'Because.',
  List<QuizOption> options = const [],
}) => Quiz(
  id: 'q',
  deckId: 'd',
  type: type,
  position: 0,
  question: question,
  explanation: explanation,
  options: options,
);

void main() {
  test('the starter deck is valid', () {
    for (final quiz in starterDeck(DateTime.utc(2026)).quizzes) {
      expect(validateQuiz(quiz), isEmpty, reason: quiz.question);
    }
  });

  group('multiple choice', () {
    test('requires exactly one correct option', () {
      final none = _quiz(
        QuizType.multipleChoice,
        options: const [
          QuizOption(id: 'a', text: 'A'),
          QuizOption(id: 'b', text: 'B'),
        ],
      );
      final two = _quiz(
        QuizType.multipleChoice,
        options: const [
          QuizOption(id: 'a', text: 'A', isCorrect: true),
          QuizOption(id: 'b', text: 'B', isCorrect: true),
        ],
      );
      expect(validateQuiz(none), contains(QuizIssue.notOneCorrect));
      expect(validateQuiz(two), contains(QuizIssue.notOneCorrect));
    });

    test('rejects blank and duplicate options', () {
      final blank = _quiz(
        QuizType.multipleChoice,
        options: const [
          QuizOption(id: 'a', text: 'A', isCorrect: true),
          QuizOption(id: 'b', text: '  '),
        ],
      );
      final duplicate = _quiz(
        QuizType.multipleChoice,
        options: const [
          QuizOption(id: 'a', text: 'Same', isCorrect: true),
          QuizOption(id: 'b', text: 'same '),
        ],
      );
      expect(validateQuiz(blank), contains(QuizIssue.emptyOptions));
      expect(validateQuiz(duplicate), contains(QuizIssue.duplicateOptions));
    });
  });

  test('flashcards need a back and no options', () {
    final quiz = _quiz(
      QuizType.flashcard,
      explanation: '',
      options: const [QuizOption(id: 'a', text: 'A')],
    );
    expect(
      validateQuiz(quiz),
      containsAll([QuizIssue.emptyBack, QuizIssue.flashcardOptions]),
    );
  });

  test('fill in the blank needs exactly one blank marker', () {
    const answers = [QuizOption(id: 'a', text: 'x', isCorrect: true)];
    expect(
      validateQuiz(
        _quiz(QuizType.fillInTheBlank, question: 'No blank', options: answers),
      ),
      contains(QuizIssue.notOneBlank),
    );
    expect(
      validateQuiz(
        _quiz(
          QuizType.fillInTheBlank,
          question: 'Two ___ and ___',
          options: answers,
        ),
      ),
      contains(QuizIssue.notOneBlank),
    );
    expect(
      validateQuiz(
        _quiz(QuizType.fillInTheBlank, question: 'One ___.', options: answers),
      ),
      isEmpty,
    );
  });

  test('matching pairs need both sides', () {
    final quiz = _quiz(
      QuizType.matching,
      options: const [
        QuizOption(id: 'a', prompt: 'Term', text: 'Match'),
        QuizOption(id: 'b', prompt: '', text: 'Other'),
      ],
    );
    expect(validateQuiz(quiz), contains(QuizIssue.emptyPairSide));
  });

  test('option ids must be unique', () {
    final quiz = _quiz(
      QuizType.multipleChoice,
      options: const [
        QuizOption(id: 'a', text: 'A', isCorrect: true),
        QuizOption(id: 'a', text: 'B'),
      ],
    );
    expect(validateQuiz(quiz), contains(QuizIssue.duplicateOptionIds));
  });
}
