import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/qyic_colors.dart';
import '../../../../core/widgets/qyic_shared_widgets.dart';
import '../../../../l10n/l10n.dart';

/// Result panel shown after an objectively graded answer.
class AnswerFeedback extends StatelessWidget {
  const AnswerFeedback({
    super.key,
    required this.correct,
    required this.explanation,
    this.detail,
  });

  final bool correct;
  final String explanation;

  /// Extra line for wrong answers, e.g. the expected answer.
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = correct ? QyicColors.success : QyicColors.failure;
    return QyicPanel(
      borderColor: color,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${correct ? l10n.feedbackCorrect : l10n.feedbackWrong} ',
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
            if (detail != null)
              TextSpan(
                text: explanation.isEmpty ? detail : '$detail\n',
                style: const TextStyle(color: QyicColors.textPrimary),
              ),
            TextSpan(text: explanation),
          ],
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

/// The quiz's optional context line (`Quiz.hint`), e.g. the translation of
/// a fill-in-the-blank sentence. Renders nothing when empty.
class QuizHintLine extends StatelessWidget {
  const QuizHintLine(this.hint, {super.key});

  final String hint;

  @override
  Widget build(BuildContext context) {
    if (hint.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.translate_rounded,
              size: 16,
              color: QyicColors.textMuted,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hint,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
