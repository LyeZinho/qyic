import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../../core/scheduling/fsrs.dart';
import '../../decks/domain/deck.dart';
import '../../study/domain/grading.dart';

/// Which cards an exam draws first. Values are stored in `exam_presets`.
enum ExamSelection {
  /// Lowest predicted recall first (FSRS retrievability); unseen cards last.
  weakest(1),

  /// Uniformly shuffled.
  random(2),

  /// Earliest due date first, including cards that are not due yet.
  dueFirst(3);

  const ExamSelection(this.value);

  final int value;

  static ExamSelection fromValue(int value) =>
      values.firstWhere((selection) => selection.value == value);
}

/// Why an exam ended. Values are stored in `exam_runs`.
enum ExamEndReason {
  completed(1),
  timeUp(2),
  stopped(3);

  const ExamEndReason(this.value);

  final int value;

  static ExamEndReason fromValue(int value) =>
      values.firstWhere((reason) => reason.value == value);
}

/// An exam configuration. Value-equal, so it can key providers.
@immutable
class ExamPreset {
  const ExamPreset({
    this.id,
    required this.name,
    this.deckIds = const {},
    this.selection = ExamSelection.weakest,
    this.questionCount = 20,
    this.timeLimit,
    this.timePerQuestion = const Duration(seconds: 30),
    this.quizTypes = defaultQuizTypes,
    this.includeNew = false,
    this.autoRate = true,
    this.allowHints = false,
  });

  /// Defaults: objectively graded types only, so auto-rating applies to all.
  static const defaultQuizTypes = {
    QuizType.multipleChoice,
    QuizType.trueFalse,
    QuizType.fillInTheBlank,
    QuizType.matching,
  };

  static const questionCountRange = (min: 5, max: 200);

  /// Choices offered for [timeLimit] in minutes; null = untimed.
  static const timeLimitChoices = <int?>[null, 5, 10, 15, 20, 30, 45, 60];

  /// Choices offered for [timePerQuestion] in seconds; null = untimed.
  static const timePerQuestionChoices = <int?>[
    null,
    10,
    15,
    20,
    30,
    45,
    60,
    90,
  ];

  /// Null for an unsaved preset (e.g. a quick exam).
  final String? id;
  final String name;

  /// Decks to draw from; empty means every deck.
  final Set<String> deckIds;
  final ExamSelection selection;
  final int questionCount;

  /// Whole-exam limit; null = untimed.
  final Duration? timeLimit;

  /// Per-question limit; running out counts as a wrong answer. Null = untimed.
  final Duration? timePerQuestion;
  final Set<QuizType> quizTypes;

  /// Also draw cards that were never studied.
  final bool includeNew;

  /// Rate objectively graded answers from correctness and speed instead of
  /// asking for a rating (see [autoRating]).
  final bool autoRate;

  /// Allow the fill-in-the-blank hint.
  final bool allowHints;

  ExamPreset copyWith({
    String? id,
    String? name,
    Set<String>? deckIds,
    ExamSelection? selection,
    int? questionCount,
    ValueGetter<Duration?>? timeLimit,
    ValueGetter<Duration?>? timePerQuestion,
    Set<QuizType>? quizTypes,
    bool? includeNew,
    bool? autoRate,
    bool? allowHints,
  }) => ExamPreset(
    id: id ?? this.id,
    name: name ?? this.name,
    deckIds: deckIds ?? this.deckIds,
    selection: selection ?? this.selection,
    questionCount: questionCount ?? this.questionCount,
    timeLimit: timeLimit != null ? timeLimit() : this.timeLimit,
    timePerQuestion: timePerQuestion != null
        ? timePerQuestion()
        : this.timePerQuestion,
    quizTypes: quizTypes ?? this.quizTypes,
    includeNew: includeNew ?? this.includeNew,
    autoRate: autoRate ?? this.autoRate,
    allowHints: allowHints ?? this.allowHints,
  );

  /// Human-readable problems; empty when the preset can be saved and run.
  List<ExamPresetIssue> validate() => [
    if (name.trim().isEmpty) ExamPresetIssue.emptyName,
    if (quizTypes.isEmpty) ExamPresetIssue.noQuizTypes,
    if (questionCount < questionCountRange.min ||
        questionCount > questionCountRange.max)
      ExamPresetIssue.questionCount,
  ];

  @override
  bool operator ==(Object other) =>
      other is ExamPreset &&
      other.id == id &&
      other.name == name &&
      setEquals(other.deckIds, deckIds) &&
      other.selection == selection &&
      other.questionCount == questionCount &&
      other.timeLimit == timeLimit &&
      other.timePerQuestion == timePerQuestion &&
      setEquals(other.quizTypes, quizTypes) &&
      other.includeNew == includeNew &&
      other.autoRate == autoRate &&
      other.allowHints == allowHints;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    Object.hashAllUnordered(deckIds),
    selection,
    questionCount,
    timeLimit,
    timePerQuestion,
    Object.hashAllUnordered(quizTypes),
    includeNew,
    autoRate,
    allowHints,
  );
}

enum ExamPresetIssue { emptyName, noQuizTypes, questionCount }

/// A finished exam, kept as local history.
class ExamRun {
  const ExamRun({
    required this.id,
    required this.presetId,
    required this.name,
    required this.startedAt,
    required this.finishedAt,
    required this.questionCount,
    required this.answeredCount,
    required this.correctCount,
    required this.endReason,
  });

  final String id;
  final String? presetId;
  final String name;
  final DateTime startedAt;
  final DateTime finishedAt;
  final int questionCount;
  final int answeredCount;
  final int correctCount;
  final ExamEndReason endReason;

  Duration get duration => finishedAt.difference(startedAt);

  /// Share of all planned questions answered correctly.
  double get score => questionCount == 0 ? 0 : correctCount / questionCount;
}

/// Decks larger than this draw an exam of at least this many questions.
const deckExamFullDraw = 100;

/// How many questions the deck-page exam asks.
///
/// More than [deckExamFullDraw] cards: a random count from that floor up to
/// the whole deck. Exactly [deckExamFullDraw]: all of them. Fewer: half the
/// deck, rounded up, so an odd deck still divides into a whole number.
int deckExamQuestionCount(int quizCount, math.Random random) {
  if (quizCount <= 0) {
    throw ArgumentError.value(quizCount, 'quizCount', 'must be positive');
  }
  if (quizCount > deckExamFullDraw) {
    return deckExamFullDraw + random.nextInt(quizCount - deckExamFullDraw + 1);
  }
  if (quizCount == deckExamFullDraw) return quizCount;
  return (quizCount + 1) ~/ 2;
}

/// Answers faster than this count as fluent when there is no per-question
/// limit; with a limit, half of it is used.
const fluentAnswerTime = Duration(seconds: 10);

/// The rating applied when an exam rates automatically: a wrong (or timed
/// out) answer is Again, a fluent correct answer Good, a slow one Hard.
/// Easy is never inferred. Self-graded answers need the learner's rating.
Rating? autoRating(
  GradeOutcome outcome,
  Duration answerTime,
  Duration? timePerQuestion,
) {
  final fluent = timePerQuestion == null
      ? fluentAnswerTime
      : timePerQuestion ~/ 2;
  return switch (outcome) {
    GradeOutcome.incorrect => Rating.again,
    GradeOutcome.correct => answerTime <= fluent ? Rating.good : Rating.hard,
    GradeOutcome.selfGraded => null,
  };
}
