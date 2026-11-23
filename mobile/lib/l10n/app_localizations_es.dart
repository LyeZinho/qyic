// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => 'Atrás';

  @override
  String get actionBackHome => 'Volver al inicio';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionClose => 'Cerrar';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionCreate => 'Crear';

  @override
  String get actionDelete => 'Eliminar';

  @override
  String get actionDone => 'Listo';

  @override
  String get actionEdit => 'Editar';

  @override
  String get actionRemove => 'Quitar';

  @override
  String get actionSave => 'Guardar';

  @override
  String errorGeneric(String error) {
    return 'Algo salió mal.\n$error';
  }

  @override
  String get navHome => 'Inicio';

  @override
  String get navLibrary => 'Biblioteca';

  @override
  String get navMe => 'Yo';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tarjetas',
      one: '1 tarjeta',
    );
    return '$_temp0';
  }

  @override
  String quizCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count preguntas',
      one: '1 pregunta',
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
    return 'Nv. $level';
  }

  @override
  String levelProgress(int level, int xp, int total) {
    return 'Nivel $level · $xp / $total XP';
  }

  @override
  String levelUnlocked(int level) {
    return 'Nivel $level desbloqueado';
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
    return '$value mes.';
  }

  @override
  String intervalYears(String value) {
    return '$value a';
  }

  @override
  String get quizTypeMultipleChoice => 'Opción múltiple';

  @override
  String get quizTypeFillInTheBlank => 'Completar el hueco';

  @override
  String get quizTypeMatching => 'Emparejar';

  @override
  String get quizTypeTrueFalse => 'Verdadero / Falso';

  @override
  String get quizTypeFlashcard => 'Tarjeta';

  @override
  String get ratingAgain => 'Otra vez';

  @override
  String get ratingHard => 'Difícil';

  @override
  String get ratingGood => 'Bien';

  @override
  String get ratingEasy => 'Fácil';

  @override
  String get ratingQuestion => '¿Qué tan bien lo recordaste?';

  @override
  String ratingReviewAgainIn(String interval) {
    return 'Repasar de nuevo en $interval';
  }

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get homeReady => '¿Estudiamos?';

  @override
  String get homeSavedOnDevice => 'Guardado en el dispositivo';

  @override
  String get homeTodaysQueue => 'Cola de hoy';

  @override
  String get homeAllCaughtUp => 'Todo al día';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks mazos',
      one: '1 mazo',
    );
    return 'Unos $minutes min · $_temp0';
  }

  @override
  String get homeStartReview => 'Empezar repaso';

  @override
  String get homeExamTeaser =>
      'Práctica cronometrada y concentrada que cuenta para tu calendario';

  @override
  String get homeYourDecks => 'Tus mazos';

  @override
  String get librarySearch => 'Busca en tus mazos';

  @override
  String get libraryFilterAll => 'Todos';

  @override
  String get libraryFilterDue => 'Por estudiar';

  @override
  String get libraryEmpty =>
      'Aún no tienes mazos. Crea uno o importa un archivo .qdeck.';

  @override
  String get libraryNoMatch => 'Ningún mazo coincide.';

  @override
  String get deckNew => 'Nuevo mazo';

  @override
  String get deckEdit => 'Editar mazo';

  @override
  String get deckFieldTitle => 'Título';

  @override
  String get deckFieldDescription => 'Descripción (opcional)';

  @override
  String deckDueCount(int count) {
    return '$count pendientes';
  }

  @override
  String deckNewCount(int count) {
    return '$count nuevas';
  }

  @override
  String get deckDone => 'Listo';

  @override
  String deckBy(String author) {
    return 'por $author';
  }

  @override
  String get deckGone => 'Este mazo ya no existe.';

  @override
  String deckDeleteTitle(String title) {
    return '¿Eliminar «$title»?';
  }

  @override
  String get deckDeleteBody =>
      'El mazo y sus preguntas se eliminan de este dispositivo. Tu historial de repasos se conserva.';

  @override
  String get deckMetricDue => 'Pendientes';

  @override
  String get deckMetricRetention => 'Retención';

  @override
  String get deckMetricMature => 'Maduras';

  @override
  String get deckQuizTypes => 'Tipos de pregunta';

  @override
  String get deckQuizzes => 'Preguntas';

  @override
  String get deckAddQuiz => 'Añadir pregunta';

  @override
  String get deckNoQuizzes => 'Aún no hay preguntas. Añade la primera.';

  @override
  String get deckSyncNote =>
      'Tu progreso en este mazo se sincroniza como eventos de repaso. El mazo en sí nunca se vuelve a subir.';

  @override
  String get deckStudy => 'Estudiar';

  @override
  String get deckNothingToStudy => 'Nada que estudiar ahora';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Estudiar $count tarjetas',
      one: 'Estudiar 1 tarjeta',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => '¿Eliminar esta pregunta?';

  @override
  String get quizDeleteTooltip => 'Eliminar pregunta';

  @override
  String get quizEditorNew => 'Nueva pregunta';

  @override
  String get quizEditorEdit => 'Editar pregunta';

  @override
  String get quizEditorType => 'Tipo';

  @override
  String get quizEditorQuestion => 'Pregunta';

  @override
  String get quizEditorStatement => 'Afirmación';

  @override
  String get quizEditorFront => 'Anverso';

  @override
  String get quizEditorSentence => 'Frase: marca el hueco con ___';

  @override
  String get quizEditorSentenceHint =>
      'Un .qdeck guarda las preguntas serializadas con ___ dentro de un ZIP.';

  @override
  String get quizEditorInstructions => 'Instrucciones';

  @override
  String get quizEditorInstructionsHint =>
      'Empareja cada término con su definición';

  @override
  String get quizEditorHint => 'Contexto (opcional)';

  @override
  String get quizEditorHintHint =>
      'Se muestra bajo la pregunta, p. ej. una traducción';

  @override
  String get quizEditorBack => 'Reverso';

  @override
  String get quizEditorExplanation => 'Explicación (se muestra tras responder)';

  @override
  String get quizEditorOptions => 'Opciones: selecciona la correcta';

  @override
  String quizEditorOptionN(int number) {
    return 'Opción $number';
  }

  @override
  String get quizEditorAddOption => 'Añadir opción';

  @override
  String get quizEditorStatementIs => 'La afirmación es';

  @override
  String get quizEditorAccepted => 'Respuestas aceptadas';

  @override
  String quizEditorAnswerN(int number) {
    return 'Respuesta $number';
  }

  @override
  String get quizEditorAddAnswer => 'Añadir respuesta aceptada';

  @override
  String get quizEditorPairs => 'Parejas';

  @override
  String get quizEditorTerm => 'Término';

  @override
  String get quizEditorMatch => 'Pareja';

  @override
  String get quizEditorAddPair => 'Añadir pareja';

  @override
  String get quizEditorSave => 'Guardar pregunta';

  @override
  String get issueEmptyQuestion => 'La pregunta no puede estar vacía.';

  @override
  String get issueEmptyFront => 'El anverso no puede estar vacío.';

  @override
  String get issueDuplicateOptionIds =>
      'Los identificadores de las opciones deben ser únicos.';

  @override
  String get issueTooFewOptions => 'Añade al menos dos opciones.';

  @override
  String get issueEmptyOptions => 'Las opciones no pueden estar vacías.';

  @override
  String get issueDuplicateOptions => 'Las opciones deben ser distintas.';

  @override
  String get issueNotOneCorrect => 'Marca exactamente una opción correcta.';

  @override
  String get issueTrueFalseOptions =>
      'Verdadero/falso necesita las opciones «verdadero» y «falso».';

  @override
  String get issueTrueFalseNoAnswer => 'Elige si la afirmación es cierta.';

  @override
  String get issueEmptyBack => 'El reverso no puede estar vacío.';

  @override
  String get issueFlashcardOptions => 'Las tarjetas no tienen opciones.';

  @override
  String get issueNotOneBlank =>
      'Marca exactamente un hueco con ___ en la frase.';

  @override
  String get issueNoAnswers => 'Añade al menos una respuesta aceptada.';

  @override
  String get issueEmptyAnswers =>
      'Las respuestas aceptadas no pueden estar vacías.';

  @override
  String get issueAnswerNotCorrect =>
      'Todas las respuestas aceptadas deben marcarse como correctas.';

  @override
  String get issueTooFewPairs => 'Añade al menos dos parejas.';

  @override
  String get issueEmptyPairSide =>
      'Los dos lados de cada pareja deben estar completos.';

  @override
  String get issueDuplicatePairs =>
      'Los términos y sus parejas deben ser distintos.';

  @override
  String get studyEnd => 'Terminar sesión';

  @override
  String studySaveFailed(String error) {
    return 'No se pudo guardar el repaso: $error';
  }

  @override
  String get studyAllCaughtUp => 'TODO AL DÍA';

  @override
  String get studyNothingDue => 'No hay nada pendiente ahora.';

  @override
  String get studyNothingDueBody =>
      'Vuelve más tarde, añade preguntas a un mazo o prueba el modo examen.';

  @override
  String get feedbackCorrect => 'Correcto.';

  @override
  String get feedbackWrong => 'Casi.';

  @override
  String choiceAnswer(String answer) {
    return 'Respuesta: $answer.';
  }

  @override
  String get trueFalseTrue => 'Verdadero';

  @override
  String get trueFalseFalse => 'Falso';

  @override
  String get trueFalseExplainAfter => 'Responde para ver la explicación';

  @override
  String get fillPrompt => 'Completa la frase';

  @override
  String get fillTypeAnswer => 'Escribe la respuesta';

  @override
  String fillAccepted(String answers) {
    return 'Aceptadas: $answers.';
  }

  @override
  String fillLetterHint(String letter) {
    return 'Pista: empieza por «$letter»';
  }

  @override
  String get fillShowHint => 'Ver pista';

  @override
  String get fillCheck => 'Comprobar';

  @override
  String get flashcardBack => 'Reverso';

  @override
  String get flashcardRecall => 'Recuerda la respuesta y toca para verla.';

  @override
  String get flashcardShowAnswer => 'Ver respuesta';

  @override
  String get matchingAllSet =>
      'Todas las parejas listas. Toca una ficha para cambiarla.';

  @override
  String matchingInstructions(int remaining, int total) {
    return 'Toca un término y luego su pareja. Quedan $remaining de $total parejas.';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return 'Parejas correctas: $pairs.';
  }

  @override
  String get matchingCheck => 'Comprobar parejas';

  @override
  String get sessionComplete => 'SESIÓN COMPLETADA';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tarjetas.',
      one: '1 tarjeta.',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => '¡Buen trabajo!';

  @override
  String get sessionKeepGoing => 'Sigue así.';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos de repaso guardados en el dispositivo',
      one: '1 evento de repaso guardado en el dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => 'Precisión';

  @override
  String get statXpEarned => 'XP ganados';

  @override
  String get statDayStreak => 'Racha de días';

  @override
  String get statTime => 'Tiempo';

  @override
  String get examTitle => 'Modo examen';

  @override
  String get examIntro =>
      'Práctica intensa y cronometrada. Se eligen tarjetas aunque no estén pendientes, y cada respuesta es un repaso real que actualiza tu calendario.';

  @override
  String get examQuickName => 'Examen rápido';

  @override
  String get examStart => 'Empezar examen';

  @override
  String get examPresets => 'Ajustes guardados';

  @override
  String get examNewPreset => 'Nuevo ajuste';

  @override
  String get examEditPreset => 'Editar ajuste';

  @override
  String get examNoPresets =>
      'Aún no hay ajustes guardados. Guarda las configuraciones que más uses.';

  @override
  String get examRecent => 'Resultados recientes';

  @override
  String get examNoRuns => 'Aún no has hecho ningún examen.';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count preguntas',
      one: '1 pregunta',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return '$seconds s cada una';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mazos',
      one: '1 mazo',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$correct de $total correctas';
  }

  @override
  String get examUntimed => 'Sin límite de tiempo';

  @override
  String get examSelectionWeakest => 'Más débiles primero';

  @override
  String get examSelectionWeakestDetail =>
      'Las tarjetas que más probablemente olvidarás, según el recuerdo previsto.';

  @override
  String get examSelectionRandom => 'Aleatorio';

  @override
  String get examSelectionRandomDetail =>
      'Una mezcla aleatoria de todo lo seleccionado.';

  @override
  String get examSelectionDueFirst => 'Pendientes primero';

  @override
  String get examSelectionDueFirstDetail =>
      'Primero las tarjetas atrasadas y luego las próximas.';

  @override
  String get examEndCompleted => 'Completado';

  @override
  String get examEndTimeUp => 'Se acabó el tiempo';

  @override
  String get examEndStopped => 'Detenido antes';

  @override
  String get examFieldName => 'Nombre';

  @override
  String get examFieldDecks => 'Mazos';

  @override
  String get examAllDecks => 'Todos los mazos';

  @override
  String get examFieldSelection => 'Selección de tarjetas';

  @override
  String get examFieldQuestions => 'Preguntas';

  @override
  String get examFieldTimeLimit => 'Límite de tiempo';

  @override
  String get examFieldTimePerQuestion => 'Tiempo por pregunta';

  @override
  String get examFieldQuizTypes => 'Tipos de pregunta';

  @override
  String get examFieldIncludeNew => 'Incluir tarjetas nuevas';

  @override
  String get examFieldIncludeNewDetail =>
      'Pregunta también tarjetas que nunca has estudiado.';

  @override
  String get examFieldAutoRate => 'Calificar automáticamente';

  @override
  String get examFieldAutoRateDetail =>
      'Incorrecta es Otra vez, rápida y correcta es Bien, lenta y correcta es Difícil. En las tarjetas sigues calificando tú.';

  @override
  String get examFieldAllowHints => 'Permitir pistas';

  @override
  String get examFieldAllowHintsDetail =>
      'Ofrece la pista de la primera letra en las preguntas de completar el hueco.';

  @override
  String get examAffectsSchedule =>
      'Las respuestas del examen son repasos reales: mueven tarjetas en tu calendario y dan XP.';

  @override
  String get examIssueEmptyName => 'Ponle un nombre al ajuste.';

  @override
  String get examIssueNoQuizTypes => 'Elige al menos un tipo de pregunta.';

  @override
  String examIssueQuestionCount(int min, int max) {
    return 'Elige entre $min y $max preguntas.';
  }

  @override
  String get examDeleteTitle => '¿Eliminar ajuste?';

  @override
  String examDeleteBody(String name) {
    return 'Se eliminará «$name». Los resultados anteriores se conservan.';
  }

  @override
  String get examPill => 'EXAMEN';

  @override
  String get examStop => 'Detener examen';

  @override
  String get examStopTitle => '¿Detener el examen?';

  @override
  String get examStopBody =>
      'Las respuestas dadas se conservan y ya cuentan para tu calendario.';

  @override
  String get examKeepGoing => 'Seguir';

  @override
  String get examQuestionTimeUp => 'Se acabó el tiempo.';

  @override
  String get examTimeUpBanner =>
      'El tiempo del examen terminó. Esta fue la última pregunta.';

  @override
  String examRatedAs(String rating) {
    return 'Calificación: $rating';
  }

  @override
  String get examNextQuestion => 'Siguiente pregunta';

  @override
  String get examSeeResults => 'Ver resultados';

  @override
  String get examAnswered => 'Respondidas';

  @override
  String get examUnanswered => 'Sin responder';

  @override
  String examMissed(int count) {
    return 'Para repasar ($count)';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count repasos guardados en el dispositivo.',
      one: '1 repaso guardado en el dispositivo.',
      zero: 'No se registró ningún repaso.',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'Repetir';

  @override
  String get examNoCards => 'No hay tarjetas que preguntar.';

  @override
  String get examNoCardsBody =>
      'No hay tarjetas en estos mazos con los tipos de pregunta seleccionados.';

  @override
  String get examNoCardsBodyNew =>
      'Solo se preguntan tarjetas ya estudiadas. Estudia algunas primero o activa «Incluir tarjetas nuevas» en un ajuste.';

  @override
  String get remindersTitle => 'Recordatorios';

  @override
  String get remindersIntro =>
      'Recibe un aviso para estudiar a las horas que mejor te vengan. Los recordatorios solo se configuran en este dispositivo.';

  @override
  String get remindersAdd => 'Añadir recordatorio';

  @override
  String get remindersEmpty => 'Aún no hay recordatorios.';

  @override
  String get remindersNoDays =>
      'Elige al menos un día o este recordatorio nunca sonará.';

  @override
  String get remindersOff => 'Desactivados';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count activos',
      one: '1 activo',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'Esta plataforma no puede programar notificaciones. Tus recordatorios se guardan y se aplican en tu teléfono.';

  @override
  String get remindersPermissionDenied =>
      'Las notificaciones de Qyic están desactivadas. Permítelas en los ajustes del sistema para recibir recordatorios.';

  @override
  String get reminderTitle => 'Hora de estudiar';

  @override
  String get reminderBody =>
      'Unos minutos ahora mantienen viva tu racha y tu memoria.';

  @override
  String get reminderChannel => 'Recordatorios de estudio';

  @override
  String get prefTitle => 'Preferencias';

  @override
  String get prefSectionGeneral => 'General';

  @override
  String get prefSectionStudy => 'Estudio';

  @override
  String get prefSectionNotifications => 'Notificaciones';

  @override
  String get prefSectionData => 'Datos';

  @override
  String get prefSectionAbout => 'Acerca de';

  @override
  String get prefLanguage => 'Idioma';

  @override
  String get prefSystem => 'Predeterminado del sistema';

  @override
  String get prefName => 'Tu nombre';

  @override
  String get prefDailyGoal => 'Meta diaria';

  @override
  String get prefDailyGoalDetail => 'Repasos al día para cumplir tu meta.';

  @override
  String get prefNewCards => 'Tarjetas nuevas al día';

  @override
  String get prefNewCardsDetail =>
      'Tarjetas nunca vistas que se presentan cada día, en todos los mazos.';

  @override
  String get prefRetention => 'Retención deseada';

  @override
  String get prefRetentionDetail =>
      'Más retención significa repasos más frecuentes. Se aplica a los repasos futuros.';

  @override
  String get prefIntervals => 'Mostrar próximos intervalos';

  @override
  String get prefIntervalsDetail =>
      'Indica en los botones de calificación cuándo volverás a ver la tarjeta.';

  @override
  String get prefHaptics => 'Respuesta háptica';

  @override
  String get prefHapticsDetail => 'Vibrar al responder y calificar.';

  @override
  String get prefStorage => 'Almacenamiento usado';

  @override
  String get prefLicenses => 'Licencias de código abierto';

  @override
  String get meDefaultName => 'Estudiante';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'racha de $streak días',
      one: 'racha de 1 día',
    );
    return 'Nivel $level · $_temp0';
  }

  @override
  String get meSyncOff => 'Sincronización no configurada';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos en el dispositivo',
      one: '1 evento en el dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      'Los repasos se guardan primero en este dispositivo. Cuando el inicio de sesión y la sincronización estén disponibles, los eventos de repaso en cola se subirán; los mazos nunca se vuelven a subir.';

  @override
  String get meSettings => 'Ajustes';

  @override
  String get meMore => 'Más';

  @override
  String get meSyncUnavailable => 'Sincronizar ahora · aún no disponible';

  @override
  String get importAction => 'Importar .qdeck';

  @override
  String get importTitle => 'Importar .qdeck';

  @override
  String get importChecking => 'Comprobando el archivo…';

  @override
  String get importNewBadge => 'Nuevo mazo';

  @override
  String importUpdateBadge(int from, int to) {
    return 'Actualizar v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return 'spec v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'mazo v$version';
  }

  @override
  String get importCheckArchive => 'Las rutas del archivo son seguras';

  @override
  String get importCheckArchiveDetail => 'sin salto de directorios';

  @override
  String get importCheckManifest => 'El manifiesto es válido';

  @override
  String get importCheckChecksum => 'El SHA-256 coincide';

  @override
  String get importCheckQuizRules => 'Las preguntas cumplen las reglas';

  @override
  String importChanges(int added, int updated, int removed) {
    return '$added nuevas · $updated modificadas · $removed eliminadas';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count preguntas usan un tipo que esta versión no puede mostrar y se omiten.',
      one:
          '1 pregunta usa un tipo que esta versión no puede mostrar y se omite.',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos multimedia aún no se muestran.',
      one: '1 archivo multimedia aún no se muestra.',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => 'Tu progreso se conserva.';

  @override
  String get importProgressKeptBody =>
      'Instalar solo añade o actualiza contenido en este dispositivo; tu historial de repasos se queda como está.';

  @override
  String get importInstallAction => 'Instalar';

  @override
  String get importUpdateAction => 'Actualizar';

  @override
  String importInstalled(String title) {
    return '«$title» instalado';
  }

  @override
  String importUpdated(String title) {
    return '«$title» actualizado';
  }

  @override
  String importInstallFailed(String error) {
    return 'No se pudo instalar: $error';
  }

  @override
  String get importFailedTitle => 'Este archivo no se puede importar';

  @override
  String get deckManageCards => 'Gestionar tarjetas';

  @override
  String get deckModeMixed => 'Mixto';

  @override
  String get deckModeQuizzes => 'Solo preguntas';

  @override
  String get deckModeFlashcards => 'Solo tarjetas';

  @override
  String get deckModeExam => 'Examen';

  @override
  String get deckModeMixedDetail =>
      'Tarjetas nuevas y pendientes, de todos los tipos.';

  @override
  String get deckModeQuizzesDetail => 'Solo preguntas. Sin tarjetas.';

  @override
  String get deckModeFlashcardsDetail => 'Solo tarjetas.';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'Todos los tipos. Entre 100 y $count preguntas, elegidas al empezar.';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'Todos los tipos. $count preguntas.';
  }

  @override
  String get deckExamStart => 'Empezar examen';
}
