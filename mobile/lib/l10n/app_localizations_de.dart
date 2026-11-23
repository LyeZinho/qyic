// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => 'Zurück';

  @override
  String get actionBackHome => 'Zur Startseite';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionClose => 'Schließen';

  @override
  String get actionContinue => 'Weiter';

  @override
  String get actionCreate => 'Erstellen';

  @override
  String get actionDelete => 'Löschen';

  @override
  String get actionDone => 'Fertig';

  @override
  String get actionEdit => 'Bearbeiten';

  @override
  String get actionRemove => 'Entfernen';

  @override
  String get actionSave => 'Speichern';

  @override
  String errorGeneric(String error) {
    return 'Etwas ist schiefgelaufen.\n$error';
  }

  @override
  String get navHome => 'Start';

  @override
  String get navLibrary => 'Bibliothek';

  @override
  String get navMe => 'Ich';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Karten',
      one: '1 Karte',
    );
    return '$_temp0';
  }

  @override
  String quizCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Quizze',
      one: '1 Quiz',
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
    return 'Level $level freigeschaltet';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String durationSeconds(int seconds) {
    return '$seconds s';
  }

  @override
  String intervalMinutes(int count) {
    return '$count Min.';
  }

  @override
  String intervalHours(int count) {
    return '$count Std.';
  }

  @override
  String intervalDays(int count) {
    return '$count Tg.';
  }

  @override
  String intervalMonths(String value) {
    return '$value Mon.';
  }

  @override
  String intervalYears(String value) {
    return '$value J.';
  }

  @override
  String get quizTypeMultipleChoice => 'Multiple Choice';

  @override
  String get quizTypeFillInTheBlank => 'Lückentext';

  @override
  String get quizTypeMatching => 'Zuordnen';

  @override
  String get quizTypeTrueFalse => 'Wahr / Falsch';

  @override
  String get quizTypeFlashcard => 'Karteikarte';

  @override
  String get ratingAgain => 'Nochmal';

  @override
  String get ratingHard => 'Schwer';

  @override
  String get ratingGood => 'Gut';

  @override
  String get ratingEasy => 'Leicht';

  @override
  String get ratingQuestion => 'Wie gut wusstest du es?';

  @override
  String ratingReviewAgainIn(String interval) {
    return 'Wiederholung in $interval';
  }

  @override
  String get greetingMorning => 'Guten Morgen';

  @override
  String get greetingAfternoon => 'Guten Tag';

  @override
  String get greetingEvening => 'Guten Abend';

  @override
  String get homeReady => 'Bereit zum Lernen?';

  @override
  String get homeSavedOnDevice => 'Auf dem Gerät gespeichert';

  @override
  String get homeTodaysQueue => 'Heute dran';

  @override
  String get homeAllCaughtUp => 'Alles erledigt';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks Decks',
      one: '1 Deck',
    );
    return 'Etwa $minutes Min. · $_temp0';
  }

  @override
  String get homeStartReview => 'Wiederholung starten';

  @override
  String get homeExamTeaser =>
      'Gezieltes Üben auf Zeit, das in deinen Lernplan einfließt';

  @override
  String get homeYourDecks => 'Deine Decks';

  @override
  String get librarySearch => 'Decks durchsuchen';

  @override
  String get libraryFilterAll => 'Alle';

  @override
  String get libraryFilterDue => 'Zu lernen';

  @override
  String get libraryEmpty =>
      'Noch keine Decks. Erstelle eins oder importiere eine .qdeck-Datei.';

  @override
  String get libraryNoMatch => 'Keine passenden Decks.';

  @override
  String get deckNew => 'Neues Deck';

  @override
  String get deckEdit => 'Deck bearbeiten';

  @override
  String get deckFieldTitle => 'Titel';

  @override
  String get deckFieldDescription => 'Beschreibung (optional)';

  @override
  String deckDueCount(int count) {
    return '$count fällig';
  }

  @override
  String deckNewCount(int count) {
    return '$count neu';
  }

  @override
  String get deckDone => 'Fertig';

  @override
  String deckBy(String author) {
    return 'von $author';
  }

  @override
  String get deckGone => 'Dieses Deck gibt es nicht mehr.';

  @override
  String deckDeleteTitle(String title) {
    return '„$title“ löschen?';
  }

  @override
  String get deckDeleteBody =>
      'Das Deck und seine Quizze werden von diesem Gerät entfernt. Dein Lernverlauf bleibt erhalten.';

  @override
  String get deckMetricDue => 'Fällig';

  @override
  String get deckMetricRetention => 'Behalten';

  @override
  String get deckMetricMature => 'Gefestigt';

  @override
  String get deckQuizTypes => 'Quiztypen';

  @override
  String get deckQuizzes => 'Quizze';

  @override
  String get deckAddQuiz => 'Quiz hinzufügen';

  @override
  String get deckNoQuizzes => 'Noch keine Quizze. Füge das erste hinzu.';

  @override
  String get deckSyncNote =>
      'Dein Fortschritt in diesem Deck wird als Lernereignisse synchronisiert. Das Deck selbst wird nie erneut hochgeladen.';

  @override
  String get deckStudy => 'Lernen';

  @override
  String get deckNothingToStudy => 'Gerade nichts zu lernen';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Karten lernen',
      one: '1 Karte lernen',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => 'Dieses Quiz löschen?';

  @override
  String get quizDeleteTooltip => 'Quiz löschen';

  @override
  String get quizEditorNew => 'Neues Quiz';

  @override
  String get quizEditorEdit => 'Quiz bearbeiten';

  @override
  String get quizEditorType => 'Typ';

  @override
  String get quizEditorQuestion => 'Frage';

  @override
  String get quizEditorStatement => 'Aussage';

  @override
  String get quizEditorFront => 'Vorderseite';

  @override
  String get quizEditorSentence => 'Satz – markiere die Lücke mit ___';

  @override
  String get quizEditorSentenceHint =>
      'Eine .qdeck speichert Quizze serialisiert mit ___ in einer ZIP-Datei.';

  @override
  String get quizEditorInstructions => 'Anleitung';

  @override
  String get quizEditorInstructionsHint =>
      'Ordne jedem Begriff seine Definition zu';

  @override
  String get quizEditorHint => 'Kontext (optional)';

  @override
  String get quizEditorHintHint =>
      'Wird unter der Frage angezeigt, z. B. eine Übersetzung';

  @override
  String get quizEditorBack => 'Rückseite';

  @override
  String get quizEditorExplanation => 'Erklärung (nach der Antwort angezeigt)';

  @override
  String get quizEditorOptions => 'Optionen – wähle die richtige aus';

  @override
  String quizEditorOptionN(int number) {
    return 'Option $number';
  }

  @override
  String get quizEditorAddOption => 'Option hinzufügen';

  @override
  String get quizEditorStatementIs => 'Die Aussage ist';

  @override
  String get quizEditorAccepted => 'Akzeptierte Antworten';

  @override
  String quizEditorAnswerN(int number) {
    return 'Antwort $number';
  }

  @override
  String get quizEditorAddAnswer => 'Antwort hinzufügen';

  @override
  String get quizEditorPairs => 'Paare';

  @override
  String get quizEditorTerm => 'Begriff';

  @override
  String get quizEditorMatch => 'Gegenstück';

  @override
  String get quizEditorAddPair => 'Paar hinzufügen';

  @override
  String get quizEditorSave => 'Quiz speichern';

  @override
  String get issueEmptyQuestion => 'Die Frage darf nicht leer sein.';

  @override
  String get issueEmptyFront => 'Die Vorderseite darf nicht leer sein.';

  @override
  String get issueDuplicateOptionIds => 'Options-IDs müssen eindeutig sein.';

  @override
  String get issueTooFewOptions => 'Füge mindestens zwei Optionen hinzu.';

  @override
  String get issueEmptyOptions => 'Optionen dürfen nicht leer sein.';

  @override
  String get issueDuplicateOptions => 'Optionen müssen sich unterscheiden.';

  @override
  String get issueNotOneCorrect => 'Markiere genau eine richtige Option.';

  @override
  String get issueTrueFalseOptions =>
      'Wahr/Falsch braucht die Optionen „wahr“ und „falsch“.';

  @override
  String get issueTrueFalseNoAnswer => 'Wähle aus, ob die Aussage stimmt.';

  @override
  String get issueEmptyBack => 'Die Rückseite darf nicht leer sein.';

  @override
  String get issueFlashcardOptions => 'Karteikarten haben keine Optionen.';

  @override
  String get issueNotOneBlank => 'Markiere im Satz genau eine Lücke mit ___.';

  @override
  String get issueNoAnswers =>
      'Füge mindestens eine akzeptierte Antwort hinzu.';

  @override
  String get issueEmptyAnswers =>
      'Akzeptierte Antworten dürfen nicht leer sein.';

  @override
  String get issueAnswerNotCorrect =>
      'Jede akzeptierte Antwort muss als richtig markiert sein.';

  @override
  String get issueTooFewPairs => 'Füge mindestens zwei Paare hinzu.';

  @override
  String get issueEmptyPairSide =>
      'Beide Seiten jedes Paars müssen ausgefüllt sein.';

  @override
  String get issueDuplicatePairs =>
      'Begriffe und Gegenstücke müssen sich unterscheiden.';

  @override
  String get studyEnd => 'Sitzung beenden';

  @override
  String studySaveFailed(String error) {
    return 'Wiederholung konnte nicht gespeichert werden: $error';
  }

  @override
  String get studyAllCaughtUp => 'ALLES ERLEDIGT';

  @override
  String get studyNothingDue => 'Gerade ist nichts fällig.';

  @override
  String get studyNothingDueBody =>
      'Schau später wieder vorbei, füge einem Deck Quizze hinzu oder probier den Prüfungsmodus.';

  @override
  String get feedbackCorrect => 'Richtig.';

  @override
  String get feedbackWrong => 'Nicht ganz.';

  @override
  String choiceAnswer(String answer) {
    return 'Antwort: $answer.';
  }

  @override
  String get trueFalseTrue => 'Wahr';

  @override
  String get trueFalseFalse => 'Falsch';

  @override
  String get trueFalseExplainAfter => 'Antworte, um die Erklärung zu sehen';

  @override
  String get fillPrompt => 'Vervollständige den Satz';

  @override
  String get fillTypeAnswer => 'Antwort eingeben';

  @override
  String fillAccepted(String answers) {
    return 'Akzeptiert: $answers.';
  }

  @override
  String fillLetterHint(String letter) {
    return 'Tipp: beginnt mit „$letter“';
  }

  @override
  String get fillShowHint => 'Tipp zeigen';

  @override
  String get fillCheck => 'Prüfen';

  @override
  String get flashcardBack => 'Rückseite';

  @override
  String get flashcardRecall =>
      'Erinnere dich an die Antwort und tippe dann zum Aufdecken.';

  @override
  String get flashcardShowAnswer => 'Antwort zeigen';

  @override
  String get matchingAllSet =>
      'Alle Paare gesetzt. Tippe auf eine Kachel, um sie zu ändern.';

  @override
  String matchingInstructions(int remaining, int total) {
    return 'Tippe auf einen Begriff, dann auf sein Gegenstück. Noch $remaining von $total Paaren.';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return 'Richtige Paare: $pairs.';
  }

  @override
  String get matchingCheck => 'Paare prüfen';

  @override
  String get sessionComplete => 'SITZUNG BEENDET';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Karten.',
      one: '1 Karte.',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => 'Starke Runde.';

  @override
  String get sessionKeepGoing => 'Bleib dran.';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lernereignisse auf dem Gerät gespeichert',
      one: '1 Lernereignis auf dem Gerät gespeichert',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => 'Genauigkeit';

  @override
  String get statXpEarned => 'XP verdient';

  @override
  String get statDayStreak => 'Tage-Serie';

  @override
  String get statTime => 'Zeit';

  @override
  String get examTitle => 'Prüfungsmodus';

  @override
  String get examIntro =>
      'Intensives Üben auf Zeit. Karten werden auch gewählt, wenn sie nicht fällig sind, und jede Antwort ist eine echte Wiederholung, die deinen Lernplan anpasst.';

  @override
  String get examQuickName => 'Schnelle Prüfung';

  @override
  String get examStart => 'Prüfung starten';

  @override
  String get examPresets => 'Vorlagen';

  @override
  String get examNewPreset => 'Neue Vorlage';

  @override
  String get examEditPreset => 'Vorlage bearbeiten';

  @override
  String get examNoPresets =>
      'Noch keine Vorlagen. Speichere Einstellungen, die du oft nutzt.';

  @override
  String get examRecent => 'Letzte Ergebnisse';

  @override
  String get examNoRuns => 'Noch keine Prüfungen absolviert.';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fragen',
      one: '1 Frage',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return 'je $seconds s';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Decks',
      one: '1 Deck',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$correct von $total richtig';
  }

  @override
  String get examUntimed => 'Ohne Zeitlimit';

  @override
  String get examSelectionWeakest => 'Schwächste zuerst';

  @override
  String get examSelectionWeakestDetail =>
      'Karten, die du am ehesten vergisst – nach vorhergesagter Erinnerung.';

  @override
  String get examSelectionRandom => 'Zufällig';

  @override
  String get examSelectionRandomDetail =>
      'Eine gemischte Auswahl aus allem im Umfang.';

  @override
  String get examSelectionDueFirst => 'Fällige zuerst';

  @override
  String get examSelectionDueFirstDetail =>
      'Überfällige Karten, dann die als Nächstes anstehenden.';

  @override
  String get examEndCompleted => 'Abgeschlossen';

  @override
  String get examEndTimeUp => 'Zeit abgelaufen';

  @override
  String get examEndStopped => 'Vorzeitig beendet';

  @override
  String get examFieldName => 'Name';

  @override
  String get examFieldDecks => 'Decks';

  @override
  String get examAllDecks => 'Alle Decks';

  @override
  String get examFieldSelection => 'Kartenauswahl';

  @override
  String get examFieldQuestions => 'Fragen';

  @override
  String get examFieldTimeLimit => 'Zeitlimit';

  @override
  String get examFieldTimePerQuestion => 'Zeit pro Frage';

  @override
  String get examFieldQuizTypes => 'Quiztypen';

  @override
  String get examFieldIncludeNew => 'Neue Karten einbeziehen';

  @override
  String get examFieldIncludeNewDetail =>
      'Auch Karten abfragen, die du noch nie gelernt hast.';

  @override
  String get examFieldAutoRate => 'Automatisch bewerten';

  @override
  String get examFieldAutoRateDetail =>
      'Falsch ist Nochmal, schnell und richtig ist Gut, langsam und richtig ist Schwer. Bei Karteikarten fragen wir weiterhin dich.';

  @override
  String get examFieldAllowHints => 'Tipps erlauben';

  @override
  String get examFieldAllowHintsDetail =>
      'Bei Lückentexten den Anfangsbuchstaben als Tipp anbieten.';

  @override
  String get examAffectsSchedule =>
      'Prüfungsantworten sind echte Wiederholungen: Sie verschieben Karten in deinem Lernplan und bringen XP.';

  @override
  String get examIssueEmptyName => 'Gib der Vorlage einen Namen.';

  @override
  String get examIssueNoQuizTypes => 'Wähle mindestens einen Quiztyp.';

  @override
  String examIssueQuestionCount(int min, int max) {
    return 'Wähle zwischen $min und $max Fragen.';
  }

  @override
  String get examDeleteTitle => 'Vorlage löschen?';

  @override
  String examDeleteBody(String name) {
    return '„$name“ wird entfernt. Frühere Ergebnisse bleiben erhalten.';
  }

  @override
  String get examPill => 'PRÜFUNG';

  @override
  String get examStop => 'Prüfung beenden';

  @override
  String get examStopTitle => 'Prüfung beenden?';

  @override
  String get examStopBody =>
      'Bisherige Antworten bleiben erhalten und zählen bereits für deinen Lernplan.';

  @override
  String get examKeepGoing => 'Weitermachen';

  @override
  String get examQuestionTimeUp => 'Zeit abgelaufen.';

  @override
  String get examTimeUpBanner =>
      'Die Prüfungszeit ist vorbei. Das war die letzte Frage.';

  @override
  String examRatedAs(String rating) {
    return 'Bewertet: $rating';
  }

  @override
  String get examNextQuestion => 'Nächste Frage';

  @override
  String get examSeeResults => 'Ergebnisse ansehen';

  @override
  String get examAnswered => 'Beantwortet';

  @override
  String get examUnanswered => 'Unbeantwortet';

  @override
  String examMissed(int count) {
    return 'Zum Wiederholen ($count)';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wiederholungen auf dem Gerät gespeichert.',
      one: '1 Wiederholung auf dem Gerät gespeichert.',
      zero: 'Es wurden keine Wiederholungen erfasst.',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'Wiederholen';

  @override
  String get examNoCards => 'Keine Karten zum Abfragen.';

  @override
  String get examNoCardsBody =>
      'In diesen Decks gibt es keine Karten mit den gewählten Quiztypen.';

  @override
  String get examNoCardsBodyNew =>
      'Es werden nur bereits gelernte Karten abgefragt. Lerne zuerst ein paar Karten oder aktiviere „Neue Karten einbeziehen“ in einer Vorlage.';

  @override
  String get remindersTitle => 'Erinnerungen';

  @override
  String get remindersIntro =>
      'Lass dich zu den Zeiten ans Lernen erinnern, die dir passen. Erinnerungen gelten nur auf diesem Gerät.';

  @override
  String get remindersAdd => 'Erinnerung hinzufügen';

  @override
  String get remindersEmpty => 'Noch keine Erinnerungen.';

  @override
  String get remindersNoDays =>
      'Wähle mindestens einen Tag, sonst wird diese Erinnerung nie ausgelöst.';

  @override
  String get remindersOff => 'Aus';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aktiv',
      one: '1 aktiv',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'Diese Plattform kann keine Benachrichtigungen planen. Deine Erinnerungen werden gespeichert und gelten auf deinem Handy.';

  @override
  String get remindersPermissionDenied =>
      'Benachrichtigungen für Qyic sind deaktiviert. Erlaube sie in den Systemeinstellungen, um Erinnerungen zu erhalten.';

  @override
  String get reminderTitle => 'Zeit zum Lernen';

  @override
  String get reminderBody =>
      'Ein paar Minuten jetzt halten deine Serie und dein Gedächtnis in Schwung.';

  @override
  String get reminderChannel => 'Lernerinnerungen';

  @override
  String get prefTitle => 'Einstellungen';

  @override
  String get prefSectionGeneral => 'Allgemein';

  @override
  String get prefSectionStudy => 'Lernen';

  @override
  String get prefSectionNotifications => 'Benachrichtigungen';

  @override
  String get prefSectionData => 'Daten';

  @override
  String get prefSectionAbout => 'Über';

  @override
  String get prefLanguage => 'Sprache';

  @override
  String get prefSystem => 'Systemstandard';

  @override
  String get prefName => 'Dein Name';

  @override
  String get prefDailyGoal => 'Tagesziel';

  @override
  String get prefDailyGoalDetail =>
      'Wiederholungen pro Tag, mit denen du dein Ziel erreichst.';

  @override
  String get prefNewCards => 'Neue Karten pro Tag';

  @override
  String get prefNewCardsDetail =>
      'Noch nie gesehene Karten, die täglich über alle Decks hinzukommen.';

  @override
  String get prefRetention => 'Gewünschte Behaltensrate';

  @override
  String get prefRetentionDetail =>
      'Eine höhere Behaltensrate bedeutet häufigere Wiederholungen. Gilt für künftige Wiederholungen.';

  @override
  String get prefIntervals => 'Nächste Intervalle zeigen';

  @override
  String get prefIntervalsDetail =>
      'Zeigt auf den Bewertungsknöpfen, wann du die Karte wiedersiehst.';

  @override
  String get prefHaptics => 'Haptisches Feedback';

  @override
  String get prefHapticsDetail => 'Vibrieren bei Antworten und Bewertungen.';

  @override
  String get prefStorage => 'Belegter Speicher';

  @override
  String get prefLicenses => 'Open-Source-Lizenzen';

  @override
  String get meDefaultName => 'Lernende';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak Tage Serie',
      one: '1 Tag Serie',
    );
    return 'Level $level · $_temp0';
  }

  @override
  String get meSyncOff => 'Sync nicht eingerichtet';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Ereignisse auf dem Gerät',
      one: '1 Ereignis auf dem Gerät',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      'Wiederholungen werden zuerst auf diesem Gerät gespeichert. Sobald Anmeldung und Sync verfügbar sind, werden wartende Lernereignisse hochgeladen; Decks werden nie erneut hochgeladen.';

  @override
  String get meSettings => 'Einstellungen';

  @override
  String get meMore => 'Mehr';

  @override
  String get meSyncUnavailable =>
      'Jetzt synchronisieren · noch nicht verfügbar';

  @override
  String get importAction => '.qdeck importieren';

  @override
  String get importTitle => '.qdeck importieren';

  @override
  String get importChecking => 'Datei wird geprüft…';

  @override
  String get importNewBadge => 'Neues Deck';

  @override
  String importUpdateBadge(int from, int to) {
    return 'Update v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return 'Spec v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'Deck v$version';
  }

  @override
  String get importCheckArchive => 'Archivpfade sind sicher';

  @override
  String get importCheckArchiveDetail => 'kein Path Traversal';

  @override
  String get importCheckManifest => 'Manifest ist gültig';

  @override
  String get importCheckChecksum => 'SHA-256 stimmt überein';

  @override
  String get importCheckQuizRules => 'Quizze erfüllen die Regeln';

  @override
  String importChanges(int added, int updated, int removed) {
    return '$added neu · $updated geändert · $removed entfernt';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Quizze nutzen einen Typ, den diese Version nicht anzeigen kann, und werden übersprungen.',
      one:
          '1 Quiz nutzt einen Typ, den diese Version nicht anzeigen kann, und wird übersprungen.',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Mediendateien werden noch nicht angezeigt.',
      one: '1 Mediendatei wird noch nicht angezeigt.',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => 'Dein Fortschritt bleibt erhalten.';

  @override
  String get importProgressKeptBody =>
      'Die Installation fügt Inhalte auf diesem Gerät nur hinzu oder aktualisiert sie; dein Lernverlauf bleibt unverändert.';

  @override
  String get importInstallAction => 'Installieren';

  @override
  String get importUpdateAction => 'Aktualisieren';

  @override
  String importInstalled(String title) {
    return '„$title“ installiert';
  }

  @override
  String importUpdated(String title) {
    return '„$title“ aktualisiert';
  }

  @override
  String importInstallFailed(String error) {
    return 'Installation fehlgeschlagen: $error';
  }

  @override
  String get importFailedTitle => 'Diese Datei kann nicht importiert werden';

  @override
  String get deckManageCards => 'Karten verwalten';

  @override
  String get deckModeMixed => 'Gemischt';

  @override
  String get deckModeQuizzes => 'Nur Fragen';

  @override
  String get deckModeFlashcards => 'Nur Karten';

  @override
  String get deckModeExam => 'Prüfung';

  @override
  String get deckModeMixedDetail => 'Fällige und neue Karten, alle Typen.';

  @override
  String get deckModeQuizzesDetail => 'Nur Fragen. Keine Karteikarten.';

  @override
  String get deckModeFlashcardsDetail => 'Nur Karteikarten.';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'Alle Typen. Zwischen 100 und $count Fragen, beim Start gewählt.';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'Alle Typen. $count Fragen.';
  }

  @override
  String get deckExamStart => 'Prüfung starten';
}
