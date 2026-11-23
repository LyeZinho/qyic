// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => 'Back';

  @override
  String get actionBackHome => 'Back home';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionClose => 'Close';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionCreate => 'Create';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionDone => 'Done';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionRemove => 'Remove';

  @override
  String get actionSave => 'Save';

  @override
  String errorGeneric(String error) {
    return 'Something went wrong.\n$error';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navLibrary => 'Library';

  @override
  String get navMe => 'Me';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cards',
      one: '1 card',
    );
    return '$_temp0';
  }

  @override
  String quizCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quizzes',
      one: '1 quiz',
    );
    return '$_temp0';
  }

  @override
  String xpAmount(int xp) {
    return '+$xp XP';
  }

  @override
  String xpProgress(int xp, int total) {
    return '$xp / $total XP';
  }

  @override
  String levelShort(int level) {
    return 'Lv $level';
  }

  @override
  String levelProgress(int level, int xp, int total) {
    return 'Level $level · $xp / $total XP';
  }

  @override
  String levelUnlocked(int level) {
    return 'Level $level unlocked';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String durationSeconds(int seconds) {
    return '$seconds s';
  }

  @override
  String intervalMinutes(int count) {
    return '$count min';
  }

  @override
  String intervalHours(int count) {
    return '$count h';
  }

  @override
  String intervalDays(int count) {
    return '$count d';
  }

  @override
  String intervalMonths(String value) {
    return '$value mo';
  }

  @override
  String intervalYears(String value) {
    return '$value y';
  }

  @override
  String get quizTypeMultipleChoice => 'Multiple choice';

  @override
  String get quizTypeFillInTheBlank => 'Fill in the blank';

  @override
  String get quizTypeMatching => 'Matching';

  @override
  String get quizTypeTrueFalse => 'True / False';

  @override
  String get quizTypeFlashcard => 'Flashcard';

  @override
  String get ratingAgain => 'Again';

  @override
  String get ratingHard => 'Hard';

  @override
  String get ratingGood => 'Good';

  @override
  String get ratingEasy => 'Easy';

  @override
  String get ratingQuestion => 'How well did you recall?';

  @override
  String ratingReviewAgainIn(String interval) {
    return 'Review again in $interval';
  }

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get homeReady => 'Ready to study?';

  @override
  String get homeSavedOnDevice => 'Saved on device';

  @override
  String get homeTodaysQueue => 'Today\'s queue';

  @override
  String get homeAllCaughtUp => 'All caught up';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks decks',
      one: '1 deck',
    );
    return 'About $minutes min · $_temp0';
  }

  @override
  String get homeStartReview => 'Start review';

  @override
  String get homeExamTeaser =>
      'Timed, focused practice that counts towards your schedule';

  @override
  String get homeYourDecks => 'Your decks';

  @override
  String get librarySearch => 'Search your decks';

  @override
  String get libraryFilterAll => 'All';

  @override
  String get libraryFilterDue => 'To study';

  @override
  String get libraryEmpty =>
      'No decks yet. Create one or import a .qdeck file.';

  @override
  String get libraryNoMatch => 'No decks match.';

  @override
  String get deckNew => 'New deck';

  @override
  String get deckEdit => 'Edit deck';

  @override
  String get deckFieldTitle => 'Title';

  @override
  String get deckFieldDescription => 'Description (optional)';

  @override
  String deckDueCount(int count) {
    return '$count due';
  }

  @override
  String deckNewCount(int count) {
    return '$count new';
  }

  @override
  String get deckDone => 'Done';

  @override
  String deckBy(String author) {
    return 'by $author';
  }

  @override
  String get deckGone => 'This deck no longer exists.';

  @override
  String deckDeleteTitle(String title) {
    return 'Delete “$title”?';
  }

  @override
  String get deckDeleteBody =>
      'The deck and its quizzes are removed from this device. Your review history is kept.';

  @override
  String get deckMetricDue => 'Due';

  @override
  String get deckMetricRetention => 'Retention';

  @override
  String get deckMetricMature => 'Mature';

  @override
  String get deckQuizTypes => 'Quiz types';

  @override
  String get deckQuizzes => 'Quizzes';

  @override
  String get deckAddQuiz => 'Add quiz';

  @override
  String get deckNoQuizzes => 'No quizzes yet. Add the first one.';

  @override
  String get deckSyncNote =>
      'Your progress on this deck syncs as review events. The deck itself is never re-uploaded.';

  @override
  String get deckStudy => 'Study';

  @override
  String get deckNothingToStudy => 'Nothing to study now';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Study $count cards',
      one: 'Study 1 card',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => 'Delete this quiz?';

  @override
  String get quizDeleteTooltip => 'Delete quiz';

  @override
  String get quizEditorNew => 'New quiz';

  @override
  String get quizEditorEdit => 'Edit quiz';

  @override
  String get quizEditorType => 'Type';

  @override
  String get quizEditorQuestion => 'Question';

  @override
  String get quizEditorStatement => 'Statement';

  @override
  String get quizEditorFront => 'Front';

  @override
  String get quizEditorSentence => 'Sentence — mark the blank with ___';

  @override
  String get quizEditorSentenceHint =>
      'A .qdeck stores quizzes serialized with ___ inside a ZIP.';

  @override
  String get quizEditorInstructions => 'Instructions';

  @override
  String get quizEditorInstructionsHint => 'Match each term to its definition';

  @override
  String get quizEditorHint => 'Context (optional)';

  @override
  String get quizEditorHintHint =>
      'Shown under the question, e.g. a translation';

  @override
  String get quizEditorBack => 'Back';

  @override
  String get quizEditorExplanation => 'Explanation (shown after answering)';

  @override
  String get quizEditorOptions => 'Options — select the correct one';

  @override
  String quizEditorOptionN(int number) {
    return 'Option $number';
  }

  @override
  String get quizEditorAddOption => 'Add option';

  @override
  String get quizEditorStatementIs => 'The statement is';

  @override
  String get quizEditorAccepted => 'Accepted answers';

  @override
  String quizEditorAnswerN(int number) {
    return 'Answer $number';
  }

  @override
  String get quizEditorAddAnswer => 'Add accepted answer';

  @override
  String get quizEditorPairs => 'Pairs';

  @override
  String get quizEditorTerm => 'Term';

  @override
  String get quizEditorMatch => 'Match';

  @override
  String get quizEditorAddPair => 'Add pair';

  @override
  String get quizEditorSave => 'Save quiz';

  @override
  String get issueEmptyQuestion => 'The question must not be empty.';

  @override
  String get issueEmptyFront => 'The front must not be empty.';

  @override
  String get issueDuplicateOptionIds => 'Option ids must be unique.';

  @override
  String get issueTooFewOptions => 'Add at least two options.';

  @override
  String get issueEmptyOptions => 'Options must not be empty.';

  @override
  String get issueDuplicateOptions => 'Options must be distinct.';

  @override
  String get issueNotOneCorrect => 'Mark exactly one correct option.';

  @override
  String get issueTrueFalseOptions =>
      'True/false needs the options “true” and “false”.';

  @override
  String get issueTrueFalseNoAnswer => 'Choose whether the statement holds.';

  @override
  String get issueEmptyBack => 'The back must not be empty.';

  @override
  String get issueFlashcardOptions => 'Flashcards have no options.';

  @override
  String get issueNotOneBlank =>
      'Mark exactly one blank with ___ in the sentence.';

  @override
  String get issueNoAnswers => 'Add at least one accepted answer.';

  @override
  String get issueEmptyAnswers => 'Accepted answers must not be empty.';

  @override
  String get issueAnswerNotCorrect =>
      'Every accepted answer must be marked correct.';

  @override
  String get issueTooFewPairs => 'Add at least two pairs.';

  @override
  String get issueEmptyPairSide =>
      'Both sides of every pair must be filled in.';

  @override
  String get issueDuplicatePairs => 'Terms and matches must be distinct.';

  @override
  String get studyEnd => 'End session';

  @override
  String studySaveFailed(String error) {
    return 'Could not save the review: $error';
  }

  @override
  String get studyAllCaughtUp => 'ALL CAUGHT UP';

  @override
  String get studyNothingDue => 'Nothing is due right now.';

  @override
  String get studyNothingDueBody =>
      'Come back later, add quizzes to a deck, or try exam mode.';

  @override
  String get feedbackCorrect => 'Correct.';

  @override
  String get feedbackWrong => 'Not quite.';

  @override
  String choiceAnswer(String answer) {
    return 'Answer: $answer.';
  }

  @override
  String get trueFalseTrue => 'True';

  @override
  String get trueFalseFalse => 'False';

  @override
  String get trueFalseExplainAfter => 'Answer to see the explanation';

  @override
  String get fillPrompt => 'Complete the sentence';

  @override
  String get fillTypeAnswer => 'Type the answer';

  @override
  String fillAccepted(String answers) {
    return 'Accepted: $answers.';
  }

  @override
  String fillLetterHint(String letter) {
    return 'Hint: starts with “$letter”';
  }

  @override
  String get fillShowHint => 'Show hint';

  @override
  String get fillCheck => 'Check answer';

  @override
  String get flashcardBack => 'Back';

  @override
  String get flashcardRecall => 'Recall the answer, then tap to reveal.';

  @override
  String get flashcardShowAnswer => 'Show answer';

  @override
  String get matchingAllSet => 'All pairs set. Tap a tile to change it.';

  @override
  String matchingInstructions(int remaining, int total) {
    return 'Tap a term, then its match. $remaining of $total pairs left.';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return 'Correct pairs: $pairs.';
  }

  @override
  String get matchingCheck => 'Check pairs';

  @override
  String get sessionComplete => 'SESSION COMPLETE';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cards.',
      one: '1 card.',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => 'Nice run.';

  @override
  String get sessionKeepGoing => 'Keep going.';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count review events saved on device',
      one: '1 review event saved on device',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => 'Accuracy';

  @override
  String get statXpEarned => 'XP earned';

  @override
  String get statDayStreak => 'Day streak';

  @override
  String get statTime => 'Time';

  @override
  String get examTitle => 'Exam mode';

  @override
  String get examIntro =>
      'Intense, timed practice. Cards are picked even when they are not due, and every answer is a real review that updates your schedule.';

  @override
  String get examQuickName => 'Quick exam';

  @override
  String get examStart => 'Start exam';

  @override
  String get examPresets => 'Presets';

  @override
  String get examNewPreset => 'New preset';

  @override
  String get examEditPreset => 'Edit preset';

  @override
  String get examNoPresets => 'No presets yet. Save the setups you use often.';

  @override
  String get examRecent => 'Recent results';

  @override
  String get examNoRuns => 'No exams taken yet.';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '1 question',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return '$seconds s each';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count decks',
      one: '1 deck',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$correct of $total correct';
  }

  @override
  String get examUntimed => 'Untimed';

  @override
  String get examSelectionWeakest => 'Weakest first';

  @override
  String get examSelectionWeakestDetail =>
      'Cards you are most likely to forget, by predicted recall.';

  @override
  String get examSelectionRandom => 'Random';

  @override
  String get examSelectionRandomDetail =>
      'A shuffled mix of everything in scope.';

  @override
  String get examSelectionDueFirst => 'Due first';

  @override
  String get examSelectionDueFirstDetail =>
      'Overdue cards, then the ones coming up next.';

  @override
  String get examEndCompleted => 'Completed';

  @override
  String get examEndTimeUp => 'Time\'s up';

  @override
  String get examEndStopped => 'Stopped early';

  @override
  String get examFieldName => 'Name';

  @override
  String get examFieldDecks => 'Decks';

  @override
  String get examAllDecks => 'All decks';

  @override
  String get examFieldSelection => 'Card selection';

  @override
  String get examFieldQuestions => 'Questions';

  @override
  String get examFieldTimeLimit => 'Time limit';

  @override
  String get examFieldTimePerQuestion => 'Time per question';

  @override
  String get examFieldQuizTypes => 'Quiz types';

  @override
  String get examFieldIncludeNew => 'Include new cards';

  @override
  String get examFieldIncludeNewDetail =>
      'Also ask cards you have never studied.';

  @override
  String get examFieldAutoRate => 'Rate automatically';

  @override
  String get examFieldAutoRateDetail =>
      'Wrong is Again, fast and right is Good, slow and right is Hard. Flashcards still ask you.';

  @override
  String get examFieldAllowHints => 'Allow hints';

  @override
  String get examFieldAllowHintsDetail =>
      'Offer the first-letter hint on fill-in-the-blank quizzes.';

  @override
  String get examAffectsSchedule =>
      'Exam answers are real reviews: they move cards in your schedule and earn XP.';

  @override
  String get examIssueEmptyName => 'Give the preset a name.';

  @override
  String get examIssueNoQuizTypes => 'Pick at least one quiz type.';

  @override
  String examIssueQuestionCount(int min, int max) {
    return 'Choose between $min and $max questions.';
  }

  @override
  String get examDeleteTitle => 'Delete preset?';

  @override
  String examDeleteBody(String name) {
    return '“$name” will be removed. Past results are kept.';
  }

  @override
  String get examPill => 'EXAM';

  @override
  String get examStop => 'Stop exam';

  @override
  String get examStopTitle => 'Stop the exam?';

  @override
  String get examStopBody =>
      'Answers so far are kept and already count towards your schedule.';

  @override
  String get examKeepGoing => 'Keep going';

  @override
  String get examQuestionTimeUp => 'Time\'s up.';

  @override
  String get examTimeUpBanner =>
      'The exam time is over. This was the last question.';

  @override
  String examRatedAs(String rating) {
    return 'Rated $rating';
  }

  @override
  String get examNextQuestion => 'Next question';

  @override
  String get examSeeResults => 'See results';

  @override
  String get examAnswered => 'Answered';

  @override
  String get examUnanswered => 'Unanswered';

  @override
  String examMissed(int count) {
    return 'To review ($count)';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews saved on device.',
      one: '1 review saved on device.',
      zero: 'No reviews were recorded.',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'Retake';

  @override
  String get examNoCards => 'No cards to ask.';

  @override
  String get examNoCardsBody =>
      'There are no cards in these decks with the selected quiz types.';

  @override
  String get examNoCardsBodyNew =>
      'Only studied cards are asked. Study some cards first, or enable “Include new cards” in a preset.';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get remindersIntro =>
      'Get a nudge to study at the times that suit you. Reminders are set on this device only.';

  @override
  String get remindersAdd => 'Add reminder';

  @override
  String get remindersEmpty => 'No reminders yet.';

  @override
  String get remindersNoDays =>
      'Pick at least one day, or this reminder never fires.';

  @override
  String get remindersOff => 'Off';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active',
      one: '1 active',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'This platform cannot schedule notifications. Your reminders are saved and apply on your phone.';

  @override
  String get remindersPermissionDenied =>
      'Notifications are turned off for Qyic. Allow them in the system settings to receive reminders.';

  @override
  String get reminderTitle => 'Time to study';

  @override
  String get reminderBody =>
      'A few minutes now keeps your streak and your memory going.';

  @override
  String get reminderChannel => 'Study reminders';

  @override
  String get prefTitle => 'Preferences';

  @override
  String get prefSectionGeneral => 'General';

  @override
  String get prefSectionStudy => 'Study';

  @override
  String get prefSectionNotifications => 'Notifications';

  @override
  String get prefSectionData => 'Data';

  @override
  String get prefSectionAbout => 'About';

  @override
  String get prefLanguage => 'Language';

  @override
  String get prefSystem => 'System default';

  @override
  String get prefName => 'Your name';

  @override
  String get prefDailyGoal => 'Daily goal';

  @override
  String get prefDailyGoalDetail => 'Reviews per day that complete your goal.';

  @override
  String get prefNewCards => 'New cards per day';

  @override
  String get prefNewCardsDetail =>
      'Never-seen cards introduced each day, across all decks.';

  @override
  String get prefRetention => 'Desired retention';

  @override
  String get prefRetentionDetail =>
      'Higher retention means more frequent reviews. Applies to future reviews.';

  @override
  String get prefIntervals => 'Show next intervals';

  @override
  String get prefIntervalsDetail =>
      'Label rating buttons with when you will see the card again.';

  @override
  String get prefHaptics => 'Haptic feedback';

  @override
  String get prefHapticsDetail => 'Vibrate on answers and ratings.';

  @override
  String get prefStorage => 'Storage used';

  @override
  String get prefLicenses => 'Open-source licenses';

  @override
  String get meDefaultName => 'Learner';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak-day streak',
      one: '1-day streak',
    );
    return 'Level $level · $_temp0';
  }

  @override
  String get meSyncOff => 'Sync not set up';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count events on device',
      one: '1 event on device',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      'Reviews are saved to this device first. Once sign-in and sync are available, queued review events upload; decks are never re-uploaded.';

  @override
  String get meSettings => 'Settings';

  @override
  String get meMore => 'More';

  @override
  String get meSyncUnavailable => 'Sync now · not available yet';

  @override
  String get importAction => 'Import .qdeck';

  @override
  String get importTitle => 'Import .qdeck';

  @override
  String get importChecking => 'Checking the file…';

  @override
  String get importNewBadge => 'New deck';

  @override
  String importUpdateBadge(int from, int to) {
    return 'Update v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return 'spec v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'deck v$version';
  }

  @override
  String get importCheckArchive => 'Archive paths are safe';

  @override
  String get importCheckArchiveDetail => 'no traversal';

  @override
  String get importCheckManifest => 'Manifest is valid';

  @override
  String get importCheckChecksum => 'SHA-256 matches';

  @override
  String get importCheckQuizRules => 'Quizzes follow the rules';

  @override
  String importChanges(int added, int updated, int removed) {
    return '$added new · $updated changed · $removed removed';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count quizzes use a type this version cannot show and are skipped.',
      one: '1 quiz uses a type this version cannot show and is skipped.',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count media files are not shown yet.',
      one: '1 media file is not shown yet.',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => 'Your progress is kept.';

  @override
  String get importProgressKeptBody =>
      'Installing only adds or updates content on this device; your review history stays as it is.';

  @override
  String get importInstallAction => 'Install';

  @override
  String get importUpdateAction => 'Update';

  @override
  String importInstalled(String title) {
    return 'Installed “$title”';
  }

  @override
  String importUpdated(String title) {
    return 'Updated “$title”';
  }

  @override
  String importInstallFailed(String error) {
    return 'Could not install: $error';
  }

  @override
  String get importFailedTitle => 'This file can\'t be imported';

  @override
  String get deckManageCards => 'Manage cards';

  @override
  String get deckModeMixed => 'Mixed';

  @override
  String get deckModeQuizzes => 'Quizzes only';

  @override
  String get deckModeFlashcards => 'Flashcards only';

  @override
  String get deckModeExam => 'Exam';

  @override
  String get deckModeMixedDetail => 'Due and new cards of every type.';

  @override
  String get deckModeQuizzesDetail => 'Questions only. No flashcards.';

  @override
  String get deckModeFlashcardsDetail => 'Flashcards only.';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'Every type. Between 100 and $count questions, chosen when you start.';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'Every type. $count questions.';
  }

  @override
  String get deckExamStart => 'Start exam';
}
