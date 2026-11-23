import '../../../core/scheduling/fsrs.dart';
import '../../decks/domain/deck.dart';
import '../../decks/domain/quiz_validation.dart';

/// The learner's response to a quiz. Answers stay on the device; only the
/// resulting rating is synced (`docs/deck-format.md` §9).
sealed class QuizAnswer {
  const QuizAnswer();
}

/// Multiple choice and true/false.
class ChoiceAnswer extends QuizAnswer {
  const ChoiceAnswer(this.optionId);

  final String optionId;
}

/// Fill in the blank.
class TextAnswer extends QuizAnswer {
  const TextAnswer(this.text);

  final String text;
}

/// Matching: option id of each left-hand term → option id of the chosen
/// right-hand entry.
class MatchingAnswer extends QuizAnswer {
  const MatchingAnswer(this.pairs);

  final Map<String, String> pairs;
}

/// Flashcards are graded by the learner after revealing the back.
class SelfGradedAnswer extends QuizAnswer {
  const SelfGradedAnswer();
}

enum GradeOutcome {
  correct,
  incorrect,

  /// No objective check (flashcards): the learner picks any rating.
  selfGraded;

  /// An objectively wrong answer is a lapse and can only be rated Again.
  List<Rating> get allowedRatings => switch (this) {
    GradeOutcome.incorrect => const [Rating.again],
    GradeOutcome.correct || GradeOutcome.selfGraded => Rating.values,
  };
}

GradeOutcome grade(Quiz quiz, QuizAnswer answer) {
  switch ((quiz.type, answer)) {
    case (QuizType.flashcard, SelfGradedAnswer()):
      return GradeOutcome.selfGraded;
    case (
      QuizType.multipleChoice || QuizType.trueFalse,
      ChoiceAnswer(:final optionId),
    ):
      final chosen = quiz.options.where((option) => option.id == optionId);
      return chosen.isNotEmpty && chosen.first.isCorrect
          ? GradeOutcome.correct
          : GradeOutcome.incorrect;
    case (QuizType.fillInTheBlank, TextAnswer(:final text)):
      final given = normalizeAnswer(text);
      final accepted = quiz.options.any(
        (option) => normalizeAnswer(option.text) == given,
      );
      return given.isNotEmpty && accepted
          ? GradeOutcome.correct
          : GradeOutcome.incorrect;
    case (QuizType.matching, MatchingAnswer(:final pairs)):
      final complete = pairs.length == quiz.options.length;
      final allMatch = quiz.options.every(
        (option) => pairs[option.id] == option.id,
      );
      return complete && allMatch
          ? GradeOutcome.correct
          : GradeOutcome.incorrect;
    default:
      throw ArgumentError(
        '${answer.runtimeType} cannot answer a ${quiz.type.name} quiz',
      );
  }
}

/// Case-insensitive comparison with surrounding and repeated whitespace
/// ignored.
String normalizeAnswer(String value) =>
    value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

/// Splits a fill-in-the-blank question around its blank marker.
({String before, String after}) splitAtBlank(String question) {
  final match = blankPattern.firstMatch(question);
  if (match == null) return (before: question, after: '');
  return (
    before: question.substring(0, match.start),
    after: question.substring(match.end),
  );
}
