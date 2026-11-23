import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/qyic_colors.dart';
import '../../../../core/widgets/qyic_primary_button.dart';
import '../../../../core/widgets/qyic_shared_widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../decks/domain/deck.dart';
import '../../domain/grading.dart';
import '../widgets/answer_feedback.dart';

class FillBlankView extends StatefulWidget {
  const FillBlankView({
    super.key,
    required this.quiz,
    required this.onGraded,
    this.enabled = true,
    this.allowLetterHint = true,
  });

  final Quiz quiz;
  final ValueChanged<GradeOutcome> onGraded;
  final bool enabled;

  /// Offer the "starts with …" hint.
  final bool allowLetterHint;

  @override
  State<FillBlankView> createState() => _FillBlankViewState();
}

class _FillBlankViewState extends State<FillBlankView> {
  final _controller = TextEditingController();
  GradeOutcome? _outcome;
  bool _showLetterHint = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    if (!widget.enabled ||
        _outcome != null ||
        _controller.text.trim().isEmpty) {
      return;
    }
    final outcome = grade(widget.quiz, TextAnswer(_controller.text));
    setState(() => _outcome = outcome);
    widget.onGraded(outcome);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final parts = splitAtBlank(widget.quiz.question);
    final typed = _controller.text.trim();
    final outcome = _outcome;
    final open = outcome == null && widget.enabled;
    final primaryAnswer = widget.quiz.options.first.text;
    final blankColor = switch (outcome) {
      GradeOutcome.incorrect => QyicColors.failure,
      _ => QyicColors.lime,
    };

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            children: [
              Text(l10n.fillPrompt, style: textTheme.headlineMedium),
              const SizedBox(height: 16),
              QyicPanel(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: parts.before),
                          TextSpan(
                            text: typed.isEmpty ? '\u2007' * 12 : ' $typed ',
                            style: TextStyle(
                              color: blankColor,
                              decoration: TextDecoration.underline,
                              decorationColor: blankColor,
                              decorationThickness: 2,
                            ),
                          ),
                          TextSpan(text: parts.after),
                        ],
                      ),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                        fontSize: 18,
                      ),
                    ),
                    QuizHintLine(widget.quiz.hint),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                enabled: open,
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _check(),
                decoration: InputDecoration(hintText: l10n.fillTypeAnswer),
              ),
              const SizedBox(height: 12),
              if (outcome != null)
                AnswerFeedback(
                  correct: outcome == GradeOutcome.correct,
                  explanation: widget.quiz.explanation,
                  detail: outcome == GradeOutcome.correct
                      ? null
                      : l10n.fillAccepted(
                          widget.quiz.options.map((o) => o.text).join(', '),
                        ),
                )
              else if (open && widget.allowLetterHint)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: _showLetterHint
                      ? QyicPill(
                          l10n.fillLetterHint(primaryAnswer.characters.first),
                          color: QyicColors.orange,
                        )
                      : TextButton(
                          onPressed: () =>
                              setState(() => _showLetterHint = true),
                          child: Text(l10n.fillShowHint),
                        ),
                ),
            ],
          ),
        ),
        if (open)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: QyicPrimaryButton(
              label: l10n.fillCheck,
              onPressed: typed.isEmpty ? null : _check,
            ),
          ),
      ],
    );
  }
}
