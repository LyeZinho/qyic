import '../core/scheduling/fsrs.dart';
import '../features/decks/data/qdeck_reader.dart';
import '../features/decks/domain/deck.dart';
import '../features/decks/domain/quiz_validation.dart';
import '../features/exam/domain/exam.dart';
import 'app_localizations.dart';

// Display names for domain enums. Domain code stays free of UI strings;
// widgets call `value.label(context.l10n)`.

extension QuizTypeLabel on QuizType {
  String label(AppLocalizations l10n) => switch (this) {
    QuizType.multipleChoice => l10n.quizTypeMultipleChoice,
    QuizType.fillInTheBlank => l10n.quizTypeFillInTheBlank,
    QuizType.matching => l10n.quizTypeMatching,
    QuizType.trueFalse => l10n.quizTypeTrueFalse,
    QuizType.flashcard => l10n.quizTypeFlashcard,
  };
}

extension RatingLabel on Rating {
  String label(AppLocalizations l10n) => switch (this) {
    Rating.again => l10n.ratingAgain,
    Rating.hard => l10n.ratingHard,
    Rating.good => l10n.ratingGood,
    Rating.easy => l10n.ratingEasy,
  };
}

extension QdeckCheckLabel on QdeckCheck {
  String label(AppLocalizations l10n) => switch (this) {
    QdeckCheck.archive => l10n.importCheckArchive,
    QdeckCheck.manifest => l10n.importCheckManifest,
    QdeckCheck.checksum => l10n.importCheckChecksum,
    QdeckCheck.quizRules => l10n.importCheckQuizRules,
  };
}

extension ExamSelectionLabel on ExamSelection {
  String label(AppLocalizations l10n) => switch (this) {
    ExamSelection.weakest => l10n.examSelectionWeakest,
    ExamSelection.random => l10n.examSelectionRandom,
    ExamSelection.dueFirst => l10n.examSelectionDueFirst,
  };

  String description(AppLocalizations l10n) => switch (this) {
    ExamSelection.weakest => l10n.examSelectionWeakestDetail,
    ExamSelection.random => l10n.examSelectionRandomDetail,
    ExamSelection.dueFirst => l10n.examSelectionDueFirstDetail,
  };
}

extension ExamEndReasonLabel on ExamEndReason {
  String label(AppLocalizations l10n) => switch (this) {
    ExamEndReason.completed => l10n.examEndCompleted,
    ExamEndReason.timeUp => l10n.examEndTimeUp,
    ExamEndReason.stopped => l10n.examEndStopped,
  };
}

extension ExamPresetIssueLabel on ExamPresetIssue {
  String label(AppLocalizations l10n) => switch (this) {
    ExamPresetIssue.emptyName => l10n.examIssueEmptyName,
    ExamPresetIssue.noQuizTypes => l10n.examIssueNoQuizTypes,
    ExamPresetIssue.questionCount => l10n.examIssueQuestionCount(
      ExamPreset.questionCountRange.min,
      ExamPreset.questionCountRange.max,
    ),
  };
}

extension QuizIssueLabel on QuizIssue {
  String label(AppLocalizations l10n) => switch (this) {
    QuizIssue.emptyQuestion => l10n.issueEmptyQuestion,
    QuizIssue.emptyFront => l10n.issueEmptyFront,
    QuizIssue.duplicateOptionIds => l10n.issueDuplicateOptionIds,
    QuizIssue.tooFewOptions => l10n.issueTooFewOptions,
    QuizIssue.emptyOptions => l10n.issueEmptyOptions,
    QuizIssue.duplicateOptions => l10n.issueDuplicateOptions,
    QuizIssue.notOneCorrect => l10n.issueNotOneCorrect,
    QuizIssue.trueFalseOptions => l10n.issueTrueFalseOptions,
    QuizIssue.trueFalseNoAnswer => l10n.issueTrueFalseNoAnswer,
    QuizIssue.emptyBack => l10n.issueEmptyBack,
    QuizIssue.flashcardOptions => l10n.issueFlashcardOptions,
    QuizIssue.notOneBlank => l10n.issueNotOneBlank,
    QuizIssue.noAnswers => l10n.issueNoAnswers,
    QuizIssue.emptyAnswers => l10n.issueEmptyAnswers,
    QuizIssue.answerNotCorrect => l10n.issueAnswerNotCorrect,
    QuizIssue.tooFewPairs => l10n.issueTooFewPairs,
    QuizIssue.emptyPairSide => l10n.issueEmptyPairSide,
    QuizIssue.duplicatePairs => l10n.issueDuplicatePairs,
  };
}
