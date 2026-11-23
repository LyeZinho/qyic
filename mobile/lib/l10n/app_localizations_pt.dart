// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => 'Voltar';

  @override
  String get actionBackHome => 'Voltar ao início';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionClose => 'Fechar';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionCreate => 'Criar';

  @override
  String get actionDelete => 'Excluir';

  @override
  String get actionDone => 'Concluir';

  @override
  String get actionEdit => 'Editar';

  @override
  String get actionRemove => 'Remover';

  @override
  String get actionSave => 'Salvar';

  @override
  String errorGeneric(String error) {
    return 'Algo deu errado.\n$error';
  }

  @override
  String get navHome => 'Início';

  @override
  String get navLibrary => 'Biblioteca';

  @override
  String get navMe => 'Eu';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cartões',
      one: '1 cartão',
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
    return 'Nv $level';
  }

  @override
  String levelProgress(int level, int xp, int total) {
    return 'Nível $level · $xp / $total XP';
  }

  @override
  String levelUnlocked(int level) {
    return 'Nível $level desbloqueado';
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
  String get quizTypeMultipleChoice => 'Múltipla escolha';

  @override
  String get quizTypeFillInTheBlank => 'Preencher a lacuna';

  @override
  String get quizTypeMatching => 'Associação';

  @override
  String get quizTypeTrueFalse => 'Verdadeiro / Falso';

  @override
  String get quizTypeFlashcard => 'Flashcard';

  @override
  String get ratingAgain => 'De novo';

  @override
  String get ratingHard => 'Difícil';

  @override
  String get ratingGood => 'Bom';

  @override
  String get ratingEasy => 'Fácil';

  @override
  String get ratingQuestion => 'Quão bem você lembrou?';

  @override
  String ratingReviewAgainIn(String interval) {
    return 'Revisar de novo em $interval';
  }

  @override
  String get greetingMorning => 'Bom dia';

  @override
  String get greetingAfternoon => 'Boa tarde';

  @override
  String get greetingEvening => 'Boa noite';

  @override
  String get homeReady => 'Pronto para estudar?';

  @override
  String get homeSavedOnDevice => 'Salvo no dispositivo';

  @override
  String get homeTodaysQueue => 'Fila de hoje';

  @override
  String get homeAllCaughtUp => 'Tudo em dia';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks baralhos',
      one: '1 baralho',
    );
    return 'Cerca de $minutes min · $_temp0';
  }

  @override
  String get homeStartReview => 'Começar revisão';

  @override
  String get homeExamTeaser =>
      'Prática cronometrada e focada que conta para o seu cronograma';

  @override
  String get homeYourDecks => 'Seus baralhos';

  @override
  String get librarySearch => 'Pesquisar seus baralhos';

  @override
  String get libraryFilterAll => 'Todos';

  @override
  String get libraryFilterDue => 'Para estudar';

  @override
  String get libraryEmpty =>
      'Nenhum baralho ainda. Crie um ou importe um arquivo .qdeck.';

  @override
  String get libraryNoMatch => 'Nenhum baralho encontrado.';

  @override
  String get deckNew => 'Novo baralho';

  @override
  String get deckEdit => 'Editar baralho';

  @override
  String get deckFieldTitle => 'Título';

  @override
  String get deckFieldDescription => 'Descrição (opcional)';

  @override
  String deckDueCount(int count) {
    return '$count pendentes';
  }

  @override
  String deckNewCount(int count) {
    return '$count novos';
  }

  @override
  String get deckDone => 'Em dia';

  @override
  String deckBy(String author) {
    return 'por $author';
  }

  @override
  String get deckGone => 'Este baralho não existe mais.';

  @override
  String deckDeleteTitle(String title) {
    return 'Excluir “$title”?';
  }

  @override
  String get deckDeleteBody =>
      'O baralho e seus quizzes serão removidos deste dispositivo. Seu histórico de revisões é mantido.';

  @override
  String get deckMetricDue => 'Pendentes';

  @override
  String get deckMetricRetention => 'Retenção';

  @override
  String get deckMetricMature => 'Maduros';

  @override
  String get deckQuizTypes => 'Tipos de quiz';

  @override
  String get deckQuizzes => 'Quizzes';

  @override
  String get deckAddQuiz => 'Adicionar quiz';

  @override
  String get deckNoQuizzes => 'Nenhum quiz ainda. Adicione o primeiro.';

  @override
  String get deckSyncNote =>
      'Seu progresso neste baralho é sincronizado como eventos de revisão. O baralho em si nunca é reenviado.';

  @override
  String get deckStudy => 'Estudar';

  @override
  String get deckNothingToStudy => 'Nada para estudar agora';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Estudar $count cartões',
      one: 'Estudar 1 cartão',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => 'Excluir este quiz?';

  @override
  String get quizDeleteTooltip => 'Excluir quiz';

  @override
  String get quizEditorNew => 'Novo quiz';

  @override
  String get quizEditorEdit => 'Editar quiz';

  @override
  String get quizEditorType => 'Tipo';

  @override
  String get quizEditorQuestion => 'Pergunta';

  @override
  String get quizEditorStatement => 'Afirmação';

  @override
  String get quizEditorFront => 'Frente';

  @override
  String get quizEditorSentence => 'Frase — marque a lacuna com ___';

  @override
  String get quizEditorSentenceHint =>
      'Um .qdeck guarda quizzes serializados com ___ dentro de um ZIP.';

  @override
  String get quizEditorInstructions => 'Instruções';

  @override
  String get quizEditorInstructionsHint => 'Associe cada termo à sua definição';

  @override
  String get quizEditorHint => 'Contexto (opcional)';

  @override
  String get quizEditorHintHint =>
      'Exibido abaixo da pergunta, por exemplo, uma tradução';

  @override
  String get quizEditorBack => 'Verso';

  @override
  String get quizEditorExplanation => 'Explicação (exibida após responder)';

  @override
  String get quizEditorOptions => 'Opções — selecione a correta';

  @override
  String quizEditorOptionN(int number) {
    return 'Opção $number';
  }

  @override
  String get quizEditorAddOption => 'Adicionar opção';

  @override
  String get quizEditorStatementIs => 'A afirmação é';

  @override
  String get quizEditorAccepted => 'Respostas aceitas';

  @override
  String quizEditorAnswerN(int number) {
    return 'Resposta $number';
  }

  @override
  String get quizEditorAddAnswer => 'Adicionar resposta aceita';

  @override
  String get quizEditorPairs => 'Pares';

  @override
  String get quizEditorTerm => 'Termo';

  @override
  String get quizEditorMatch => 'Correspondência';

  @override
  String get quizEditorAddPair => 'Adicionar par';

  @override
  String get quizEditorSave => 'Salvar quiz';

  @override
  String get issueEmptyQuestion => 'A pergunta não pode ficar vazia.';

  @override
  String get issueEmptyFront => 'A frente não pode ficar vazia.';

  @override
  String get issueDuplicateOptionIds => 'Os IDs das opções devem ser únicos.';

  @override
  String get issueTooFewOptions => 'Adicione pelo menos duas opções.';

  @override
  String get issueEmptyOptions => 'As opções não podem ficar vazias.';

  @override
  String get issueDuplicateOptions => 'As opções devem ser diferentes.';

  @override
  String get issueNotOneCorrect => 'Marque exatamente uma opção correta.';

  @override
  String get issueTrueFalseOptions =>
      'Verdadeiro/falso precisa das opções “true” e “false”.';

  @override
  String get issueTrueFalseNoAnswer => 'Escolha se a afirmação é verdadeira.';

  @override
  String get issueEmptyBack => 'O verso não pode ficar vazio.';

  @override
  String get issueFlashcardOptions => 'Flashcards não têm opções.';

  @override
  String get issueNotOneBlank =>
      'Marque exatamente uma lacuna com ___ na frase.';

  @override
  String get issueNoAnswers => 'Adicione pelo menos uma resposta aceita.';

  @override
  String get issueEmptyAnswers =>
      'As respostas aceitas não podem ficar vazias.';

  @override
  String get issueAnswerNotCorrect =>
      'Toda resposta aceita deve ser marcada como correta.';

  @override
  String get issueTooFewPairs => 'Adicione pelo menos dois pares.';

  @override
  String get issueEmptyPairSide =>
      'Os dois lados de cada par devem ser preenchidos.';

  @override
  String get issueDuplicatePairs =>
      'Termos e correspondências devem ser diferentes.';

  @override
  String get studyEnd => 'Encerrar sessão';

  @override
  String studySaveFailed(String error) {
    return 'Não foi possível salvar a revisão: $error';
  }

  @override
  String get studyAllCaughtUp => 'TUDO EM DIA';

  @override
  String get studyNothingDue => 'Nada pendente no momento.';

  @override
  String get studyNothingDueBody =>
      'Volte mais tarde, adicione quizzes a um baralho ou experimente o modo prova.';

  @override
  String get feedbackCorrect => 'Correto.';

  @override
  String get feedbackWrong => 'Quase.';

  @override
  String choiceAnswer(String answer) {
    return 'Resposta: $answer.';
  }

  @override
  String get trueFalseTrue => 'Verdadeiro';

  @override
  String get trueFalseFalse => 'Falso';

  @override
  String get trueFalseExplainAfter => 'Responda para ver a explicação';

  @override
  String get fillPrompt => 'Complete a frase';

  @override
  String get fillTypeAnswer => 'Digite a resposta';

  @override
  String fillAccepted(String answers) {
    return 'Aceitas: $answers.';
  }

  @override
  String fillLetterHint(String letter) {
    return 'Dica: começa com “$letter”';
  }

  @override
  String get fillShowHint => 'Mostrar dica';

  @override
  String get fillCheck => 'Verificar resposta';

  @override
  String get flashcardBack => 'Verso';

  @override
  String get flashcardRecall => 'Lembre a resposta e toque para revelar.';

  @override
  String get flashcardShowAnswer => 'Mostrar resposta';

  @override
  String get matchingAllSet =>
      'Todos os pares definidos. Toque em um bloco para alterá-lo.';

  @override
  String matchingInstructions(int remaining, int total) {
    return 'Toque em um termo e depois na correspondência. Faltam $remaining de $total pares.';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return 'Pares corretos: $pairs.';
  }

  @override
  String get matchingCheck => 'Verificar pares';

  @override
  String get sessionComplete => 'SESSÃO CONCLUÍDA';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cartões.',
      one: '1 cartão.',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => 'Mandou bem.';

  @override
  String get sessionKeepGoing => 'Continue assim.';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos de revisão salvos no dispositivo',
      one: '1 evento de revisão salvo no dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => 'Precisão';

  @override
  String get statXpEarned => 'XP ganho';

  @override
  String get statDayStreak => 'Dias seguidos';

  @override
  String get statTime => 'Tempo';

  @override
  String get examTitle => 'Modo prova';

  @override
  String get examIntro =>
      'Prática intensa e cronometrada. Os cartões são escolhidos mesmo quando não estão pendentes, e cada resposta é uma revisão real que atualiza seu cronograma.';

  @override
  String get examQuickName => 'Prova rápida';

  @override
  String get examStart => 'Iniciar prova';

  @override
  String get examPresets => 'Predefinições';

  @override
  String get examNewPreset => 'Nova predefinição';

  @override
  String get examEditPreset => 'Editar predefinição';

  @override
  String get examNoPresets =>
      'Nenhuma predefinição ainda. Salve as configurações que você usa com frequência.';

  @override
  String get examRecent => 'Resultados recentes';

  @override
  String get examNoRuns => 'Nenhuma prova feita ainda.';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perguntas',
      one: '1 pergunta',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return '$seconds s cada';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baralhos',
      one: '1 baralho',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$correct de $total corretas';
  }

  @override
  String get examUntimed => 'Sem tempo';

  @override
  String get examSelectionWeakest => 'Mais fracos primeiro';

  @override
  String get examSelectionWeakestDetail =>
      'Cartões que você tem mais chance de esquecer, pela lembrança prevista.';

  @override
  String get examSelectionRandom => 'Aleatório';

  @override
  String get examSelectionRandomDetail =>
      'Uma mistura embaralhada de tudo o que está incluído.';

  @override
  String get examSelectionDueFirst => 'Pendentes primeiro';

  @override
  String get examSelectionDueFirstDetail =>
      'Cartões atrasados e, em seguida, os próximos a vencer.';

  @override
  String get examEndCompleted => 'Concluída';

  @override
  String get examEndTimeUp => 'Tempo esgotado';

  @override
  String get examEndStopped => 'Interrompida';

  @override
  String get examFieldName => 'Nome';

  @override
  String get examFieldDecks => 'Baralhos';

  @override
  String get examAllDecks => 'Todos os baralhos';

  @override
  String get examFieldSelection => 'Seleção de cartões';

  @override
  String get examFieldQuestions => 'Perguntas';

  @override
  String get examFieldTimeLimit => 'Tempo limite';

  @override
  String get examFieldTimePerQuestion => 'Tempo por pergunta';

  @override
  String get examFieldQuizTypes => 'Tipos de quiz';

  @override
  String get examFieldIncludeNew => 'Incluir cartões novos';

  @override
  String get examFieldIncludeNewDetail =>
      'Também perguntar cartões que você nunca estudou.';

  @override
  String get examFieldAutoRate => 'Avaliar automaticamente';

  @override
  String get examFieldAutoRateDetail =>
      'Errado vira De novo, certo e rápido vira Bom, certo e lento vira Difícil. Nos flashcards, você mesmo avalia.';

  @override
  String get examFieldAllowHints => 'Permitir dicas';

  @override
  String get examFieldAllowHintsDetail =>
      'Oferecer a dica da primeira letra nos quizzes de preencher a lacuna.';

  @override
  String get examAffectsSchedule =>
      'As respostas da prova são revisões reais: elas movem os cartões no seu cronograma e dão XP.';

  @override
  String get examIssueEmptyName => 'Dê um nome à predefinição.';

  @override
  String get examIssueNoQuizTypes => 'Escolha pelo menos um tipo de quiz.';

  @override
  String examIssueQuestionCount(int min, int max) {
    return 'Escolha entre $min e $max perguntas.';
  }

  @override
  String get examDeleteTitle => 'Excluir predefinição?';

  @override
  String examDeleteBody(String name) {
    return '“$name” será removida. Os resultados anteriores são mantidos.';
  }

  @override
  String get examPill => 'PROVA';

  @override
  String get examStop => 'Parar prova';

  @override
  String get examStopTitle => 'Parar a prova?';

  @override
  String get examStopBody =>
      'As respostas dadas até agora são mantidas e já contam para o seu cronograma.';

  @override
  String get examKeepGoing => 'Continuar';

  @override
  String get examQuestionTimeUp => 'Tempo esgotado.';

  @override
  String get examTimeUpBanner =>
      'O tempo da prova acabou. Esta foi a última pergunta.';

  @override
  String examRatedAs(String rating) {
    return 'Avaliado como $rating';
  }

  @override
  String get examNextQuestion => 'Próxima pergunta';

  @override
  String get examSeeResults => 'Ver resultados';

  @override
  String get examAnswered => 'Respondidas';

  @override
  String get examUnanswered => 'Não respondidas';

  @override
  String examMissed(int count) {
    return 'Para revisar ($count)';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count revisões salvas no dispositivo.',
      one: '1 revisão salva no dispositivo.',
      zero: 'Nenhuma revisão foi registrada.',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'Refazer';

  @override
  String get examNoCards => 'Nenhum cartão para perguntar.';

  @override
  String get examNoCardsBody =>
      'Não há cartões nestes baralhos com os tipos de quiz selecionados.';

  @override
  String get examNoCardsBodyNew =>
      'Só são perguntados cartões já estudados. Estude alguns cartões primeiro ou ative “Incluir cartões novos” em uma predefinição.';

  @override
  String get remindersTitle => 'Lembretes';

  @override
  String get remindersIntro =>
      'Receba um lembrete para estudar nos horários que forem melhores para você. Os lembretes valem apenas neste dispositivo.';

  @override
  String get remindersAdd => 'Adicionar lembrete';

  @override
  String get remindersEmpty => 'Nenhum lembrete ainda.';

  @override
  String get remindersNoDays =>
      'Escolha pelo menos um dia, senão este lembrete nunca dispara.';

  @override
  String get remindersOff => 'Desativado';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ativos',
      one: '1 ativo',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'Esta plataforma não consegue agendar notificações. Seus lembretes ficam salvos e valem no seu celular.';

  @override
  String get remindersPermissionDenied =>
      'As notificações estão desativadas para o Qyic. Permita-as nas configurações do sistema para receber lembretes.';

  @override
  String get reminderTitle => 'Hora de estudar';

  @override
  String get reminderBody =>
      'Alguns minutos agora mantêm sua sequência e sua memória em dia.';

  @override
  String get reminderChannel => 'Lembretes de estudo';

  @override
  String get prefTitle => 'Preferências';

  @override
  String get prefSectionGeneral => 'Geral';

  @override
  String get prefSectionStudy => 'Estudo';

  @override
  String get prefSectionNotifications => 'Notificações';

  @override
  String get prefSectionData => 'Dados';

  @override
  String get prefSectionAbout => 'Sobre';

  @override
  String get prefLanguage => 'Idioma';

  @override
  String get prefSystem => 'Padrão do sistema';

  @override
  String get prefName => 'Seu nome';

  @override
  String get prefDailyGoal => 'Meta diária';

  @override
  String get prefDailyGoalDetail => 'Revisões por dia para cumprir sua meta.';

  @override
  String get prefNewCards => 'Cartões novos por dia';

  @override
  String get prefNewCardsDetail =>
      'Cartões nunca vistos apresentados a cada dia, em todos os baralhos.';

  @override
  String get prefRetention => 'Retenção desejada';

  @override
  String get prefRetentionDetail =>
      'Retenção maior significa revisões mais frequentes. Vale para as próximas revisões.';

  @override
  String get prefIntervals => 'Mostrar próximos intervalos';

  @override
  String get prefIntervalsDetail =>
      'Mostrar nos botões de avaliação quando você verá o cartão de novo.';

  @override
  String get prefHaptics => 'Resposta tátil';

  @override
  String get prefHapticsDetail => 'Vibrar ao responder e avaliar.';

  @override
  String get prefStorage => 'Armazenamento usado';

  @override
  String get prefLicenses => 'Licenças de código aberto';

  @override
  String get meDefaultName => 'Estudante';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'sequência de $streak dias',
      one: 'sequência de 1 dia',
    );
    return 'Nível $level · $_temp0';
  }

  @override
  String get meSyncOff => 'Sincronização não configurada';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos no dispositivo',
      one: '1 evento no dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      'As revisões são salvas primeiro neste dispositivo. Quando o login e a sincronização estiverem disponíveis, os eventos de revisão na fila serão enviados; os baralhos nunca são reenviados.';

  @override
  String get meSettings => 'Configurações';

  @override
  String get meMore => 'Mais';

  @override
  String get meSyncUnavailable => 'Sincronizar agora · ainda não disponível';

  @override
  String get importAction => 'Importar .qdeck';

  @override
  String get importTitle => 'Importar .qdeck';

  @override
  String get importChecking => 'Verificando o arquivo…';

  @override
  String get importNewBadge => 'Novo baralho';

  @override
  String importUpdateBadge(int from, int to) {
    return 'Atualização v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return 'spec v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'baralho v$version';
  }

  @override
  String get importCheckArchive => 'Caminhos do arquivo são seguros';

  @override
  String get importCheckArchiveDetail => 'sem path traversal';

  @override
  String get importCheckManifest => 'Manifesto válido';

  @override
  String get importCheckChecksum => 'SHA-256 confere';

  @override
  String get importCheckQuizRules => 'Quizzes seguem as regras';

  @override
  String importChanges(int added, int updated, int removed) {
    return '$added novos · $updated alterados · $removed removidos';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count quizzes usam um tipo que esta versão não consegue exibir e serão ignorados.',
      one:
          '1 quiz usa um tipo que esta versão não consegue exibir e será ignorado.',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos de mídia ainda não são exibidos.',
      one: '1 arquivo de mídia ainda não é exibido.',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => 'Seu progresso é mantido.';

  @override
  String get importProgressKeptBody =>
      'A instalação só adiciona ou atualiza conteúdo neste dispositivo; seu histórico de revisões continua como está.';

  @override
  String get importInstallAction => 'Instalar';

  @override
  String get importUpdateAction => 'Atualizar';

  @override
  String importInstalled(String title) {
    return '“$title” instalado';
  }

  @override
  String importUpdated(String title) {
    return '“$title” atualizado';
  }

  @override
  String importInstallFailed(String error) {
    return 'Não foi possível instalar: $error';
  }

  @override
  String get importFailedTitle => 'Este arquivo não pode ser importado';

  @override
  String get deckManageCards => 'Gerenciar cartões';

  @override
  String get deckModeMixed => 'Misto';

  @override
  String get deckModeQuizzes => 'Só perguntas';

  @override
  String get deckModeFlashcards => 'Só cartões';

  @override
  String get deckModeExam => 'Prova';

  @override
  String get deckModeMixedDetail =>
      'Cartas novas e pendentes, de todos os tipos.';

  @override
  String get deckModeQuizzesDetail => 'Só perguntas. Sem flashcards.';

  @override
  String get deckModeFlashcardsDetail => 'Só flashcards.';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'Todos os tipos. Entre 100 e $count perguntas, sorteadas ao começar.';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'Todos os tipos. $count perguntas.';
  }

  @override
  String get deckExamStart => 'Começar prova';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => 'Voltar';

  @override
  String get actionBackHome => 'Voltar ao início';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionClose => 'Fechar';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionCreate => 'Criar';

  @override
  String get actionDelete => 'Eliminar';

  @override
  String get actionDone => 'Concluir';

  @override
  String get actionEdit => 'Editar';

  @override
  String get actionRemove => 'Remover';

  @override
  String get actionSave => 'Guardar';

  @override
  String errorGeneric(String error) {
    return 'Ocorreu um erro.\n$error';
  }

  @override
  String get navHome => 'Início';

  @override
  String get navLibrary => 'Biblioteca';

  @override
  String get navMe => 'Eu';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cartões',
      one: '1 cartão',
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
    return 'Nv $level';
  }

  @override
  String levelProgress(int level, int xp, int total) {
    return 'Nível $level · $xp / $total XP';
  }

  @override
  String levelUnlocked(int level) {
    return 'Nível $level desbloqueado';
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
  String get quizTypeMultipleChoice => 'Escolha múltipla';

  @override
  String get quizTypeFillInTheBlank => 'Preencher o espaço';

  @override
  String get quizTypeMatching => 'Correspondência';

  @override
  String get quizTypeTrueFalse => 'Verdadeiro / Falso';

  @override
  String get quizTypeFlashcard => 'Cartão de memória';

  @override
  String get ratingAgain => 'Outra vez';

  @override
  String get ratingHard => 'Difícil';

  @override
  String get ratingGood => 'Bom';

  @override
  String get ratingEasy => 'Fácil';

  @override
  String get ratingQuestion => 'Quão bem te lembraste?';

  @override
  String ratingReviewAgainIn(String interval) {
    return 'Rever outra vez daqui a $interval';
  }

  @override
  String get greetingMorning => 'Bom dia';

  @override
  String get greetingAfternoon => 'Boa tarde';

  @override
  String get greetingEvening => 'Boa noite';

  @override
  String get homeReady => 'Pronto para estudar?';

  @override
  String get homeSavedOnDevice => 'Guardado no dispositivo';

  @override
  String get homeTodaysQueue => 'Fila de hoje';

  @override
  String get homeAllCaughtUp => 'Tudo em dia';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks baralhos',
      one: '1 baralho',
    );
    return 'Cerca de $minutes min · $_temp0';
  }

  @override
  String get homeStartReview => 'Começar revisão';

  @override
  String get homeExamTeaser =>
      'Prática cronometrada e focada que conta para o teu plano de estudo';

  @override
  String get homeYourDecks => 'Os teus baralhos';

  @override
  String get librarySearch => 'Pesquisar nos teus baralhos';

  @override
  String get libraryFilterAll => 'Todos';

  @override
  String get libraryFilterDue => 'Para estudar';

  @override
  String get libraryEmpty =>
      'Ainda não há baralhos. Cria um ou importa um ficheiro .qdeck.';

  @override
  String get libraryNoMatch => 'Nenhum baralho corresponde.';

  @override
  String get deckNew => 'Novo baralho';

  @override
  String get deckEdit => 'Editar baralho';

  @override
  String get deckFieldTitle => 'Título';

  @override
  String get deckFieldDescription => 'Descrição (opcional)';

  @override
  String deckDueCount(int count) {
    return '$count pendentes';
  }

  @override
  String deckNewCount(int count) {
    return '$count novos';
  }

  @override
  String get deckDone => 'Em dia';

  @override
  String deckBy(String author) {
    return 'de $author';
  }

  @override
  String get deckGone => 'Este baralho já não existe.';

  @override
  String deckDeleteTitle(String title) {
    return 'Eliminar “$title”?';
  }

  @override
  String get deckDeleteBody =>
      'O baralho e os respetivos quizzes são removidos deste dispositivo. O teu histórico de revisões é mantido.';

  @override
  String get deckMetricDue => 'Pendentes';

  @override
  String get deckMetricRetention => 'Retenção';

  @override
  String get deckMetricMature => 'Maduros';

  @override
  String get deckQuizTypes => 'Tipos de quiz';

  @override
  String get deckQuizzes => 'Quizzes';

  @override
  String get deckAddQuiz => 'Adicionar quiz';

  @override
  String get deckNoQuizzes => 'Ainda não há quizzes. Adiciona o primeiro.';

  @override
  String get deckSyncNote =>
      'O teu progresso neste baralho é sincronizado como eventos de revisão. O baralho em si nunca é carregado de novo.';

  @override
  String get deckStudy => 'Estudar';

  @override
  String get deckNothingToStudy => 'Nada para estudar agora';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Estudar $count cartões',
      one: 'Estudar 1 cartão',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => 'Eliminar este quiz?';

  @override
  String get quizDeleteTooltip => 'Eliminar quiz';

  @override
  String get quizEditorNew => 'Novo quiz';

  @override
  String get quizEditorEdit => 'Editar quiz';

  @override
  String get quizEditorType => 'Tipo';

  @override
  String get quizEditorQuestion => 'Pergunta';

  @override
  String get quizEditorStatement => 'Afirmação';

  @override
  String get quizEditorFront => 'Frente';

  @override
  String get quizEditorSentence => 'Frase — marca o espaço com ___';

  @override
  String get quizEditorSentenceHint =>
      'Um .qdeck guarda os quizzes serializados com ___ dentro de um ZIP.';

  @override
  String get quizEditorInstructions => 'Instruções';

  @override
  String get quizEditorInstructionsHint =>
      'Faz corresponder cada termo à sua definição';

  @override
  String get quizEditorHint => 'Contexto (opcional)';

  @override
  String get quizEditorHintHint =>
      'Mostrado por baixo da pergunta, p. ex. uma tradução';

  @override
  String get quizEditorBack => 'Verso';

  @override
  String get quizEditorExplanation =>
      'Explicação (mostrada depois de responder)';

  @override
  String get quizEditorOptions => 'Opções — seleciona a correta';

  @override
  String quizEditorOptionN(int number) {
    return 'Opção $number';
  }

  @override
  String get quizEditorAddOption => 'Adicionar opção';

  @override
  String get quizEditorStatementIs => 'A afirmação é';

  @override
  String get quizEditorAccepted => 'Respostas aceites';

  @override
  String quizEditorAnswerN(int number) {
    return 'Resposta $number';
  }

  @override
  String get quizEditorAddAnswer => 'Adicionar resposta aceite';

  @override
  String get quizEditorPairs => 'Pares';

  @override
  String get quizEditorTerm => 'Termo';

  @override
  String get quizEditorMatch => 'Correspondência';

  @override
  String get quizEditorAddPair => 'Adicionar par';

  @override
  String get quizEditorSave => 'Guardar quiz';

  @override
  String get issueEmptyQuestion => 'A pergunta não pode estar vazia.';

  @override
  String get issueEmptyFront => 'A frente não pode estar vazia.';

  @override
  String get issueDuplicateOptionIds => 'Os IDs das opções têm de ser únicos.';

  @override
  String get issueTooFewOptions => 'Adiciona pelo menos duas opções.';

  @override
  String get issueEmptyOptions => 'As opções não podem estar vazias.';

  @override
  String get issueDuplicateOptions => 'As opções têm de ser diferentes.';

  @override
  String get issueNotOneCorrect => 'Marca exatamente uma opção correta.';

  @override
  String get issueTrueFalseOptions =>
      'Verdadeiro/falso precisa das opções “true” e “false”.';

  @override
  String get issueTrueFalseNoAnswer => 'Escolhe se a afirmação é verdadeira.';

  @override
  String get issueEmptyBack => 'O verso não pode estar vazio.';

  @override
  String get issueFlashcardOptions => 'Os cartões de memória não têm opções.';

  @override
  String get issueNotOneBlank => 'Marca exatamente um espaço com ___ na frase.';

  @override
  String get issueNoAnswers => 'Adiciona pelo menos uma resposta aceite.';

  @override
  String get issueEmptyAnswers =>
      'As respostas aceites não podem estar vazias.';

  @override
  String get issueAnswerNotCorrect =>
      'Todas as respostas aceites têm de estar marcadas como corretas.';

  @override
  String get issueTooFewPairs => 'Adiciona pelo menos dois pares.';

  @override
  String get issueEmptyPairSide =>
      'Os dois lados de cada par têm de estar preenchidos.';

  @override
  String get issueDuplicatePairs =>
      'Os termos e as correspondências têm de ser diferentes.';

  @override
  String get studyEnd => 'Terminar sessão';

  @override
  String studySaveFailed(String error) {
    return 'Não foi possível guardar a revisão: $error';
  }

  @override
  String get studyAllCaughtUp => 'TUDO EM DIA';

  @override
  String get studyNothingDue => 'De momento, não há nada pendente.';

  @override
  String get studyNothingDueBody =>
      'Volta mais tarde, adiciona quizzes a um baralho ou experimenta o modo exame.';

  @override
  String get feedbackCorrect => 'Correto.';

  @override
  String get feedbackWrong => 'Quase.';

  @override
  String choiceAnswer(String answer) {
    return 'Resposta: $answer.';
  }

  @override
  String get trueFalseTrue => 'Verdadeiro';

  @override
  String get trueFalseFalse => 'Falso';

  @override
  String get trueFalseExplainAfter => 'Responde para veres a explicação';

  @override
  String get fillPrompt => 'Completa a frase';

  @override
  String get fillTypeAnswer => 'Escreve a resposta';

  @override
  String fillAccepted(String answers) {
    return 'Aceites: $answers.';
  }

  @override
  String fillLetterHint(String letter) {
    return 'Dica: começa por “$letter”';
  }

  @override
  String get fillShowHint => 'Mostrar dica';

  @override
  String get fillCheck => 'Verificar resposta';

  @override
  String get flashcardBack => 'Verso';

  @override
  String get flashcardRecall => 'Lembra-te da resposta e toca para a revelar.';

  @override
  String get flashcardShowAnswer => 'Mostrar resposta';

  @override
  String get matchingAllSet =>
      'Todos os pares definidos. Toca num bloco para o alterar.';

  @override
  String matchingInstructions(int remaining, int total) {
    return 'Toca num termo e depois na sua correspondência. Faltam $remaining de $total pares.';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return 'Pares corretos: $pairs.';
  }

  @override
  String get matchingCheck => 'Verificar pares';

  @override
  String get sessionComplete => 'SESSÃO CONCLUÍDA';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cartões.',
      one: '1 cartão.',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => 'Muito bem.';

  @override
  String get sessionKeepGoing => 'Continua assim.';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos de revisão guardados no dispositivo',
      one: '1 evento de revisão guardado no dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => 'Precisão';

  @override
  String get statXpEarned => 'XP ganho';

  @override
  String get statDayStreak => 'Dias seguidos';

  @override
  String get statTime => 'Tempo';

  @override
  String get examTitle => 'Modo exame';

  @override
  String get examIntro =>
      'Prática intensa e cronometrada. Os cartões são escolhidos mesmo quando não estão pendentes, e cada resposta é uma revisão real que atualiza o teu plano de estudo.';

  @override
  String get examQuickName => 'Exame rápido';

  @override
  String get examStart => 'Iniciar exame';

  @override
  String get examPresets => 'Predefinições';

  @override
  String get examNewPreset => 'Nova predefinição';

  @override
  String get examEditPreset => 'Editar predefinição';

  @override
  String get examNoPresets =>
      'Ainda não há predefinições. Guarda as configurações que usas com frequência.';

  @override
  String get examRecent => 'Resultados recentes';

  @override
  String get examNoRuns => 'Ainda não fizeste nenhum exame.';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perguntas',
      one: '1 pergunta',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return '$seconds s cada';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baralhos',
      one: '1 baralho',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$correct de $total corretas';
  }

  @override
  String get examUntimed => 'Sem limite de tempo';

  @override
  String get examSelectionWeakest => 'Mais fracos primeiro';

  @override
  String get examSelectionWeakestDetail =>
      'Os cartões que tens mais probabilidade de esquecer, segundo a memorização prevista.';

  @override
  String get examSelectionRandom => 'Aleatório';

  @override
  String get examSelectionRandomDetail =>
      'Uma mistura baralhada de tudo o que está incluído.';

  @override
  String get examSelectionDueFirst => 'Pendentes primeiro';

  @override
  String get examSelectionDueFirstDetail =>
      'Cartões em atraso e, a seguir, os próximos a vencer.';

  @override
  String get examEndCompleted => 'Concluído';

  @override
  String get examEndTimeUp => 'Tempo esgotado';

  @override
  String get examEndStopped => 'Interrompido';

  @override
  String get examFieldName => 'Nome';

  @override
  String get examFieldDecks => 'Baralhos';

  @override
  String get examAllDecks => 'Todos os baralhos';

  @override
  String get examFieldSelection => 'Seleção de cartões';

  @override
  String get examFieldQuestions => 'Perguntas';

  @override
  String get examFieldTimeLimit => 'Limite de tempo';

  @override
  String get examFieldTimePerQuestion => 'Tempo por pergunta';

  @override
  String get examFieldQuizTypes => 'Tipos de quiz';

  @override
  String get examFieldIncludeNew => 'Incluir cartões novos';

  @override
  String get examFieldIncludeNewDetail =>
      'Perguntar também cartões que nunca estudaste.';

  @override
  String get examFieldAutoRate => 'Avaliar automaticamente';

  @override
  String get examFieldAutoRateDetail =>
      'Errado conta como Outra vez, certo e rápido como Bom, certo e lento como Difícil. Nos cartões de memória continuas a escolher tu.';

  @override
  String get examFieldAllowHints => 'Permitir dicas';

  @override
  String get examFieldAllowHintsDetail =>
      'Oferecer a dica da primeira letra nos quizzes de preencher o espaço.';

  @override
  String get examAffectsSchedule =>
      'As respostas do exame são revisões reais: movem os cartões no teu plano de estudo e dão XP.';

  @override
  String get examIssueEmptyName => 'Dá um nome à predefinição.';

  @override
  String get examIssueNoQuizTypes => 'Escolhe pelo menos um tipo de quiz.';

  @override
  String examIssueQuestionCount(int min, int max) {
    return 'Escolhe entre $min e $max perguntas.';
  }

  @override
  String get examDeleteTitle => 'Eliminar predefinição?';

  @override
  String examDeleteBody(String name) {
    return '“$name” vai ser removida. Os resultados anteriores são mantidos.';
  }

  @override
  String get examPill => 'EXAME';

  @override
  String get examStop => 'Parar exame';

  @override
  String get examStopTitle => 'Parar o exame?';

  @override
  String get examStopBody =>
      'As respostas dadas até agora são mantidas e já contam para o teu plano de estudo.';

  @override
  String get examKeepGoing => 'Continuar';

  @override
  String get examQuestionTimeUp => 'Tempo esgotado.';

  @override
  String get examTimeUpBanner =>
      'O tempo do exame terminou. Esta foi a última pergunta.';

  @override
  String examRatedAs(String rating) {
    return 'Avaliado como $rating';
  }

  @override
  String get examNextQuestion => 'Pergunta seguinte';

  @override
  String get examSeeResults => 'Ver resultados';

  @override
  String get examAnswered => 'Respondidas';

  @override
  String get examUnanswered => 'Por responder';

  @override
  String examMissed(int count) {
    return 'Para rever ($count)';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count revisões guardadas no dispositivo.',
      one: '1 revisão guardada no dispositivo.',
      zero: 'Não foi registada nenhuma revisão.',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'Repetir';

  @override
  String get examNoCards => 'Não há cartões para perguntar.';

  @override
  String get examNoCardsBody =>
      'Não há cartões nestes baralhos com os tipos de quiz selecionados.';

  @override
  String get examNoCardsBodyNew =>
      'Só são perguntados cartões já estudados. Estuda alguns cartões primeiro ou ativa “Incluir cartões novos” numa predefinição.';

  @override
  String get remindersTitle => 'Lembretes';

  @override
  String get remindersIntro =>
      'Recebe um lembrete para estudar às horas que te dão mais jeito. Os lembretes só são definidos neste dispositivo.';

  @override
  String get remindersAdd => 'Adicionar lembrete';

  @override
  String get remindersEmpty => 'Ainda não há lembretes.';

  @override
  String get remindersNoDays =>
      'Escolhe pelo menos um dia, caso contrário este lembrete nunca é ativado.';

  @override
  String get remindersOff => 'Desligado';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ativos',
      one: '1 ativo',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'Esta plataforma não consegue agendar notificações. Os teus lembretes ficam guardados e aplicam-se no teu telemóvel.';

  @override
  String get remindersPermissionDenied =>
      'As notificações estão desativadas para o Qyic. Permite-as nas definições do sistema para receberes lembretes.';

  @override
  String get reminderTitle => 'Hora de estudar';

  @override
  String get reminderBody =>
      'Uns minutos agora mantêm a tua série e a tua memória em forma.';

  @override
  String get reminderChannel => 'Lembretes de estudo';

  @override
  String get prefTitle => 'Preferências';

  @override
  String get prefSectionGeneral => 'Geral';

  @override
  String get prefSectionStudy => 'Estudo';

  @override
  String get prefSectionNotifications => 'Notificações';

  @override
  String get prefSectionData => 'Dados';

  @override
  String get prefSectionAbout => 'Acerca de';

  @override
  String get prefLanguage => 'Idioma';

  @override
  String get prefSystem => 'Igual ao sistema';

  @override
  String get prefName => 'O teu nome';

  @override
  String get prefDailyGoal => 'Objetivo diário';

  @override
  String get prefDailyGoalDetail =>
      'Revisões por dia para cumprires o teu objetivo.';

  @override
  String get prefNewCards => 'Cartões novos por dia';

  @override
  String get prefNewCardsDetail =>
      'Cartões nunca vistos apresentados por dia, em todos os baralhos.';

  @override
  String get prefRetention => 'Retenção pretendida';

  @override
  String get prefRetentionDetail =>
      'Uma retenção mais alta significa revisões mais frequentes. Aplica-se às próximas revisões.';

  @override
  String get prefIntervals => 'Mostrar próximos intervalos';

  @override
  String get prefIntervalsDetail =>
      'Mostrar nos botões de avaliação quando vais voltar a ver o cartão.';

  @override
  String get prefHaptics => 'Resposta tátil';

  @override
  String get prefHapticsDetail => 'Vibrar ao responder e avaliar.';

  @override
  String get prefStorage => 'Armazenamento utilizado';

  @override
  String get prefLicenses => 'Licenças de código aberto';

  @override
  String get meDefaultName => 'Estudante';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'série de $streak dias',
      one: 'série de 1 dia',
    );
    return 'Nível $level · $_temp0';
  }

  @override
  String get meSyncOff => 'Sincronização não configurada';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos no dispositivo',
      one: '1 evento no dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      'As revisões são guardadas primeiro neste dispositivo. Quando o início de sessão e a sincronização estiverem disponíveis, os eventos de revisão em fila são carregados; os baralhos nunca são carregados de novo.';

  @override
  String get meSettings => 'Definições';

  @override
  String get meMore => 'Mais';

  @override
  String get meSyncUnavailable => 'Sincronizar agora · ainda indisponível';

  @override
  String get importAction => 'Importar .qdeck';

  @override
  String get importTitle => 'Importar .qdeck';

  @override
  String get importChecking => 'A verificar o ficheiro…';

  @override
  String get importNewBadge => 'Novo baralho';

  @override
  String importUpdateBadge(int from, int to) {
    return 'Atualização v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return 'spec v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'baralho v$version';
  }

  @override
  String get importCheckArchive => 'Os caminhos do arquivo são seguros';

  @override
  String get importCheckArchiveDetail => 'sem path traversal';

  @override
  String get importCheckManifest => 'O manifesto é válido';

  @override
  String get importCheckChecksum => 'O SHA-256 corresponde';

  @override
  String get importCheckQuizRules => 'Os quizzes cumprem as regras';

  @override
  String importChanges(int added, int updated, int removed) {
    return '$added novos · $updated alterados · $removed removidos';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count quizzes usam um tipo que esta versão não consegue mostrar e são ignorados.',
      one:
          '1 quiz usa um tipo que esta versão não consegue mostrar e é ignorado.',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ficheiros multimédia ainda não são mostrados.',
      one: '1 ficheiro multimédia ainda não é mostrado.',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => 'O teu progresso é mantido.';

  @override
  String get importProgressKeptBody =>
      'A instalação só adiciona ou atualiza conteúdo neste dispositivo; o teu histórico de revisões fica como está.';

  @override
  String get importInstallAction => 'Instalar';

  @override
  String get importUpdateAction => 'Atualizar';

  @override
  String importInstalled(String title) {
    return '“$title” instalado';
  }

  @override
  String importUpdated(String title) {
    return '“$title” atualizado';
  }

  @override
  String importInstallFailed(String error) {
    return 'Não foi possível instalar: $error';
  }

  @override
  String get importFailedTitle => 'Não é possível importar este ficheiro';

  @override
  String get deckManageCards => 'Gerir cartões';

  @override
  String get deckModeMixed => 'Misto';

  @override
  String get deckModeQuizzes => 'Só perguntas';

  @override
  String get deckModeFlashcards => 'Só cartões';

  @override
  String get deckModeExam => 'Exame';

  @override
  String get deckModeMixedDetail =>
      'Cartas novas e pendentes, de todos os tipos.';

  @override
  String get deckModeQuizzesDetail => 'Só perguntas. Sem cartões de memória.';

  @override
  String get deckModeFlashcardsDetail => 'Só cartões de memória.';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'Todos os tipos. Entre 100 e $count perguntas, escolhidas ao começar.';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'Todos os tipos. $count perguntas.';
  }

  @override
  String get deckExamStart => 'Começar exame';
}
