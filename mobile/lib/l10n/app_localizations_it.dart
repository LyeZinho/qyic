// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => 'Indietro';

  @override
  String get actionBackHome => 'Torna alla home';

  @override
  String get actionCancel => 'Annulla';

  @override
  String get actionClose => 'Chiudi';

  @override
  String get actionContinue => 'Continua';

  @override
  String get actionCreate => 'Crea';

  @override
  String get actionDelete => 'Elimina';

  @override
  String get actionDone => 'Fatto';

  @override
  String get actionEdit => 'Modifica';

  @override
  String get actionRemove => 'Rimuovi';

  @override
  String get actionSave => 'Salva';

  @override
  String errorGeneric(String error) {
    return 'Qualcosa è andato storto.\n$error';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navLibrary => 'Libreria';

  @override
  String get navMe => 'Io';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count carte',
      one: '1 carta',
    );
    return '$_temp0';
  }

  @override
  String quizCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quiz',
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
    return 'Liv. $level';
  }

  @override
  String levelProgress(int level, int xp, int total) {
    return 'Livello $level · $xp / $total XP';
  }

  @override
  String levelUnlocked(int level) {
    return 'Livello $level sbloccato';
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
    return '$count g';
  }

  @override
  String intervalMonths(String value) {
    return '$value mesi';
  }

  @override
  String intervalYears(String value) {
    return '$value a';
  }

  @override
  String get quizTypeMultipleChoice => 'Scelta multipla';

  @override
  String get quizTypeFillInTheBlank => 'Completa la frase';

  @override
  String get quizTypeMatching => 'Abbinamento';

  @override
  String get quizTypeTrueFalse => 'Vero / Falso';

  @override
  String get quizTypeFlashcard => 'Flashcard';

  @override
  String get ratingAgain => 'Di nuovo';

  @override
  String get ratingHard => 'Difficile';

  @override
  String get ratingGood => 'Bene';

  @override
  String get ratingEasy => 'Facile';

  @override
  String get ratingQuestion => 'Quanto bene ricordavi?';

  @override
  String ratingReviewAgainIn(String interval) {
    return 'Ripassa di nuovo tra $interval';
  }

  @override
  String get greetingMorning => 'Buongiorno';

  @override
  String get greetingAfternoon => 'Buon pomeriggio';

  @override
  String get greetingEvening => 'Buonasera';

  @override
  String get homeReady => 'Pronto a studiare?';

  @override
  String get homeSavedOnDevice => 'Salvato sul dispositivo';

  @override
  String get homeTodaysQueue => 'Coda di oggi';

  @override
  String get homeAllCaughtUp => 'Tutto in pari';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks mazzi',
      one: '1 mazzo',
    );
    return 'Circa $minutes min · $_temp0';
  }

  @override
  String get homeStartReview => 'Inizia il ripasso';

  @override
  String get homeExamTeaser =>
      'Pratica mirata e a tempo che conta per la tua pianificazione';

  @override
  String get homeYourDecks => 'I tuoi mazzi';

  @override
  String get librarySearch => 'Cerca nei tuoi mazzi';

  @override
  String get libraryFilterAll => 'Tutti';

  @override
  String get libraryFilterDue => 'Da studiare';

  @override
  String get libraryEmpty =>
      'Ancora nessun mazzo. Creane uno o importa un file .qdeck.';

  @override
  String get libraryNoMatch => 'Nessun mazzo corrisponde.';

  @override
  String get deckNew => 'Nuovo mazzo';

  @override
  String get deckEdit => 'Modifica mazzo';

  @override
  String get deckFieldTitle => 'Titolo';

  @override
  String get deckFieldDescription => 'Descrizione (facoltativa)';

  @override
  String deckDueCount(int count) {
    return '$count da ripassare';
  }

  @override
  String deckNewCount(int count) {
    return '$count nuove';
  }

  @override
  String get deckDone => 'Fatto';

  @override
  String deckBy(String author) {
    return 'di $author';
  }

  @override
  String get deckGone => 'Questo mazzo non esiste più.';

  @override
  String deckDeleteTitle(String title) {
    return 'Eliminare “$title”?';
  }

  @override
  String get deckDeleteBody =>
      'Il mazzo e i suoi quiz vengono rimossi da questo dispositivo. La cronologia dei ripassi viene conservata.';

  @override
  String get deckMetricDue => 'Da ripassare';

  @override
  String get deckMetricRetention => 'Ritenzione';

  @override
  String get deckMetricMature => 'Consolidate';

  @override
  String get deckQuizTypes => 'Tipi di quiz';

  @override
  String get deckQuizzes => 'Quiz';

  @override
  String get deckAddQuiz => 'Aggiungi quiz';

  @override
  String get deckNoQuizzes => 'Ancora nessun quiz. Aggiungi il primo.';

  @override
  String get deckSyncNote =>
      'I tuoi progressi su questo mazzo si sincronizzano come eventi di ripasso. Il mazzo stesso non viene mai ricaricato.';

  @override
  String get deckStudy => 'Studia';

  @override
  String get deckNothingToStudy => 'Niente da studiare ora';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Studia $count carte',
      one: 'Studia 1 carta',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => 'Eliminare questo quiz?';

  @override
  String get quizDeleteTooltip => 'Elimina quiz';

  @override
  String get quizEditorNew => 'Nuovo quiz';

  @override
  String get quizEditorEdit => 'Modifica quiz';

  @override
  String get quizEditorType => 'Tipo';

  @override
  String get quizEditorQuestion => 'Domanda';

  @override
  String get quizEditorStatement => 'Affermazione';

  @override
  String get quizEditorFront => 'Fronte';

  @override
  String get quizEditorSentence => 'Frase — segna lo spazio vuoto con ___';

  @override
  String get quizEditorSentenceHint =>
      'Un .qdeck salva i quiz serializzati con ___ dentro uno ZIP.';

  @override
  String get quizEditorInstructions => 'Istruzioni';

  @override
  String get quizEditorInstructionsHint =>
      'Abbina ogni termine alla sua definizione';

  @override
  String get quizEditorHint => 'Contesto (facoltativo)';

  @override
  String get quizEditorHintHint =>
      'Mostrato sotto la domanda, ad es. una traduzione';

  @override
  String get quizEditorBack => 'Retro';

  @override
  String get quizEditorExplanation => 'Spiegazione (mostrata dopo la risposta)';

  @override
  String get quizEditorOptions => 'Opzioni — seleziona quella corretta';

  @override
  String quizEditorOptionN(int number) {
    return 'Opzione $number';
  }

  @override
  String get quizEditorAddOption => 'Aggiungi opzione';

  @override
  String get quizEditorStatementIs => 'L\'affermazione è';

  @override
  String get quizEditorAccepted => 'Risposte accettate';

  @override
  String quizEditorAnswerN(int number) {
    return 'Risposta $number';
  }

  @override
  String get quizEditorAddAnswer => 'Aggiungi risposta accettata';

  @override
  String get quizEditorPairs => 'Coppie';

  @override
  String get quizEditorTerm => 'Termine';

  @override
  String get quizEditorMatch => 'Abbinamento';

  @override
  String get quizEditorAddPair => 'Aggiungi coppia';

  @override
  String get quizEditorSave => 'Salva quiz';

  @override
  String get issueEmptyQuestion => 'La domanda non può essere vuota.';

  @override
  String get issueEmptyFront => 'Il fronte non può essere vuoto.';

  @override
  String get issueDuplicateOptionIds =>
      'Gli ID delle opzioni devono essere unici.';

  @override
  String get issueTooFewOptions => 'Aggiungi almeno due opzioni.';

  @override
  String get issueEmptyOptions => 'Le opzioni non possono essere vuote.';

  @override
  String get issueDuplicateOptions =>
      'Le opzioni devono essere diverse tra loro.';

  @override
  String get issueNotOneCorrect => 'Segna esattamente un\'opzione corretta.';

  @override
  String get issueTrueFalseOptions =>
      'Vero/falso richiede le opzioni “true” e “false”.';

  @override
  String get issueTrueFalseNoAnswer => 'Scegli se l\'affermazione è vera.';

  @override
  String get issueEmptyBack => 'Il retro non può essere vuoto.';

  @override
  String get issueFlashcardOptions => 'Le flashcard non hanno opzioni.';

  @override
  String get issueNotOneBlank =>
      'Segna esattamente uno spazio vuoto con ___ nella frase.';

  @override
  String get issueNoAnswers => 'Aggiungi almeno una risposta accettata.';

  @override
  String get issueEmptyAnswers =>
      'Le risposte accettate non possono essere vuote.';

  @override
  String get issueAnswerNotCorrect =>
      'Ogni risposta accettata deve essere segnata come corretta.';

  @override
  String get issueTooFewPairs => 'Aggiungi almeno due coppie.';

  @override
  String get issueEmptyPairSide =>
      'Entrambi i lati di ogni coppia devono essere compilati.';

  @override
  String get issueDuplicatePairs =>
      'Termini e abbinamenti devono essere diversi tra loro.';

  @override
  String get studyEnd => 'Termina sessione';

  @override
  String studySaveFailed(String error) {
    return 'Impossibile salvare il ripasso: $error';
  }

  @override
  String get studyAllCaughtUp => 'TUTTO IN PARI';

  @override
  String get studyNothingDue => 'Niente da ripassare al momento.';

  @override
  String get studyNothingDueBody =>
      'Torna più tardi, aggiungi quiz a un mazzo o prova la modalità esame.';

  @override
  String get feedbackCorrect => 'Corretto.';

  @override
  String get feedbackWrong => 'Non proprio.';

  @override
  String choiceAnswer(String answer) {
    return 'Risposta: $answer.';
  }

  @override
  String get trueFalseTrue => 'Vero';

  @override
  String get trueFalseFalse => 'Falso';

  @override
  String get trueFalseExplainAfter => 'Rispondi per vedere la spiegazione';

  @override
  String get fillPrompt => 'Completa la frase';

  @override
  String get fillTypeAnswer => 'Scrivi la risposta';

  @override
  String fillAccepted(String answers) {
    return 'Accettate: $answers.';
  }

  @override
  String fillLetterHint(String letter) {
    return 'Suggerimento: inizia con “$letter”';
  }

  @override
  String get fillShowHint => 'Mostra suggerimento';

  @override
  String get fillCheck => 'Verifica';

  @override
  String get flashcardBack => 'Retro';

  @override
  String get flashcardRecall => 'Ricorda la risposta, poi tocca per scoprirla.';

  @override
  String get flashcardShowAnswer => 'Mostra risposta';

  @override
  String get matchingAllSet =>
      'Tutte le coppie sono pronte. Tocca una tessera per cambiarla.';

  @override
  String matchingInstructions(int remaining, int total) {
    return 'Tocca un termine, poi il suo abbinamento. Mancano $remaining coppie su $total.';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return 'Coppie corrette: $pairs.';
  }

  @override
  String get matchingCheck => 'Verifica coppie';

  @override
  String get sessionComplete => 'SESSIONE COMPLETATA';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count carte.',
      one: '1 carta.',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => 'Ottimo lavoro.';

  @override
  String get sessionKeepGoing => 'Continua così.';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventi di ripasso salvati sul dispositivo',
      one: '1 evento di ripasso salvato sul dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => 'Precisione';

  @override
  String get statXpEarned => 'XP guadagnati';

  @override
  String get statDayStreak => 'Serie di giorni';

  @override
  String get statTime => 'Tempo';

  @override
  String get examTitle => 'Modalità esame';

  @override
  String get examIntro =>
      'Pratica intensa e a tempo. Le carte vengono scelte anche se non sono da ripassare, e ogni risposta è un vero ripasso che aggiorna la tua pianificazione.';

  @override
  String get examQuickName => 'Esame rapido';

  @override
  String get examStart => 'Inizia esame';

  @override
  String get examPresets => 'Preimpostazioni';

  @override
  String get examNewPreset => 'Nuova preimpostazione';

  @override
  String get examEditPreset => 'Modifica preimpostazione';

  @override
  String get examNoPresets =>
      'Ancora nessuna preimpostazione. Salva le configurazioni che usi spesso.';

  @override
  String get examRecent => 'Risultati recenti';

  @override
  String get examNoRuns => 'Nessun esame ancora svolto.';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count domande',
      one: '1 domanda',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return '$seconds s ciascuna';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mazzi',
      one: '1 mazzo',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$correct corrette su $total';
  }

  @override
  String get examUntimed => 'Senza tempo';

  @override
  String get examSelectionWeakest => 'Più deboli prima';

  @override
  String get examSelectionWeakestDetail =>
      'Le carte che rischi di più di dimenticare, in base al ricordo previsto.';

  @override
  String get examSelectionRandom => 'Casuale';

  @override
  String get examSelectionRandomDetail =>
      'Un mix casuale di tutto ciò che è incluso.';

  @override
  String get examSelectionDueFirst => 'Scadute prima';

  @override
  String get examSelectionDueFirstDetail =>
      'Prima le carte in ritardo, poi quelle in arrivo.';

  @override
  String get examEndCompleted => 'Completato';

  @override
  String get examEndTimeUp => 'Tempo scaduto';

  @override
  String get examEndStopped => 'Interrotto';

  @override
  String get examFieldName => 'Nome';

  @override
  String get examFieldDecks => 'Mazzi';

  @override
  String get examAllDecks => 'Tutti i mazzi';

  @override
  String get examFieldSelection => 'Selezione carte';

  @override
  String get examFieldQuestions => 'Domande';

  @override
  String get examFieldTimeLimit => 'Tempo limite';

  @override
  String get examFieldTimePerQuestion => 'Tempo per domanda';

  @override
  String get examFieldQuizTypes => 'Tipi di quiz';

  @override
  String get examFieldIncludeNew => 'Includi carte nuove';

  @override
  String get examFieldIncludeNewDetail =>
      'Chiedi anche le carte che non hai mai studiato.';

  @override
  String get examFieldAutoRate => 'Valuta automaticamente';

  @override
  String get examFieldAutoRateDetail =>
      'Sbagliata è Di nuovo, veloce e giusta è Bene, lenta e giusta è Difficile. Per le flashcard decidi tu.';

  @override
  String get examFieldAllowHints => 'Consenti suggerimenti';

  @override
  String get examFieldAllowHintsDetail =>
      'Offri il suggerimento della prima lettera nei quiz da completare.';

  @override
  String get examAffectsSchedule =>
      'Le risposte d\'esame sono veri ripassi: spostano le carte nella tua pianificazione e fanno guadagnare XP.';

  @override
  String get examIssueEmptyName => 'Dai un nome alla preimpostazione.';

  @override
  String get examIssueNoQuizTypes => 'Scegli almeno un tipo di quiz.';

  @override
  String examIssueQuestionCount(int min, int max) {
    return 'Scegli tra $min e $max domande.';
  }

  @override
  String get examDeleteTitle => 'Eliminare la preimpostazione?';

  @override
  String examDeleteBody(String name) {
    return '“$name” verrà rimossa. I risultati passati vengono conservati.';
  }

  @override
  String get examPill => 'ESAME';

  @override
  String get examStop => 'Interrompi esame';

  @override
  String get examStopTitle => 'Interrompere l\'esame?';

  @override
  String get examStopBody =>
      'Le risposte date finora vengono conservate e contano già per la tua pianificazione.';

  @override
  String get examKeepGoing => 'Continua';

  @override
  String get examQuestionTimeUp => 'Tempo scaduto.';

  @override
  String get examTimeUpBanner =>
      'Il tempo dell\'esame è finito. Questa era l\'ultima domanda.';

  @override
  String examRatedAs(String rating) {
    return 'Valutazione: $rating';
  }

  @override
  String get examNextQuestion => 'Domanda successiva';

  @override
  String get examSeeResults => 'Vedi risultati';

  @override
  String get examAnswered => 'Risposte';

  @override
  String get examUnanswered => 'Senza risposta';

  @override
  String examMissed(int count) {
    return 'Da ripassare ($count)';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ripassi salvati sul dispositivo.',
      one: '1 ripasso salvato sul dispositivo.',
      zero: 'Nessun ripasso registrato.',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'Ripeti';

  @override
  String get examNoCards => 'Nessuna carta da chiedere.';

  @override
  String get examNoCardsBody =>
      'In questi mazzi non ci sono carte con i tipi di quiz selezionati.';

  @override
  String get examNoCardsBodyNew =>
      'Vengono chieste solo carte già studiate. Studia prima qualche carta, oppure attiva “Includi carte nuove” in una preimpostazione.';

  @override
  String get remindersTitle => 'Promemoria';

  @override
  String get remindersIntro =>
      'Ricevi un invito a studiare negli orari che preferisci. I promemoria valgono solo su questo dispositivo.';

  @override
  String get remindersAdd => 'Aggiungi promemoria';

  @override
  String get remindersEmpty => 'Ancora nessun promemoria.';

  @override
  String get remindersNoDays =>
      'Scegli almeno un giorno, altrimenti questo promemoria non scatterà mai.';

  @override
  String get remindersOff => 'Disattivati';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attivi',
      one: '1 attivo',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'Questa piattaforma non può programmare notifiche. I tuoi promemoria sono salvati e valgono sul telefono.';

  @override
  String get remindersPermissionDenied =>
      'Le notifiche sono disattivate per Qyic. Consentile nelle impostazioni di sistema per ricevere i promemoria.';

  @override
  String get reminderTitle => 'È ora di studiare';

  @override
  String get reminderBody =>
      'Pochi minuti adesso mantengono viva la tua serie e la tua memoria.';

  @override
  String get reminderChannel => 'Promemoria di studio';

  @override
  String get prefTitle => 'Preferenze';

  @override
  String get prefSectionGeneral => 'Generali';

  @override
  String get prefSectionStudy => 'Studio';

  @override
  String get prefSectionNotifications => 'Notifiche';

  @override
  String get prefSectionData => 'Dati';

  @override
  String get prefSectionAbout => 'Informazioni';

  @override
  String get prefLanguage => 'Lingua';

  @override
  String get prefSystem => 'Predefinita di sistema';

  @override
  String get prefName => 'Il tuo nome';

  @override
  String get prefDailyGoal => 'Obiettivo giornaliero';

  @override
  String get prefDailyGoalDetail =>
      'Ripassi al giorno per completare il tuo obiettivo.';

  @override
  String get prefNewCards => 'Carte nuove al giorno';

  @override
  String get prefNewCardsDetail =>
      'Carte mai viste introdotte ogni giorno, in tutti i mazzi.';

  @override
  String get prefRetention => 'Ritenzione desiderata';

  @override
  String get prefRetentionDetail =>
      'Una ritenzione più alta significa ripassi più frequenti. Vale per i ripassi futuri.';

  @override
  String get prefIntervals => 'Mostra i prossimi intervalli';

  @override
  String get prefIntervalsDetail =>
      'Indica sui pulsanti di valutazione quando rivedrai la carta.';

  @override
  String get prefHaptics => 'Feedback aptico';

  @override
  String get prefHapticsDetail => 'Vibra a ogni risposta e valutazione.';

  @override
  String get prefStorage => 'Spazio utilizzato';

  @override
  String get prefLicenses => 'Licenze open source';

  @override
  String get meDefaultName => 'Studente';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'serie di $streak giorni',
      one: 'serie di 1 giorno',
    );
    return 'Livello $level · $_temp0';
  }

  @override
  String get meSyncOff => 'Sincronizzazione non configurata';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventi sul dispositivo',
      one: '1 evento sul dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      'I ripassi vengono salvati prima su questo dispositivo. Quando accesso e sincronizzazione saranno disponibili, gli eventi di ripasso in coda verranno caricati; i mazzi non vengono mai ricaricati.';

  @override
  String get meSettings => 'Impostazioni';

  @override
  String get meMore => 'Altro';

  @override
  String get meSyncUnavailable => 'Sincronizza ora · non ancora disponibile';

  @override
  String get importAction => 'Importa .qdeck';

  @override
  String get importTitle => 'Importa .qdeck';

  @override
  String get importChecking => 'Controllo del file…';

  @override
  String get importNewBadge => 'Nuovo mazzo';

  @override
  String importUpdateBadge(int from, int to) {
    return 'Aggiornamento v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return 'spec v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'mazzo v$version';
  }

  @override
  String get importCheckArchive => 'I percorsi dell\'archivio sono sicuri';

  @override
  String get importCheckArchiveDetail => 'nessun path traversal';

  @override
  String get importCheckManifest => 'Il manifest è valido';

  @override
  String get importCheckChecksum => 'SHA-256 corrispondente';

  @override
  String get importCheckQuizRules => 'I quiz rispettano le regole';

  @override
  String importChanges(int added, int updated, int removed) {
    return '$added nuovi · $updated modificati · $removed rimossi';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count quiz usano un tipo che questa versione non può mostrare e vengono saltati.',
      one:
          '1 quiz usa un tipo che questa versione non può mostrare e viene saltato.',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file multimediali non vengono ancora mostrati.',
      one: '1 file multimediale non viene ancora mostrato.',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => 'I tuoi progressi sono al sicuro.';

  @override
  String get importProgressKeptBody =>
      'L\'installazione aggiunge o aggiorna solo i contenuti su questo dispositivo; la cronologia dei ripassi resta invariata.';

  @override
  String get importInstallAction => 'Installa';

  @override
  String get importUpdateAction => 'Aggiorna';

  @override
  String importInstalled(String title) {
    return '“$title” installato';
  }

  @override
  String importUpdated(String title) {
    return '“$title” aggiornato';
  }

  @override
  String importInstallFailed(String error) {
    return 'Impossibile installare: $error';
  }

  @override
  String get importFailedTitle => 'Questo file non può essere importato';

  @override
  String get deckManageCards => 'Gestisci carte';

  @override
  String get deckModeMixed => 'Misto';

  @override
  String get deckModeQuizzes => 'Solo domande';

  @override
  String get deckModeFlashcards => 'Solo flashcard';

  @override
  String get deckModeExam => 'Esame';

  @override
  String get deckModeMixedDetail => 'Carte nuove e in scadenza, di ogni tipo.';

  @override
  String get deckModeQuizzesDetail => 'Solo domande. Niente flashcard.';

  @override
  String get deckModeFlashcardsDetail => 'Solo flashcard.';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'Tutti i tipi. Tra 100 e $count domande, scelte all\'avvio.';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'Tutti i tipi. $count domande.';
  }

  @override
  String get deckExamStart => 'Inizia esame';
}
