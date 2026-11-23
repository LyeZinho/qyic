import 'package:flutter/material.dart';

import '../../../decks/domain/deck.dart';
import '../../domain/grading.dart';
import 'choice_quiz_view.dart';
import 'fill_blank_view.dart';
import 'flashcard_view.dart';
import 'matching_view.dart';

/// The interactive view for any quiz type. Reports the graded answer once;
/// with [enabled] false the quiz is shown but cannot be answered.
class QuizView extends StatelessWidget {
  const QuizView({
    super.key,
    required this.quiz,
    required this.onGraded,
    this.enabled = true,
    this.allowLetterHint = true,
  });

  final Quiz quiz;
  final ValueChanged<GradeOutcome> onGraded;
  final bool enabled;
  final bool allowLetterHint;

  @override
  Widget build(BuildContext context) => switch (quiz.type) {
    QuizType.multipleChoice || QuizType.trueFalse => ChoiceQuizView(
      quiz: quiz,
      onGraded: onGraded,
      enabled: enabled,
    ),
    QuizType.flashcard => FlashcardView(
      quiz: quiz,
      onGraded: onGraded,
      enabled: enabled,
    ),
    QuizType.fillInTheBlank => FillBlankView(
      quiz: quiz,
      onGraded: onGraded,
      enabled: enabled,
      allowLetterHint: allowLetterHint,
    ),
    QuizType.matching => MatchingView(
      quiz: quiz,
      onGraded: onGraded,
      enabled: enabled,
    ),
  };
}
