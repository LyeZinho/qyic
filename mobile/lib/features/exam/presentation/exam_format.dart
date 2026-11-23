import 'package:material_ui/material_ui.dart';

import '../../../core/theme/qyic_colors.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../../decks/domain/deck.dart';
import '../domain/exam.dart';

/// "20 questions · Weakest first · 10 min · 30 s each".
String examPresetSummary(AppLocalizations l10n, ExamPreset preset) => [
  l10n.examQuestionCount(preset.questionCount),
  preset.selection.label(l10n),
  if (preset.timeLimit case final limit?) l10n.durationMinutes(limit.inMinutes),
  if (preset.timePerQuestion case final limit?)
    l10n.examPerQuestion(limit.inSeconds),
  if (preset.deckIds.isNotEmpty) l10n.examDeckCount(preset.deckIds.length),
].join(' · ');

/// Teal from 80%, orange from 50%, coral below.
Color scoreColor(double score) => score >= 0.8
    ? QyicColors.teal
    : score >= 0.5
    ? QyicColors.orange
    : QyicColors.coral;

/// The answer the learner should have given, for review after a timeout or
/// a miss.
String expectedAnswer(Quiz quiz) => switch (quiz.type) {
  QuizType.multipleChoice || QuizType.trueFalse =>
    quiz.options.firstWhere((option) => option.isCorrect).text,
  QuizType.fillInTheBlank => quiz.options.first.text,
  QuizType.matching =>
    quiz.options
        .map((option) => '${option.prompt} → ${option.text}')
        .join('; '),
  QuizType.flashcard => quiz.explanation,
};
