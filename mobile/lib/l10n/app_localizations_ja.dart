// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Qyic';

  @override
  String get actionBack => '戻る';

  @override
  String get actionBackHome => 'ホームに戻る';

  @override
  String get actionCancel => 'キャンセル';

  @override
  String get actionClose => '閉じる';

  @override
  String get actionContinue => '続ける';

  @override
  String get actionCreate => '作成';

  @override
  String get actionDelete => '削除';

  @override
  String get actionDone => '完了';

  @override
  String get actionEdit => '編集';

  @override
  String get actionRemove => '削除';

  @override
  String get actionSave => '保存';

  @override
  String errorGeneric(String error) {
    return '問題が発生しました。\n$error';
  }

  @override
  String get navHome => 'ホーム';

  @override
  String get navLibrary => 'ライブラリ';

  @override
  String get navMe => 'マイページ';

  @override
  String cardCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count枚のカード',
    );
    return '$_temp0';
  }

  @override
  String quizCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count問のクイズ',
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
    return 'レベル$level · $xp / $total XP';
  }

  @override
  String levelUnlocked(int level) {
    return 'レベル$levelに到達';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes分';
  }

  @override
  String durationSeconds(int seconds) {
    return '$seconds秒';
  }

  @override
  String intervalMinutes(int count) {
    return '$count分';
  }

  @override
  String intervalHours(int count) {
    return '$count時間';
  }

  @override
  String intervalDays(int count) {
    return '$count日';
  }

  @override
  String intervalMonths(String value) {
    return '$valueか月';
  }

  @override
  String intervalYears(String value) {
    return '$value年';
  }

  @override
  String get quizTypeMultipleChoice => '選択問題';

  @override
  String get quizTypeFillInTheBlank => '穴埋め';

  @override
  String get quizTypeMatching => 'マッチング';

  @override
  String get quizTypeTrueFalse => '〇✕問題';

  @override
  String get quizTypeFlashcard => 'フラッシュカード';

  @override
  String get ratingAgain => 'もう一度';

  @override
  String get ratingHard => '難しい';

  @override
  String get ratingGood => '普通';

  @override
  String get ratingEasy => '簡単';

  @override
  String get ratingQuestion => 'どのくらい思い出せましたか？';

  @override
  String ratingReviewAgainIn(String interval) {
    return '$interval後に再復習';
  }

  @override
  String get greetingMorning => 'おはようございます';

  @override
  String get greetingAfternoon => 'こんにちは';

  @override
  String get greetingEvening => 'こんばんは';

  @override
  String get homeReady => '学習を始めましょうか？';

  @override
  String get homeSavedOnDevice => '端末に保存済み';

  @override
  String get homeTodaysQueue => '今日の復習';

  @override
  String get homeAllCaughtUp => 'すべて完了';

  @override
  String homeQueueEstimate(int minutes, int decks) {
    String _temp0 = intl.Intl.pluralLogic(
      decks,
      locale: localeName,
      other: '$decks個のデッキ',
    );
    return '約$minutes分 · $_temp0';
  }

  @override
  String get homeStartReview => '復習を始める';

  @override
  String get homeExamTeaser => '時間制限付きの集中練習。結果はスケジュールに反映されます';

  @override
  String get homeYourDecks => 'マイデッキ';

  @override
  String get librarySearch => 'デッキを検索';

  @override
  String get libraryFilterAll => 'すべて';

  @override
  String get libraryFilterDue => '要学習';

  @override
  String get libraryEmpty => 'デッキはまだありません。作成するか、.qdeck ファイルをインポートしてください。';

  @override
  String get libraryNoMatch => '一致するデッキはありません。';

  @override
  String get deckNew => '新規デッキ';

  @override
  String get deckEdit => 'デッキを編集';

  @override
  String get deckFieldTitle => 'タイトル';

  @override
  String get deckFieldDescription => '説明（任意）';

  @override
  String deckDueCount(int count) {
    return '復習 $count';
  }

  @override
  String deckNewCount(int count) {
    return '新規 $count';
  }

  @override
  String get deckDone => '完了';

  @override
  String deckBy(String author) {
    return '作成者：$author';
  }

  @override
  String get deckGone => 'このデッキはもう存在しません。';

  @override
  String deckDeleteTitle(String title) {
    return '「$title」を削除しますか？';
  }

  @override
  String get deckDeleteBody => 'デッキとそのクイズはこの端末から削除されます。復習履歴は残ります。';

  @override
  String get deckMetricDue => '復習';

  @override
  String get deckMetricRetention => '定着率';

  @override
  String get deckMetricMature => '定着済み';

  @override
  String get deckQuizTypes => 'クイズの種類';

  @override
  String get deckQuizzes => 'クイズ';

  @override
  String get deckAddQuiz => 'クイズを追加';

  @override
  String get deckNoQuizzes => 'クイズはまだありません。最初のクイズを追加しましょう。';

  @override
  String get deckSyncNote =>
      'このデッキの学習状況は復習イベントとして同期されます。デッキ自体が再アップロードされることはありません。';

  @override
  String get deckStudy => '学習する';

  @override
  String get deckNothingToStudy => '今は学習するものがありません';

  @override
  String deckStudyCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count枚を学習',
    );
    return '$_temp0';
  }

  @override
  String get quizDeleteTitle => 'このクイズを削除しますか？';

  @override
  String get quizDeleteTooltip => 'クイズを削除';

  @override
  String get quizEditorNew => '新規クイズ';

  @override
  String get quizEditorEdit => 'クイズを編集';

  @override
  String get quizEditorType => '種類';

  @override
  String get quizEditorQuestion => '問題';

  @override
  String get quizEditorStatement => '文';

  @override
  String get quizEditorFront => '表面';

  @override
  String get quizEditorSentence => '文 — 空欄を ___ で示してください';

  @override
  String get quizEditorSentenceHint =>
      '.qdeck は ___ を含むクイズを ZIP 内にシリアライズして保存します。';

  @override
  String get quizEditorInstructions => '指示';

  @override
  String get quizEditorInstructionsHint => '各用語をその定義と組み合わせてください';

  @override
  String get quizEditorHint => '補足（任意）';

  @override
  String get quizEditorHintHint => '問題の下に表示されます（例：訳文）';

  @override
  String get quizEditorBack => '裏面';

  @override
  String get quizEditorExplanation => '解説（回答後に表示）';

  @override
  String get quizEditorOptions => '選択肢 — 正解を1つ選んでください';

  @override
  String quizEditorOptionN(int number) {
    return '選択肢$number';
  }

  @override
  String get quizEditorAddOption => '選択肢を追加';

  @override
  String get quizEditorStatementIs => 'この文は';

  @override
  String get quizEditorAccepted => '正解とする答え';

  @override
  String quizEditorAnswerN(int number) {
    return '答え$number';
  }

  @override
  String get quizEditorAddAnswer => '正解を追加';

  @override
  String get quizEditorPairs => 'ペア';

  @override
  String get quizEditorTerm => '用語';

  @override
  String get quizEditorMatch => '対応';

  @override
  String get quizEditorAddPair => 'ペアを追加';

  @override
  String get quizEditorSave => 'クイズを保存';

  @override
  String get issueEmptyQuestion => '問題を入力してください。';

  @override
  String get issueEmptyFront => '表面を入力してください。';

  @override
  String get issueDuplicateOptionIds => '選択肢の ID は重複できません。';

  @override
  String get issueTooFewOptions => '選択肢を2つ以上追加してください。';

  @override
  String get issueEmptyOptions => '空の選択肢があります。';

  @override
  String get issueDuplicateOptions => '選択肢はそれぞれ異なる内容にしてください。';

  @override
  String get issueNotOneCorrect => '正解の選択肢を1つだけ選んでください。';

  @override
  String get issueTrueFalseOptions => '〇✕問題には「true」と「false」の選択肢が必要です。';

  @override
  String get issueTrueFalseNoAnswer => 'この文が正しいかどうかを選んでください。';

  @override
  String get issueEmptyBack => '裏面を入力してください。';

  @override
  String get issueFlashcardOptions => 'フラッシュカードには選択肢がありません。';

  @override
  String get issueNotOneBlank => '文中の空欄を ___ で1か所だけ示してください。';

  @override
  String get issueNoAnswers => '正解を1つ以上追加してください。';

  @override
  String get issueEmptyAnswers => '空の正解があります。';

  @override
  String get issueAnswerNotCorrect => '正解とする答えはすべて正解に設定してください。';

  @override
  String get issueTooFewPairs => 'ペアを2つ以上追加してください。';

  @override
  String get issueEmptyPairSide => 'すべてのペアの両側を入力してください。';

  @override
  String get issueDuplicatePairs => '用語と対応はそれぞれ異なる内容にしてください。';

  @override
  String get studyEnd => 'セッションを終了';

  @override
  String studySaveFailed(String error) {
    return '復習を保存できませんでした：$error';
  }

  @override
  String get studyAllCaughtUp => 'すべて完了';

  @override
  String get studyNothingDue => '今は復習するものがありません。';

  @override
  String get studyNothingDueBody => '後でまた来るか、デッキにクイズを追加するか、試験モードを試してみましょう。';

  @override
  String get feedbackCorrect => '正解！';

  @override
  String get feedbackWrong => '惜しい！';

  @override
  String choiceAnswer(String answer) {
    return '答え：$answer';
  }

  @override
  String get trueFalseTrue => '正しい';

  @override
  String get trueFalseFalse => '誤り';

  @override
  String get trueFalseExplainAfter => '回答すると解説が表示されます';

  @override
  String get fillPrompt => '文を完成させてください';

  @override
  String get fillTypeAnswer => '答えを入力';

  @override
  String fillAccepted(String answers) {
    return '正解：$answers';
  }

  @override
  String fillLetterHint(String letter) {
    return 'ヒント：「$letter」で始まります';
  }

  @override
  String get fillShowHint => 'ヒントを表示';

  @override
  String get fillCheck => '答え合わせ';

  @override
  String get flashcardBack => '裏面';

  @override
  String get flashcardRecall => '答えを思い出してから、タップして確認しましょう。';

  @override
  String get flashcardShowAnswer => '答えを表示';

  @override
  String get matchingAllSet => 'すべてのペアがそろいました。タイルをタップすると変更できます。';

  @override
  String matchingInstructions(int remaining, int total) {
    return '用語をタップしてから、対応するものをタップしてください。残り $remaining / $total ペア。';
  }

  @override
  String matchingCorrectPairs(String pairs) {
    return '正しいペア：$pairs';
  }

  @override
  String get matchingCheck => 'ペアを確認';

  @override
  String get sessionComplete => 'セッション完了';

  @override
  String sessionCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count枚。',
    );
    return '$_temp0';
  }

  @override
  String get sessionNiceRun => 'よくできました。';

  @override
  String get sessionKeepGoing => 'その調子で続けましょう。';

  @override
  String sessionEventsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の復習イベントを端末に保存しました',
    );
    return '$_temp0';
  }

  @override
  String get statAccuracy => '正答率';

  @override
  String get statXpEarned => '獲得 XP';

  @override
  String get statDayStreak => '連続日数';

  @override
  String get statTime => '時間';

  @override
  String get examTitle => '試験モード';

  @override
  String get examIntro =>
      '時間制限付きの集中練習です。復習期限前のカードも出題され、すべての回答は実際の復習としてスケジュールに反映されます。';

  @override
  String get examQuickName => 'クイック試験';

  @override
  String get examStart => '試験を開始';

  @override
  String get examPresets => 'プリセット';

  @override
  String get examNewPreset => '新規プリセット';

  @override
  String get examEditPreset => 'プリセットを編集';

  @override
  String get examNoPresets => 'プリセットはまだありません。よく使う設定を保存しましょう。';

  @override
  String get examRecent => '最近の結果';

  @override
  String get examNoRuns => 'まだ試験を受けていません。';

  @override
  String examQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count問',
    );
    return '$_temp0';
  }

  @override
  String examPerQuestion(int seconds) {
    return '1問$seconds秒';
  }

  @override
  String examDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個のデッキ',
    );
    return '$_temp0';
  }

  @override
  String examCorrectOf(int correct, int total) {
    return '$total問中$correct問正解';
  }

  @override
  String get examUntimed => '時間制限なし';

  @override
  String get examSelectionWeakest => '苦手な順';

  @override
  String get examSelectionWeakestDetail => '予測される想起率から、忘れやすいカードを優先します。';

  @override
  String get examSelectionRandom => 'ランダム';

  @override
  String get examSelectionRandomDetail => '対象範囲のすべてをシャッフルして出題します。';

  @override
  String get examSelectionDueFirst => '期限順';

  @override
  String get examSelectionDueFirstDetail => '期限切れのカードを先に、次に期限が近いカードを出題します。';

  @override
  String get examEndCompleted => '完了';

  @override
  String get examEndTimeUp => '時間切れ';

  @override
  String get examEndStopped => '途中で終了';

  @override
  String get examFieldName => '名前';

  @override
  String get examFieldDecks => 'デッキ';

  @override
  String get examAllDecks => 'すべてのデッキ';

  @override
  String get examFieldSelection => 'カードの選び方';

  @override
  String get examFieldQuestions => '問題数';

  @override
  String get examFieldTimeLimit => '制限時間';

  @override
  String get examFieldTimePerQuestion => '1問あたりの時間';

  @override
  String get examFieldQuizTypes => 'クイズの種類';

  @override
  String get examFieldIncludeNew => '新規カードを含める';

  @override
  String get examFieldIncludeNewDetail => 'まだ学習していないカードも出題します。';

  @override
  String get examFieldAutoRate => '自動で評価';

  @override
  String get examFieldAutoRateDetail =>
      '不正解は「もう一度」、速く正解なら「普通」、時間をかけて正解なら「難しい」になります。フラッシュカードは自分で評価します。';

  @override
  String get examFieldAllowHints => 'ヒントを許可';

  @override
  String get examFieldAllowHintsDetail => '穴埋めクイズで最初の文字のヒントを表示します。';

  @override
  String get examAffectsSchedule => '試験の回答は実際の復習です。カードのスケジュールが変わり、XP も獲得できます。';

  @override
  String get examIssueEmptyName => 'プリセットに名前を付けてください。';

  @override
  String get examIssueNoQuizTypes => 'クイズの種類を1つ以上選んでください。';

  @override
  String examIssueQuestionCount(int min, int max) {
    return '問題数は$min〜$max問で選んでください。';
  }

  @override
  String get examDeleteTitle => 'プリセットを削除しますか？';

  @override
  String examDeleteBody(String name) {
    return '「$name」を削除します。過去の結果は残ります。';
  }

  @override
  String get examPill => '試験';

  @override
  String get examStop => '試験を中止';

  @override
  String get examStopTitle => '試験を中止しますか？';

  @override
  String get examStopBody => 'ここまでの回答は保存され、すでにスケジュールに反映されています。';

  @override
  String get examKeepGoing => '続ける';

  @override
  String get examQuestionTimeUp => '時間切れです。';

  @override
  String get examTimeUpBanner => '試験時間が終了しました。これが最後の問題です。';

  @override
  String examRatedAs(String rating) {
    return '評価：$rating';
  }

  @override
  String get examNextQuestion => '次の問題';

  @override
  String get examSeeResults => '結果を見る';

  @override
  String get examAnswered => '回答済み';

  @override
  String get examUnanswered => '未回答';

  @override
  String examMissed(int count) {
    return '要復習（$count）';
  }

  @override
  String examReviewsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の復習を端末に保存しました。',
      zero: '復習は記録されませんでした。',
    );
    return '$_temp0';
  }

  @override
  String get examRetake => 'もう一度受ける';

  @override
  String get examNoCards => '出題できるカードがありません。';

  @override
  String get examNoCardsBody => 'これらのデッキには、選択したクイズの種類のカードがありません。';

  @override
  String get examNoCardsBodyNew =>
      '学習済みのカードのみ出題されます。先にカードを学習するか、プリセットで「新規カードを含める」を有効にしてください。';

  @override
  String get remindersTitle => 'リマインダー';

  @override
  String get remindersIntro => '都合のよい時間に学習のお知らせを受け取れます。リマインダーはこの端末でのみ設定されます。';

  @override
  String get remindersAdd => 'リマインダーを追加';

  @override
  String get remindersEmpty => 'リマインダーはまだありません。';

  @override
  String get remindersNoDays => '曜日を1つ以上選んでください。選ばないとこのリマインダーは通知されません。';

  @override
  String get remindersOff => 'オフ';

  @override
  String remindersActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件が有効',
    );
    return '$_temp0';
  }

  @override
  String get remindersUnsupported =>
      'このプラットフォームでは通知を設定できません。リマインダーは保存され、スマートフォンで適用されます。';

  @override
  String get remindersPermissionDenied =>
      'Qyic の通知がオフになっています。リマインダーを受け取るには、システム設定で通知を許可してください。';

  @override
  String get reminderTitle => '学習の時間です';

  @override
  String get reminderBody => '数分の学習で、連続記録と記憶をキープしましょう。';

  @override
  String get reminderChannel => '学習リマインダー';

  @override
  String get prefTitle => '設定';

  @override
  String get prefSectionGeneral => '一般';

  @override
  String get prefSectionStudy => '学習';

  @override
  String get prefSectionNotifications => '通知';

  @override
  String get prefSectionData => 'データ';

  @override
  String get prefSectionAbout => 'このアプリについて';

  @override
  String get prefLanguage => '言語';

  @override
  String get prefSystem => 'システムのデフォルト';

  @override
  String get prefName => '名前';

  @override
  String get prefDailyGoal => '1日の目標';

  @override
  String get prefDailyGoalDetail => '目標達成に必要な1日の復習数です。';

  @override
  String get prefNewCards => '1日の新規カード数';

  @override
  String get prefNewCardsDetail => 'すべてのデッキを合わせて、1日に新しく出題する未学習カードの数です。';

  @override
  String get prefRetention => '目標定着率';

  @override
  String get prefRetentionDetail => '定着率を高くすると復習の頻度が増えます。今後の復習に適用されます。';

  @override
  String get prefIntervals => '次の間隔を表示';

  @override
  String get prefIntervalsDetail => '評価ボタンに、次にカードが出題されるまでの間隔を表示します。';

  @override
  String get prefHaptics => '触覚フィードバック';

  @override
  String get prefHapticsDetail => '回答時と評価時に振動します。';

  @override
  String get prefStorage => '使用ストレージ';

  @override
  String get prefLicenses => 'オープンソースライセンス';

  @override
  String get meDefaultName => '学習者';

  @override
  String meSummary(int level, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak日連続',
    );
    return 'レベル$level · $_temp0';
  }

  @override
  String get meSyncOff => '同期は未設定です';

  @override
  String meEventsOnDevice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '端末内のイベント $count件',
    );
    return '$_temp0';
  }

  @override
  String get meSyncBody =>
      '復習はまずこの端末に保存されます。サインインと同期が利用可能になると、保留中の復習イベントがアップロードされます。デッキが再アップロードされることはありません。';

  @override
  String get meSettings => '設定';

  @override
  String get meMore => 'その他';

  @override
  String get meSyncUnavailable => '今すぐ同期 · まだ利用できません';

  @override
  String get importAction => '.qdeck をインポート';

  @override
  String get importTitle => '.qdeck をインポート';

  @override
  String get importChecking => 'ファイルを確認しています…';

  @override
  String get importNewBadge => '新規デッキ';

  @override
  String importUpdateBadge(int from, int to) {
    return '更新 v$from → v$to';
  }

  @override
  String importSpecVersion(int version) {
    return '仕様 v$version';
  }

  @override
  String importDeckVersion(int version) {
    return 'デッキ v$version';
  }

  @override
  String get importCheckArchive => 'アーカイブのパスは安全です';

  @override
  String get importCheckArchiveDetail => 'パストラバーサルなし';

  @override
  String get importCheckManifest => 'マニフェストは有効です';

  @override
  String get importCheckChecksum => 'SHA-256 が一致しました';

  @override
  String get importCheckQuizRules => 'クイズはルールに準拠しています';

  @override
  String importChanges(int added, int updated, int removed) {
    return '新規 $added · 変更 $updated · 削除 $removed';
  }

  @override
  String importSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count問のクイズは、このバージョンでは表示できない種類のためスキップされます。',
    );
    return '$_temp0';
  }

  @override
  String importMediaUnsupported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のメディアファイルはまだ表示されません。',
    );
    return '$_temp0';
  }

  @override
  String get importProgressKeptTitle => '学習状況は保持されます。';

  @override
  String get importProgressKeptBody =>
      'インストールでは、この端末のコンテンツが追加・更新されるだけで、復習履歴はそのまま残ります。';

  @override
  String get importInstallAction => 'インストール';

  @override
  String get importUpdateAction => '更新';

  @override
  String importInstalled(String title) {
    return '「$title」をインストールしました';
  }

  @override
  String importUpdated(String title) {
    return '「$title」を更新しました';
  }

  @override
  String importInstallFailed(String error) {
    return 'インストールできませんでした：$error';
  }

  @override
  String get importFailedTitle => 'このファイルはインポートできません';

  @override
  String get deckManageCards => 'カードを管理';

  @override
  String get deckModeMixed => 'ミックス';

  @override
  String get deckModeQuizzes => '問題のみ';

  @override
  String get deckModeFlashcards => '暗記カードのみ';

  @override
  String get deckModeExam => '試験';

  @override
  String get deckModeMixedDetail => '期限のカードと新規カード、すべての種類。';

  @override
  String get deckModeQuizzesDetail => '問題のみ。暗記カードは含みません。';

  @override
  String get deckModeFlashcardsDetail => '暗記カードのみ。';

  @override
  String deckModeExamDetailLarge(int count) {
    return 'すべての種類。開始時に100から$count問を選びます。';
  }

  @override
  String deckModeExamDetailSmall(int count) {
    return 'すべての種類。$count問。';
  }

  @override
  String get deckExamStart => '試験を開始';
}
