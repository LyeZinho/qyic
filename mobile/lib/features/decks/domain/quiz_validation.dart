import 'deck.dart';

/// Blank marker for [QuizType.fillInTheBlank]: three or more underscores.
final blankPattern = RegExp(r'_{3,}');

/// A broken content invariant. [description] is English diagnostic text for
/// logs and exceptions; the UI shows a localized label (`l10n/labels.dart`).
enum QuizIssue {
  emptyQuestion('The question must not be empty.'),
  emptyFront('The front must not be empty.'),
  duplicateOptionIds('Option ids must be unique.'),
  tooFewOptions('Add at least two options.'),
  emptyOptions('Options must not be empty.'),
  duplicateOptions('Options must be distinct.'),
  notOneCorrect('Mark exactly one correct option.'),
  trueFalseOptions('True/false needs the options "true" and "false".'),
  trueFalseNoAnswer('Choose whether the statement holds.'),
  emptyBack('The back must not be empty.'),
  flashcardOptions('Flashcards have no options.'),
  notOneBlank('Mark exactly one blank with "___" in the sentence.'),
  noAnswers('Add at least one accepted answer.'),
  emptyAnswers('Accepted answers must not be empty.'),
  answerNotCorrect('Every accepted answer must be marked correct.'),
  tooFewPairs('Add at least two pairs.'),
  emptyPairSide('Both sides of every pair must be filled in.'),
  duplicatePairs('Terms and matches must be distinct.');

  const QuizIssue(this.description);

  final String description;
}

class QuizValidationException implements Exception {
  const QuizValidationException(this.issues);

  final List<QuizIssue> issues;

  @override
  String toString() =>
      'QuizValidationException: '
      '${issues.map((issue) => issue.description).join(' ')}';
}

/// Content invariants from `docs/deck-format.md` §3 and §5. An empty list
/// means the quiz is valid.
List<QuizIssue> validateQuiz(Quiz quiz) {
  final issues = <QuizIssue>[];
  final options = quiz.options;

  if (quiz.question.trim().isEmpty) {
    issues.add(
      quiz.type == QuizType.flashcard
          ? QuizIssue.emptyFront
          : QuizIssue.emptyQuestion,
    );
  }

  final ids = options.map((option) => option.id).toSet();
  if (ids.length != options.length) issues.add(QuizIssue.duplicateOptionIds);

  bool anyBlank(Iterable<String> values) =>
      values.any((value) => value.trim().isEmpty);
  bool hasDuplicates(Iterable<String> values) {
    final normalized = values.map((value) => value.trim().toLowerCase());
    return normalized.toSet().length != values.length;
  }

  final correctCount = options.where((option) => option.isCorrect).length;

  switch (quiz.type) {
    case QuizType.multipleChoice:
      if (options.length < 2) issues.add(QuizIssue.tooFewOptions);
      if (anyBlank(options.map((o) => o.text))) {
        issues.add(QuizIssue.emptyOptions);
      } else if (hasDuplicates(options.map((o) => o.text))) {
        issues.add(QuizIssue.duplicateOptions);
      }
      if (correctCount != 1) issues.add(QuizIssue.notOneCorrect);
    case QuizType.trueFalse:
      final tfIds = options.map((option) => option.id).toSet();
      if (options.length != 2 || !tfIds.containsAll(['true', 'false'])) {
        issues.add(QuizIssue.trueFalseOptions);
      }
      if (correctCount != 1) issues.add(QuizIssue.trueFalseNoAnswer);
    case QuizType.flashcard:
      if (quiz.explanation.trim().isEmpty) issues.add(QuizIssue.emptyBack);
      if (options.isNotEmpty) issues.add(QuizIssue.flashcardOptions);
    case QuizType.fillInTheBlank:
      if (blankPattern.allMatches(quiz.question).length != 1) {
        issues.add(QuizIssue.notOneBlank);
      }
      if (options.isEmpty) issues.add(QuizIssue.noAnswers);
      if (anyBlank(options.map((o) => o.text))) {
        issues.add(QuizIssue.emptyAnswers);
      }
      if (options.any((option) => !option.isCorrect)) {
        issues.add(QuizIssue.answerNotCorrect);
      }
    case QuizType.matching:
      if (options.length < 2) issues.add(QuizIssue.tooFewPairs);
      if (anyBlank(options.map((o) => o.prompt)) ||
          anyBlank(options.map((o) => o.text))) {
        issues.add(QuizIssue.emptyPairSide);
      } else if (hasDuplicates(options.map((o) => o.prompt)) ||
          hasDuplicates(options.map((o) => o.text))) {
        issues.add(QuizIssue.duplicatePairs);
      }
  }

  return issues;
}
