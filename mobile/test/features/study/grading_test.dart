import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/study/domain/grading.dart';

Quiz _quiz(QuizType type, List<QuizOption> options, {String question = 'Q'}) =>
    Quiz(
      id: 'q',
      deckId: 'd',
      type: type,
      position: 0,
      question: question,
      explanation: 'E',
      options: options,
    );

void main() {
  final choice = _quiz(QuizType.multipleChoice, const [
    QuizOption(id: 'a', text: 'Sync'),
    QuizOption(id: 'b', text: 'Send', isCorrect: true),
  ]);

  test('choice answers are graded by the correct flag', () {
    expect(grade(choice, const ChoiceAnswer('b')), GradeOutcome.correct);
    expect(grade(choice, const ChoiceAnswer('a')), GradeOutcome.incorrect);
    expect(grade(choice, const ChoiceAnswer('zzz')), GradeOutcome.incorrect);
  });

  test('typed answers ignore case and surrounding/repeated whitespace', () {
    final quiz = _quiz(QuizType.fillInTheBlank, const [
      QuizOption(id: 'a', text: 'Protocol Buffers', isCorrect: true),
      QuizOption(id: 'b', text: 'Protobuf', isCorrect: true),
    ], question: 'Serialized with ___.');
    expect(
      grade(quiz, const TextAnswer('  protocol   BUFFERS ')),
      GradeOutcome.correct,
    );
    expect(grade(quiz, const TextAnswer('protobuf')), GradeOutcome.correct);
    expect(grade(quiz, const TextAnswer('JSON')), GradeOutcome.incorrect);
    expect(grade(quiz, const TextAnswer('   ')), GradeOutcome.incorrect);
  });

  test('matching requires every pair to be right', () {
    final quiz = _quiz(QuizType.matching, const [
      QuizOption(id: 'p1', prompt: 'Mobile', text: 'Flutter'),
      QuizOption(id: 'p2', prompt: 'Web', text: 'SvelteKit'),
    ]);
    expect(
      grade(quiz, const MatchingAnswer({'p1': 'p1', 'p2': 'p2'})),
      GradeOutcome.correct,
    );
    expect(
      grade(quiz, const MatchingAnswer({'p1': 'p2', 'p2': 'p1'})),
      GradeOutcome.incorrect,
    );
    expect(
      grade(quiz, const MatchingAnswer({'p1': 'p1'})),
      GradeOutcome.incorrect,
    );
  });

  test('flashcards are self-graded', () {
    final quiz = _quiz(QuizType.flashcard, const []);
    expect(grade(quiz, const SelfGradedAnswer()), GradeOutcome.selfGraded);
  });

  test('mismatched answer kinds are rejected', () {
    expect(() => grade(choice, const TextAnswer('x')), throwsArgumentError);
  });

  test('a wrong answer only allows Again', () {
    expect(GradeOutcome.incorrect.allowedRatings, [Rating.again]);
    expect(GradeOutcome.correct.allowedRatings, Rating.values);
  });

  test('splitAtBlank splits around the marker', () {
    final parts = splitAtBlank('A ____ B');
    expect(parts.before, 'A ');
    expect(parts.after, ' B');
  });
}
