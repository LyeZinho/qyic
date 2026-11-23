import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('pt', 'PT'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Qyic'**
  String get appTitle;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back home'**
  String get actionBackHome;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get actionCreate;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get actionRemove;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.\n{error}'**
  String errorGeneric(String error);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get navLibrary;

  /// No description provided for @navMe.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get navMe;

  /// No description provided for @cardCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 card} other{{count} cards}}'**
  String cardCount(int count);

  /// No description provided for @quizCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 quiz} other{{count} quizzes}}'**
  String quizCount(int count);

  /// No description provided for @xpAmount.
  ///
  /// In en, this message translates to:
  /// **'+{xp} XP'**
  String xpAmount(int xp);

  /// No description provided for @xpProgress.
  ///
  /// In en, this message translates to:
  /// **'{xp} / {total} XP'**
  String xpProgress(int xp, int total);

  /// No description provided for @levelShort.
  ///
  /// In en, this message translates to:
  /// **'Lv {level}'**
  String levelShort(int level);

  /// No description provided for @levelProgress.
  ///
  /// In en, this message translates to:
  /// **'Level {level} · {xp} / {total} XP'**
  String levelProgress(int level, int xp, int total);

  /// No description provided for @levelUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Level {level} unlocked'**
  String levelUnlocked(int level);

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutes(int minutes);

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds} s'**
  String durationSeconds(int seconds);

  /// No description provided for @intervalMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String intervalMinutes(int count);

  /// No description provided for @intervalHours.
  ///
  /// In en, this message translates to:
  /// **'{count} h'**
  String intervalHours(int count);

  /// No description provided for @intervalDays.
  ///
  /// In en, this message translates to:
  /// **'{count} d'**
  String intervalDays(int count);

  /// No description provided for @intervalMonths.
  ///
  /// In en, this message translates to:
  /// **'{value} mo'**
  String intervalMonths(String value);

  /// No description provided for @intervalYears.
  ///
  /// In en, this message translates to:
  /// **'{value} y'**
  String intervalYears(String value);

  /// No description provided for @quizTypeMultipleChoice.
  ///
  /// In en, this message translates to:
  /// **'Multiple choice'**
  String get quizTypeMultipleChoice;

  /// No description provided for @quizTypeFillInTheBlank.
  ///
  /// In en, this message translates to:
  /// **'Fill in the blank'**
  String get quizTypeFillInTheBlank;

  /// No description provided for @quizTypeMatching.
  ///
  /// In en, this message translates to:
  /// **'Matching'**
  String get quizTypeMatching;

  /// No description provided for @quizTypeTrueFalse.
  ///
  /// In en, this message translates to:
  /// **'True / False'**
  String get quizTypeTrueFalse;

  /// No description provided for @quizTypeFlashcard.
  ///
  /// In en, this message translates to:
  /// **'Flashcard'**
  String get quizTypeFlashcard;

  /// No description provided for @ratingAgain.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get ratingAgain;

  /// No description provided for @ratingHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get ratingHard;

  /// No description provided for @ratingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get ratingGood;

  /// No description provided for @ratingEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get ratingEasy;

  /// No description provided for @ratingQuestion.
  ///
  /// In en, this message translates to:
  /// **'How well did you recall?'**
  String get ratingQuestion;

  /// No description provided for @ratingReviewAgainIn.
  ///
  /// In en, this message translates to:
  /// **'Review again in {interval}'**
  String ratingReviewAgainIn(String interval);

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @homeReady.
  ///
  /// In en, this message translates to:
  /// **'Ready to study?'**
  String get homeReady;

  /// No description provided for @homeSavedOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Saved on device'**
  String get homeSavedOnDevice;

  /// No description provided for @homeTodaysQueue.
  ///
  /// In en, this message translates to:
  /// **'Today\'s queue'**
  String get homeTodaysQueue;

  /// No description provided for @homeAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All caught up'**
  String get homeAllCaughtUp;

  /// No description provided for @homeQueueEstimate.
  ///
  /// In en, this message translates to:
  /// **'About {minutes} min · {decks, plural, =1{1 deck} other{{decks} decks}}'**
  String homeQueueEstimate(int minutes, int decks);

  /// No description provided for @homeStartReview.
  ///
  /// In en, this message translates to:
  /// **'Start review'**
  String get homeStartReview;

  /// No description provided for @homeExamTeaser.
  ///
  /// In en, this message translates to:
  /// **'Timed, focused practice that counts towards your schedule'**
  String get homeExamTeaser;

  /// No description provided for @homeYourDecks.
  ///
  /// In en, this message translates to:
  /// **'Your decks'**
  String get homeYourDecks;

  /// No description provided for @librarySearch.
  ///
  /// In en, this message translates to:
  /// **'Search your decks'**
  String get librarySearch;

  /// No description provided for @libraryFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get libraryFilterAll;

  /// No description provided for @libraryFilterDue.
  ///
  /// In en, this message translates to:
  /// **'To study'**
  String get libraryFilterDue;

  /// No description provided for @libraryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No decks yet. Create one or import a .qdeck file.'**
  String get libraryEmpty;

  /// No description provided for @libraryNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No decks match.'**
  String get libraryNoMatch;

  /// No description provided for @deckNew.
  ///
  /// In en, this message translates to:
  /// **'New deck'**
  String get deckNew;

  /// No description provided for @deckEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit deck'**
  String get deckEdit;

  /// No description provided for @deckFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get deckFieldTitle;

  /// No description provided for @deckFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get deckFieldDescription;

  /// No description provided for @deckDueCount.
  ///
  /// In en, this message translates to:
  /// **'{count} due'**
  String deckDueCount(int count);

  /// No description provided for @deckNewCount.
  ///
  /// In en, this message translates to:
  /// **'{count} new'**
  String deckNewCount(int count);

  /// No description provided for @deckDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get deckDone;

  /// No description provided for @deckBy.
  ///
  /// In en, this message translates to:
  /// **'by {author}'**
  String deckBy(String author);

  /// No description provided for @deckGone.
  ///
  /// In en, this message translates to:
  /// **'This deck no longer exists.'**
  String get deckGone;

  /// No description provided for @deckDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete “{title}”?'**
  String deckDeleteTitle(String title);

  /// No description provided for @deckDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The deck and its quizzes are removed from this device. Your review history is kept.'**
  String get deckDeleteBody;

  /// No description provided for @deckMetricDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get deckMetricDue;

  /// No description provided for @deckMetricRetention.
  ///
  /// In en, this message translates to:
  /// **'Retention'**
  String get deckMetricRetention;

  /// No description provided for @deckMetricMature.
  ///
  /// In en, this message translates to:
  /// **'Mature'**
  String get deckMetricMature;

  /// No description provided for @deckQuizTypes.
  ///
  /// In en, this message translates to:
  /// **'Quiz types'**
  String get deckQuizTypes;

  /// No description provided for @deckQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get deckQuizzes;

  /// No description provided for @deckAddQuiz.
  ///
  /// In en, this message translates to:
  /// **'Add quiz'**
  String get deckAddQuiz;

  /// No description provided for @deckNoQuizzes.
  ///
  /// In en, this message translates to:
  /// **'No quizzes yet. Add the first one.'**
  String get deckNoQuizzes;

  /// No description provided for @deckSyncNote.
  ///
  /// In en, this message translates to:
  /// **'Your progress on this deck syncs as review events. The deck itself is never re-uploaded.'**
  String get deckSyncNote;

  /// No description provided for @deckStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get deckStudy;

  /// No description provided for @deckNothingToStudy.
  ///
  /// In en, this message translates to:
  /// **'Nothing to study now'**
  String get deckNothingToStudy;

  /// No description provided for @deckStudyCards.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Study 1 card} other{Study {count} cards}}'**
  String deckStudyCards(int count);

  /// No description provided for @quizDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this quiz?'**
  String get quizDeleteTitle;

  /// No description provided for @quizDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete quiz'**
  String get quizDeleteTooltip;

  /// No description provided for @quizEditorNew.
  ///
  /// In en, this message translates to:
  /// **'New quiz'**
  String get quizEditorNew;

  /// No description provided for @quizEditorEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit quiz'**
  String get quizEditorEdit;

  /// No description provided for @quizEditorType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get quizEditorType;

  /// No description provided for @quizEditorQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get quizEditorQuestion;

  /// No description provided for @quizEditorStatement.
  ///
  /// In en, this message translates to:
  /// **'Statement'**
  String get quizEditorStatement;

  /// No description provided for @quizEditorFront.
  ///
  /// In en, this message translates to:
  /// **'Front'**
  String get quizEditorFront;

  /// No description provided for @quizEditorSentence.
  ///
  /// In en, this message translates to:
  /// **'Sentence — mark the blank with ___'**
  String get quizEditorSentence;

  /// No description provided for @quizEditorSentenceHint.
  ///
  /// In en, this message translates to:
  /// **'A .qdeck stores quizzes serialized with ___ inside a ZIP.'**
  String get quizEditorSentenceHint;

  /// No description provided for @quizEditorInstructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get quizEditorInstructions;

  /// No description provided for @quizEditorInstructionsHint.
  ///
  /// In en, this message translates to:
  /// **'Match each term to its definition'**
  String get quizEditorInstructionsHint;

  /// No description provided for @quizEditorHint.
  ///
  /// In en, this message translates to:
  /// **'Context (optional)'**
  String get quizEditorHint;

  /// No description provided for @quizEditorHintHint.
  ///
  /// In en, this message translates to:
  /// **'Shown under the question, e.g. a translation'**
  String get quizEditorHintHint;

  /// No description provided for @quizEditorBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get quizEditorBack;

  /// No description provided for @quizEditorExplanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation (shown after answering)'**
  String get quizEditorExplanation;

  /// No description provided for @quizEditorOptions.
  ///
  /// In en, this message translates to:
  /// **'Options — select the correct one'**
  String get quizEditorOptions;

  /// No description provided for @quizEditorOptionN.
  ///
  /// In en, this message translates to:
  /// **'Option {number}'**
  String quizEditorOptionN(int number);

  /// No description provided for @quizEditorAddOption.
  ///
  /// In en, this message translates to:
  /// **'Add option'**
  String get quizEditorAddOption;

  /// No description provided for @quizEditorStatementIs.
  ///
  /// In en, this message translates to:
  /// **'The statement is'**
  String get quizEditorStatementIs;

  /// No description provided for @quizEditorAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted answers'**
  String get quizEditorAccepted;

  /// No description provided for @quizEditorAnswerN.
  ///
  /// In en, this message translates to:
  /// **'Answer {number}'**
  String quizEditorAnswerN(int number);

  /// No description provided for @quizEditorAddAnswer.
  ///
  /// In en, this message translates to:
  /// **'Add accepted answer'**
  String get quizEditorAddAnswer;

  /// No description provided for @quizEditorPairs.
  ///
  /// In en, this message translates to:
  /// **'Pairs'**
  String get quizEditorPairs;

  /// No description provided for @quizEditorTerm.
  ///
  /// In en, this message translates to:
  /// **'Term'**
  String get quizEditorTerm;

  /// No description provided for @quizEditorMatch.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get quizEditorMatch;

  /// No description provided for @quizEditorAddPair.
  ///
  /// In en, this message translates to:
  /// **'Add pair'**
  String get quizEditorAddPair;

  /// No description provided for @quizEditorSave.
  ///
  /// In en, this message translates to:
  /// **'Save quiz'**
  String get quizEditorSave;

  /// No description provided for @issueEmptyQuestion.
  ///
  /// In en, this message translates to:
  /// **'The question must not be empty.'**
  String get issueEmptyQuestion;

  /// No description provided for @issueEmptyFront.
  ///
  /// In en, this message translates to:
  /// **'The front must not be empty.'**
  String get issueEmptyFront;

  /// No description provided for @issueDuplicateOptionIds.
  ///
  /// In en, this message translates to:
  /// **'Option ids must be unique.'**
  String get issueDuplicateOptionIds;

  /// No description provided for @issueTooFewOptions.
  ///
  /// In en, this message translates to:
  /// **'Add at least two options.'**
  String get issueTooFewOptions;

  /// No description provided for @issueEmptyOptions.
  ///
  /// In en, this message translates to:
  /// **'Options must not be empty.'**
  String get issueEmptyOptions;

  /// No description provided for @issueDuplicateOptions.
  ///
  /// In en, this message translates to:
  /// **'Options must be distinct.'**
  String get issueDuplicateOptions;

  /// No description provided for @issueNotOneCorrect.
  ///
  /// In en, this message translates to:
  /// **'Mark exactly one correct option.'**
  String get issueNotOneCorrect;

  /// No description provided for @issueTrueFalseOptions.
  ///
  /// In en, this message translates to:
  /// **'True/false needs the options “true” and “false”.'**
  String get issueTrueFalseOptions;

  /// No description provided for @issueTrueFalseNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Choose whether the statement holds.'**
  String get issueTrueFalseNoAnswer;

  /// No description provided for @issueEmptyBack.
  ///
  /// In en, this message translates to:
  /// **'The back must not be empty.'**
  String get issueEmptyBack;

  /// No description provided for @issueFlashcardOptions.
  ///
  /// In en, this message translates to:
  /// **'Flashcards have no options.'**
  String get issueFlashcardOptions;

  /// No description provided for @issueNotOneBlank.
  ///
  /// In en, this message translates to:
  /// **'Mark exactly one blank with ___ in the sentence.'**
  String get issueNotOneBlank;

  /// No description provided for @issueNoAnswers.
  ///
  /// In en, this message translates to:
  /// **'Add at least one accepted answer.'**
  String get issueNoAnswers;

  /// No description provided for @issueEmptyAnswers.
  ///
  /// In en, this message translates to:
  /// **'Accepted answers must not be empty.'**
  String get issueEmptyAnswers;

  /// No description provided for @issueAnswerNotCorrect.
  ///
  /// In en, this message translates to:
  /// **'Every accepted answer must be marked correct.'**
  String get issueAnswerNotCorrect;

  /// No description provided for @issueTooFewPairs.
  ///
  /// In en, this message translates to:
  /// **'Add at least two pairs.'**
  String get issueTooFewPairs;

  /// No description provided for @issueEmptyPairSide.
  ///
  /// In en, this message translates to:
  /// **'Both sides of every pair must be filled in.'**
  String get issueEmptyPairSide;

  /// No description provided for @issueDuplicatePairs.
  ///
  /// In en, this message translates to:
  /// **'Terms and matches must be distinct.'**
  String get issueDuplicatePairs;

  /// No description provided for @studyEnd.
  ///
  /// In en, this message translates to:
  /// **'End session'**
  String get studyEnd;

  /// No description provided for @studySaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save the review: {error}'**
  String studySaveFailed(String error);

  /// No description provided for @studyAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'ALL CAUGHT UP'**
  String get studyAllCaughtUp;

  /// No description provided for @studyNothingDue.
  ///
  /// In en, this message translates to:
  /// **'Nothing is due right now.'**
  String get studyNothingDue;

  /// No description provided for @studyNothingDueBody.
  ///
  /// In en, this message translates to:
  /// **'Come back later, add quizzes to a deck, or try exam mode.'**
  String get studyNothingDueBody;

  /// No description provided for @feedbackCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct.'**
  String get feedbackCorrect;

  /// No description provided for @feedbackWrong.
  ///
  /// In en, this message translates to:
  /// **'Not quite.'**
  String get feedbackWrong;

  /// No description provided for @choiceAnswer.
  ///
  /// In en, this message translates to:
  /// **'Answer: {answer}.'**
  String choiceAnswer(String answer);

  /// No description provided for @trueFalseTrue.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get trueFalseTrue;

  /// No description provided for @trueFalseFalse.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get trueFalseFalse;

  /// No description provided for @trueFalseExplainAfter.
  ///
  /// In en, this message translates to:
  /// **'Answer to see the explanation'**
  String get trueFalseExplainAfter;

  /// No description provided for @fillPrompt.
  ///
  /// In en, this message translates to:
  /// **'Complete the sentence'**
  String get fillPrompt;

  /// No description provided for @fillTypeAnswer.
  ///
  /// In en, this message translates to:
  /// **'Type the answer'**
  String get fillTypeAnswer;

  /// No description provided for @fillAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted: {answers}.'**
  String fillAccepted(String answers);

  /// No description provided for @fillLetterHint.
  ///
  /// In en, this message translates to:
  /// **'Hint: starts with “{letter}”'**
  String fillLetterHint(String letter);

  /// No description provided for @fillShowHint.
  ///
  /// In en, this message translates to:
  /// **'Show hint'**
  String get fillShowHint;

  /// No description provided for @fillCheck.
  ///
  /// In en, this message translates to:
  /// **'Check answer'**
  String get fillCheck;

  /// No description provided for @flashcardBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get flashcardBack;

  /// No description provided for @flashcardRecall.
  ///
  /// In en, this message translates to:
  /// **'Recall the answer, then tap to reveal.'**
  String get flashcardRecall;

  /// No description provided for @flashcardShowAnswer.
  ///
  /// In en, this message translates to:
  /// **'Show answer'**
  String get flashcardShowAnswer;

  /// No description provided for @matchingAllSet.
  ///
  /// In en, this message translates to:
  /// **'All pairs set. Tap a tile to change it.'**
  String get matchingAllSet;

  /// No description provided for @matchingInstructions.
  ///
  /// In en, this message translates to:
  /// **'Tap a term, then its match. {remaining} of {total} pairs left.'**
  String matchingInstructions(int remaining, int total);

  /// No description provided for @matchingCorrectPairs.
  ///
  /// In en, this message translates to:
  /// **'Correct pairs: {pairs}.'**
  String matchingCorrectPairs(String pairs);

  /// No description provided for @matchingCheck.
  ///
  /// In en, this message translates to:
  /// **'Check pairs'**
  String get matchingCheck;

  /// No description provided for @sessionComplete.
  ///
  /// In en, this message translates to:
  /// **'SESSION COMPLETE'**
  String get sessionComplete;

  /// No description provided for @sessionCards.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 card.} other{{count} cards.}}'**
  String sessionCards(int count);

  /// No description provided for @sessionNiceRun.
  ///
  /// In en, this message translates to:
  /// **'Nice run.'**
  String get sessionNiceRun;

  /// No description provided for @sessionKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going.'**
  String get sessionKeepGoing;

  /// No description provided for @sessionEventsSaved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 review event saved on device} other{{count} review events saved on device}}'**
  String sessionEventsSaved(int count);

  /// No description provided for @statAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get statAccuracy;

  /// No description provided for @statXpEarned.
  ///
  /// In en, this message translates to:
  /// **'XP earned'**
  String get statXpEarned;

  /// No description provided for @statDayStreak.
  ///
  /// In en, this message translates to:
  /// **'Day streak'**
  String get statDayStreak;

  /// No description provided for @statTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get statTime;

  /// No description provided for @examTitle.
  ///
  /// In en, this message translates to:
  /// **'Exam mode'**
  String get examTitle;

  /// No description provided for @examIntro.
  ///
  /// In en, this message translates to:
  /// **'Intense, timed practice. Cards are picked even when they are not due, and every answer is a real review that updates your schedule.'**
  String get examIntro;

  /// No description provided for @examQuickName.
  ///
  /// In en, this message translates to:
  /// **'Quick exam'**
  String get examQuickName;

  /// No description provided for @examStart.
  ///
  /// In en, this message translates to:
  /// **'Start exam'**
  String get examStart;

  /// No description provided for @examPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get examPresets;

  /// No description provided for @examNewPreset.
  ///
  /// In en, this message translates to:
  /// **'New preset'**
  String get examNewPreset;

  /// No description provided for @examEditPreset.
  ///
  /// In en, this message translates to:
  /// **'Edit preset'**
  String get examEditPreset;

  /// No description provided for @examNoPresets.
  ///
  /// In en, this message translates to:
  /// **'No presets yet. Save the setups you use often.'**
  String get examNoPresets;

  /// No description provided for @examRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent results'**
  String get examRecent;

  /// No description provided for @examNoRuns.
  ///
  /// In en, this message translates to:
  /// **'No exams taken yet.'**
  String get examNoRuns;

  /// No description provided for @examQuestionCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 question} other{{count} questions}}'**
  String examQuestionCount(int count);

  /// No description provided for @examPerQuestion.
  ///
  /// In en, this message translates to:
  /// **'{seconds} s each'**
  String examPerQuestion(int seconds);

  /// No description provided for @examDeckCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 deck} other{{count} decks}}'**
  String examDeckCount(int count);

  /// No description provided for @examCorrectOf.
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} correct'**
  String examCorrectOf(int correct, int total);

  /// No description provided for @examUntimed.
  ///
  /// In en, this message translates to:
  /// **'Untimed'**
  String get examUntimed;

  /// No description provided for @examSelectionWeakest.
  ///
  /// In en, this message translates to:
  /// **'Weakest first'**
  String get examSelectionWeakest;

  /// No description provided for @examSelectionWeakestDetail.
  ///
  /// In en, this message translates to:
  /// **'Cards you are most likely to forget, by predicted recall.'**
  String get examSelectionWeakestDetail;

  /// No description provided for @examSelectionRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get examSelectionRandom;

  /// No description provided for @examSelectionRandomDetail.
  ///
  /// In en, this message translates to:
  /// **'A shuffled mix of everything in scope.'**
  String get examSelectionRandomDetail;

  /// No description provided for @examSelectionDueFirst.
  ///
  /// In en, this message translates to:
  /// **'Due first'**
  String get examSelectionDueFirst;

  /// No description provided for @examSelectionDueFirstDetail.
  ///
  /// In en, this message translates to:
  /// **'Overdue cards, then the ones coming up next.'**
  String get examSelectionDueFirstDetail;

  /// No description provided for @examEndCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get examEndCompleted;

  /// No description provided for @examEndTimeUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s up'**
  String get examEndTimeUp;

  /// No description provided for @examEndStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped early'**
  String get examEndStopped;

  /// No description provided for @examFieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get examFieldName;

  /// No description provided for @examFieldDecks.
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get examFieldDecks;

  /// No description provided for @examAllDecks.
  ///
  /// In en, this message translates to:
  /// **'All decks'**
  String get examAllDecks;

  /// No description provided for @examFieldSelection.
  ///
  /// In en, this message translates to:
  /// **'Card selection'**
  String get examFieldSelection;

  /// No description provided for @examFieldQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get examFieldQuestions;

  /// No description provided for @examFieldTimeLimit.
  ///
  /// In en, this message translates to:
  /// **'Time limit'**
  String get examFieldTimeLimit;

  /// No description provided for @examFieldTimePerQuestion.
  ///
  /// In en, this message translates to:
  /// **'Time per question'**
  String get examFieldTimePerQuestion;

  /// No description provided for @examFieldQuizTypes.
  ///
  /// In en, this message translates to:
  /// **'Quiz types'**
  String get examFieldQuizTypes;

  /// No description provided for @examFieldIncludeNew.
  ///
  /// In en, this message translates to:
  /// **'Include new cards'**
  String get examFieldIncludeNew;

  /// No description provided for @examFieldIncludeNewDetail.
  ///
  /// In en, this message translates to:
  /// **'Also ask cards you have never studied.'**
  String get examFieldIncludeNewDetail;

  /// No description provided for @examFieldAutoRate.
  ///
  /// In en, this message translates to:
  /// **'Rate automatically'**
  String get examFieldAutoRate;

  /// No description provided for @examFieldAutoRateDetail.
  ///
  /// In en, this message translates to:
  /// **'Wrong is Again, fast and right is Good, slow and right is Hard. Flashcards still ask you.'**
  String get examFieldAutoRateDetail;

  /// No description provided for @examFieldAllowHints.
  ///
  /// In en, this message translates to:
  /// **'Allow hints'**
  String get examFieldAllowHints;

  /// No description provided for @examFieldAllowHintsDetail.
  ///
  /// In en, this message translates to:
  /// **'Offer the first-letter hint on fill-in-the-blank quizzes.'**
  String get examFieldAllowHintsDetail;

  /// No description provided for @examAffectsSchedule.
  ///
  /// In en, this message translates to:
  /// **'Exam answers are real reviews: they move cards in your schedule and earn XP.'**
  String get examAffectsSchedule;

  /// No description provided for @examIssueEmptyName.
  ///
  /// In en, this message translates to:
  /// **'Give the preset a name.'**
  String get examIssueEmptyName;

  /// No description provided for @examIssueNoQuizTypes.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one quiz type.'**
  String get examIssueNoQuizTypes;

  /// No description provided for @examIssueQuestionCount.
  ///
  /// In en, this message translates to:
  /// **'Choose between {min} and {max} questions.'**
  String examIssueQuestionCount(int min, int max);

  /// No description provided for @examDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete preset?'**
  String get examDeleteTitle;

  /// No description provided for @examDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'“{name}” will be removed. Past results are kept.'**
  String examDeleteBody(String name);

  /// No description provided for @examPill.
  ///
  /// In en, this message translates to:
  /// **'EXAM'**
  String get examPill;

  /// No description provided for @examStop.
  ///
  /// In en, this message translates to:
  /// **'Stop exam'**
  String get examStop;

  /// No description provided for @examStopTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop the exam?'**
  String get examStopTitle;

  /// No description provided for @examStopBody.
  ///
  /// In en, this message translates to:
  /// **'Answers so far are kept and already count towards your schedule.'**
  String get examStopBody;

  /// No description provided for @examKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get examKeepGoing;

  /// No description provided for @examQuestionTimeUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s up.'**
  String get examQuestionTimeUp;

  /// No description provided for @examTimeUpBanner.
  ///
  /// In en, this message translates to:
  /// **'The exam time is over. This was the last question.'**
  String get examTimeUpBanner;

  /// No description provided for @examRatedAs.
  ///
  /// In en, this message translates to:
  /// **'Rated {rating}'**
  String examRatedAs(String rating);

  /// No description provided for @examNextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next question'**
  String get examNextQuestion;

  /// No description provided for @examSeeResults.
  ///
  /// In en, this message translates to:
  /// **'See results'**
  String get examSeeResults;

  /// No description provided for @examAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get examAnswered;

  /// No description provided for @examUnanswered.
  ///
  /// In en, this message translates to:
  /// **'Unanswered'**
  String get examUnanswered;

  /// No description provided for @examMissed.
  ///
  /// In en, this message translates to:
  /// **'To review ({count})'**
  String examMissed(int count);

  /// No description provided for @examReviewsSaved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No reviews were recorded.} =1{1 review saved on device.} other{{count} reviews saved on device.}}'**
  String examReviewsSaved(int count);

  /// No description provided for @examRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get examRetake;

  /// No description provided for @examNoCards.
  ///
  /// In en, this message translates to:
  /// **'No cards to ask.'**
  String get examNoCards;

  /// No description provided for @examNoCardsBody.
  ///
  /// In en, this message translates to:
  /// **'There are no cards in these decks with the selected quiz types.'**
  String get examNoCardsBody;

  /// No description provided for @examNoCardsBodyNew.
  ///
  /// In en, this message translates to:
  /// **'Only studied cards are asked. Study some cards first, or enable “Include new cards” in a preset.'**
  String get examNoCardsBodyNew;

  /// No description provided for @remindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// No description provided for @remindersIntro.
  ///
  /// In en, this message translates to:
  /// **'Get a nudge to study at the times that suit you. Reminders are set on this device only.'**
  String get remindersIntro;

  /// No description provided for @remindersAdd.
  ///
  /// In en, this message translates to:
  /// **'Add reminder'**
  String get remindersAdd;

  /// No description provided for @remindersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No reminders yet.'**
  String get remindersEmpty;

  /// No description provided for @remindersNoDays.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one day, or this reminder never fires.'**
  String get remindersNoDays;

  /// No description provided for @remindersOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get remindersOff;

  /// No description provided for @remindersActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 active} other{{count} active}}'**
  String remindersActiveCount(int count);

  /// No description provided for @remindersUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This platform cannot schedule notifications. Your reminders are saved and apply on your phone.'**
  String get remindersUnsupported;

  /// No description provided for @remindersPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for Qyic. Allow them in the system settings to receive reminders.'**
  String get remindersPermissionDenied;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to study'**
  String get reminderTitle;

  /// No description provided for @reminderBody.
  ///
  /// In en, this message translates to:
  /// **'A few minutes now keeps your streak and your memory going.'**
  String get reminderBody;

  /// No description provided for @reminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Study reminders'**
  String get reminderChannel;

  /// No description provided for @prefTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get prefTitle;

  /// No description provided for @prefSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get prefSectionGeneral;

  /// No description provided for @prefSectionStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get prefSectionStudy;

  /// No description provided for @prefSectionNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get prefSectionNotifications;

  /// No description provided for @prefSectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get prefSectionData;

  /// No description provided for @prefSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get prefSectionAbout;

  /// No description provided for @prefLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get prefLanguage;

  /// No description provided for @prefSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get prefSystem;

  /// No description provided for @prefName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get prefName;

  /// No description provided for @prefDailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get prefDailyGoal;

  /// No description provided for @prefDailyGoalDetail.
  ///
  /// In en, this message translates to:
  /// **'Reviews per day that complete your goal.'**
  String get prefDailyGoalDetail;

  /// No description provided for @prefNewCards.
  ///
  /// In en, this message translates to:
  /// **'New cards per day'**
  String get prefNewCards;

  /// No description provided for @prefNewCardsDetail.
  ///
  /// In en, this message translates to:
  /// **'Never-seen cards introduced each day, across all decks.'**
  String get prefNewCardsDetail;

  /// No description provided for @prefRetention.
  ///
  /// In en, this message translates to:
  /// **'Desired retention'**
  String get prefRetention;

  /// No description provided for @prefRetentionDetail.
  ///
  /// In en, this message translates to:
  /// **'Higher retention means more frequent reviews. Applies to future reviews.'**
  String get prefRetentionDetail;

  /// No description provided for @prefIntervals.
  ///
  /// In en, this message translates to:
  /// **'Show next intervals'**
  String get prefIntervals;

  /// No description provided for @prefIntervalsDetail.
  ///
  /// In en, this message translates to:
  /// **'Label rating buttons with when you will see the card again.'**
  String get prefIntervalsDetail;

  /// No description provided for @prefHaptics.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get prefHaptics;

  /// No description provided for @prefHapticsDetail.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on answers and ratings.'**
  String get prefHapticsDetail;

  /// No description provided for @prefStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage used'**
  String get prefStorage;

  /// No description provided for @prefLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get prefLicenses;

  /// No description provided for @meDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Learner'**
  String get meDefaultName;

  /// No description provided for @meSummary.
  ///
  /// In en, this message translates to:
  /// **'Level {level} · {streak, plural, =1{1-day streak} other{{streak}-day streak}}'**
  String meSummary(int level, int streak);

  /// No description provided for @meSyncOff.
  ///
  /// In en, this message translates to:
  /// **'Sync not set up'**
  String get meSyncOff;

  /// No description provided for @meEventsOnDevice.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 event on device} other{{count} events on device}}'**
  String meEventsOnDevice(int count);

  /// No description provided for @meSyncBody.
  ///
  /// In en, this message translates to:
  /// **'Reviews are saved to this device first. Once sign-in and sync are available, queued review events upload; decks are never re-uploaded.'**
  String get meSyncBody;

  /// No description provided for @meSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get meSettings;

  /// No description provided for @meMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get meMore;

  /// No description provided for @meSyncUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sync now · not available yet'**
  String get meSyncUnavailable;

  /// No description provided for @importAction.
  ///
  /// In en, this message translates to:
  /// **'Import .qdeck'**
  String get importAction;

  /// No description provided for @importTitle.
  ///
  /// In en, this message translates to:
  /// **'Import .qdeck'**
  String get importTitle;

  /// No description provided for @importChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking the file…'**
  String get importChecking;

  /// No description provided for @importNewBadge.
  ///
  /// In en, this message translates to:
  /// **'New deck'**
  String get importNewBadge;

  /// No description provided for @importUpdateBadge.
  ///
  /// In en, this message translates to:
  /// **'Update v{from} → v{to}'**
  String importUpdateBadge(int from, int to);

  /// No description provided for @importSpecVersion.
  ///
  /// In en, this message translates to:
  /// **'spec v{version}'**
  String importSpecVersion(int version);

  /// No description provided for @importDeckVersion.
  ///
  /// In en, this message translates to:
  /// **'deck v{version}'**
  String importDeckVersion(int version);

  /// No description provided for @importCheckArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive paths are safe'**
  String get importCheckArchive;

  /// No description provided for @importCheckArchiveDetail.
  ///
  /// In en, this message translates to:
  /// **'no traversal'**
  String get importCheckArchiveDetail;

  /// No description provided for @importCheckManifest.
  ///
  /// In en, this message translates to:
  /// **'Manifest is valid'**
  String get importCheckManifest;

  /// No description provided for @importCheckChecksum.
  ///
  /// In en, this message translates to:
  /// **'SHA-256 matches'**
  String get importCheckChecksum;

  /// No description provided for @importCheckQuizRules.
  ///
  /// In en, this message translates to:
  /// **'Quizzes follow the rules'**
  String get importCheckQuizRules;

  /// No description provided for @importChanges.
  ///
  /// In en, this message translates to:
  /// **'{added} new · {updated} changed · {removed} removed'**
  String importChanges(int added, int updated, int removed);

  /// No description provided for @importSkipped.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 quiz uses a type this version cannot show and is skipped.} other{{count} quizzes use a type this version cannot show and are skipped.}}'**
  String importSkipped(int count);

  /// No description provided for @importMediaUnsupported.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 media file is not shown yet.} other{{count} media files are not shown yet.}}'**
  String importMediaUnsupported(int count);

  /// No description provided for @importProgressKeptTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress is kept.'**
  String get importProgressKeptTitle;

  /// No description provided for @importProgressKeptBody.
  ///
  /// In en, this message translates to:
  /// **'Installing only adds or updates content on this device; your review history stays as it is.'**
  String get importProgressKeptBody;

  /// No description provided for @importInstallAction.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get importInstallAction;

  /// No description provided for @importUpdateAction.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get importUpdateAction;

  /// No description provided for @importInstalled.
  ///
  /// In en, this message translates to:
  /// **'Installed “{title}”'**
  String importInstalled(String title);

  /// No description provided for @importUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated “{title}”'**
  String importUpdated(String title);

  /// No description provided for @importInstallFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not install: {error}'**
  String importInstallFailed(String error);

  /// No description provided for @importFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'This file can\'t be imported'**
  String get importFailedTitle;

  /// No description provided for @deckManageCards.
  ///
  /// In en, this message translates to:
  /// **'Manage cards'**
  String get deckManageCards;

  /// No description provided for @deckModeMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get deckModeMixed;

  /// No description provided for @deckModeQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes only'**
  String get deckModeQuizzes;

  /// No description provided for @deckModeFlashcards.
  ///
  /// In en, this message translates to:
  /// **'Flashcards only'**
  String get deckModeFlashcards;

  /// No description provided for @deckModeExam.
  ///
  /// In en, this message translates to:
  /// **'Exam'**
  String get deckModeExam;

  /// No description provided for @deckModeMixedDetail.
  ///
  /// In en, this message translates to:
  /// **'Due and new cards of every type.'**
  String get deckModeMixedDetail;

  /// No description provided for @deckModeQuizzesDetail.
  ///
  /// In en, this message translates to:
  /// **'Questions only. No flashcards.'**
  String get deckModeQuizzesDetail;

  /// No description provided for @deckModeFlashcardsDetail.
  ///
  /// In en, this message translates to:
  /// **'Flashcards only.'**
  String get deckModeFlashcardsDetail;

  /// No description provided for @deckModeExamDetailLarge.
  ///
  /// In en, this message translates to:
  /// **'Every type. Between 100 and {count} questions, chosen when you start.'**
  String deckModeExamDetailLarge(int count);

  /// No description provided for @deckModeExamDetailSmall.
  ///
  /// In en, this message translates to:
  /// **'Every type. {count} questions.'**
  String deckModeExamDetailSmall(int count);

  /// No description provided for @deckExamStart.
  ///
  /// In en, this message translates to:
  /// **'Start exam'**
  String get deckExamStart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'it',
    'ja',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
