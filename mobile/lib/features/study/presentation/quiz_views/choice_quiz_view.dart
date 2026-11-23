import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/qyic_colors.dart';
import '../../../../l10n/l10n.dart';
import '../../../decks/domain/deck.dart';
import '../../domain/grading.dart';
import '../widgets/answer_feedback.dart';

/// Multiple choice (lettered list, shuffled) and true/false (two tiles).
class ChoiceQuizView extends StatefulWidget {
  const ChoiceQuizView({
    super.key,
    required this.quiz,
    required this.onGraded,
    this.enabled = true,
  });

  final Quiz quiz;
  final ValueChanged<GradeOutcome> onGraded;
  final bool enabled;

  @override
  State<ChoiceQuizView> createState() => _ChoiceQuizViewState();
}

class _ChoiceQuizViewState extends State<ChoiceQuizView> {
  late final List<QuizOption> _options;
  String? _chosenId;
  GradeOutcome? _outcome;

  bool get _isTrueFalse => widget.quiz.type == QuizType.trueFalse;

  @override
  void initState() {
    super.initState();
    _options = _isTrueFalse
        ? widget.quiz.options
        : ([...widget.quiz.options]..shuffle());
  }

  void _choose(QuizOption option) {
    if (!widget.enabled || _outcome != null) return;
    final outcome = grade(widget.quiz, ChoiceAnswer(option.id));
    setState(() {
      _chosenId = option.id;
      _outcome = outcome;
    });
    widget.onGraded(outcome);
  }

  _TileState _stateOf(QuizOption option) {
    if (_outcome == null) return _TileState.idle;
    if (option.isCorrect) return _TileState.correct;
    if (option.id == _chosenId) return _TileState.wrong;
    return _TileState.dimmed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final outcome = _outcome;
    final correctOption = widget.quiz.options.firstWhere((o) => o.isCorrect);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      children: [
        Text(
          _isTrueFalse ? '“${widget.quiz.question}”' : widget.quiz.question,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        QuizHintLine(widget.quiz.hint),
        const SizedBox(height: 20),
        if (_isTrueFalse)
          Row(
            children: [
              for (final (index, option) in _options.indexed) ...[
                if (index > 0) const SizedBox(width: 12),
                Expanded(
                  child: _TrueFalseTile(
                    option: option,
                    label: option.id == 'true'
                        ? l10n.trueFalseTrue
                        : l10n.trueFalseFalse,
                    state: _stateOf(option),
                    accent: index == 0 ? QyicColors.teal : QyicColors.coral,
                    onTap: () => _choose(option),
                  ),
                ),
              ],
            ],
          )
        else
          for (final (index, option) in _options.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ChoiceTile(
                letter: String.fromCharCode(0x41 + index),
                option: option,
                state: _stateOf(option),
                onTap: () => _choose(option),
              ),
            ),
        if (outcome != null) ...[
          const SizedBox(height: 10),
          AnswerFeedback(
            correct: outcome == GradeOutcome.correct,
            explanation: widget.quiz.explanation,
            detail: outcome == GradeOutcome.correct
                ? null
                : l10n.choiceAnswer(
                    _isTrueFalse
                        ? (correctOption.id == 'true'
                              ? l10n.trueFalseTrue
                              : l10n.trueFalseFalse)
                        : correctOption.text,
                  ),
          ),
        ] else if (_isTrueFalse) ...[
          const SizedBox(height: 24),
          Text(
            l10n.trueFalseExplainAfter,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}

enum _TileState { idle, correct, wrong, dimmed }

({Color border, Color fill}) _tileColors(_TileState state) => switch (state) {
  _TileState.correct => (
    border: QyicColors.success,
    fill: QyicColors.successSurface,
  ),
  _TileState.wrong => (
    border: QyicColors.failure,
    fill: QyicColors.failureSurface,
  ),
  _TileState.idle ||
  _TileState.dimmed => (border: QyicColors.border, fill: QyicColors.surface),
};

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.letter,
    required this.option,
    required this.state,
    required this.onTap,
  });

  final String letter;
  final QuizOption option;
  final _TileState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = _tileColors(state);
    final trailing = switch (state) {
      _TileState.correct => Icons.check_rounded,
      _TileState.wrong => Icons.close_rounded,
      _ => null,
    };
    return Opacity(
      opacity: state == _TileState.dimmed ? 0.6 : 1,
      child: Material(
        color: colors.fill,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.border, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: QyicColors.border),
                  ),
                  child: Text(
                    letter,
                    style: const TextStyle(color: QyicColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (trailing != null)
                  Icon(trailing, color: QyicColors.textPrimary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrueFalseTile extends StatelessWidget {
  const _TrueFalseTile({
    required this.option,
    required this.label,
    required this.state,
    required this.accent,
    required this.onTap,
  });

  final QuizOption option;
  final String label;
  final _TileState state;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = _tileColors(state);
    return Opacity(
      opacity: state == _TileState.dimmed ? 0.6 : 1,
      child: Material(
        color: state == _TileState.idle ? QyicColors.surface : colors.fill,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: state == _TileState.idle ? accent : colors.border,
            width: 2,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 140,
            child: Center(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: accent,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
