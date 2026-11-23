import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/qyic_primary_button.dart';
import '../../../../core/widgets/qyic_shared_widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../decks/domain/deck.dart';
import '../../domain/grading.dart';
import '../widgets/answer_feedback.dart';

class FlashcardView extends StatefulWidget {
  const FlashcardView({
    super.key,
    required this.quiz,
    required this.onGraded,
    this.enabled = true,
  });

  final Quiz quiz;
  final ValueChanged<GradeOutcome> onGraded;
  final bool enabled;

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  bool _revealed = false;

  bool get _canReveal => widget.enabled && !_revealed;

  void _reveal() {
    if (!_canReveal) return;
    setState(() => _revealed = true);
    widget.onGraded(grade(widget.quiz, const SelfGradedAnswer()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            children: [
              Text(widget.quiz.question, style: textTheme.headlineMedium),
              QuizHintLine(widget.quiz.hint),
              const SizedBox(height: 16),
              QyicPanel(
                onTap: _canReveal ? _reveal : null,
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _revealed
                        ? Column(
                            key: const ValueKey('back'),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QyicSectionLabel(l10n.flashcardBack),
                              const SizedBox(height: 10),
                              Text(
                                widget.quiz.explanation,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            key: const ValueKey('front'),
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              l10n.flashcardRecall,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_canReveal)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: QyicPrimaryButton(
              label: l10n.flashcardShowAnswer,
              onPressed: _reveal,
            ),
          ),
      ],
    );
  }
}
