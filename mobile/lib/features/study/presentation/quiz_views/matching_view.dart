import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/qyic_colors.dart';
import '../../../../core/widgets/qyic_primary_button.dart';
import '../../../../l10n/l10n.dart';
import '../../../decks/domain/deck.dart';
import '../../domain/grading.dart';
import '../widgets/answer_feedback.dart';

/// Tap a term, then its match. Pairs can be undone by tapping either side
/// until they are checked.
class MatchingView extends StatefulWidget {
  const MatchingView({
    super.key,
    required this.quiz,
    required this.onGraded,
    this.enabled = true,
  });

  final Quiz quiz;
  final ValueChanged<GradeOutcome> onGraded;
  final bool enabled;

  @override
  State<MatchingView> createState() => _MatchingViewState();
}

class _MatchingViewState extends State<MatchingView> {
  static const _pairColors = [
    QyicColors.purple,
    QyicColors.orange,
    QyicColors.teal,
    QyicColors.lime,
    QyicColors.coral,
    Color(0xFF5DB4F0),
  ];

  late final List<QuizOption> _terms;
  late final List<QuizOption> _matches;

  /// Term option id → match option id, in the order pairs were made.
  final _pairs = <String, String>{};
  String? _selectedTermId;
  GradeOutcome? _outcome;

  @override
  void initState() {
    super.initState();
    _terms = [...widget.quiz.options]..shuffle();
    _matches = [...widget.quiz.options]..shuffle();
  }

  bool get _open => widget.enabled && _outcome == null;

  void _tapTerm(QuizOption term) {
    if (!_open) return;
    setState(() {
      if (_pairs.remove(term.id) != null) {
        _selectedTermId = term.id;
      } else {
        _selectedTermId = _selectedTermId == term.id ? null : term.id;
      }
    });
  }

  void _tapMatch(QuizOption match) {
    if (!_open) return;
    setState(() {
      _pairs.removeWhere((_, matchId) => matchId == match.id);
      final selected = _selectedTermId;
      if (selected != null) {
        _pairs[selected] = match.id;
        _selectedTermId = null;
      }
    });
  }

  void _check() {
    if (!_open) return;
    final outcome = grade(widget.quiz, MatchingAnswer(Map.of(_pairs)));
    setState(() => _outcome = outcome);
    widget.onGraded(outcome);
  }

  Color? _pairColor(String termId) {
    final index = _pairs.keys.toList().indexOf(termId);
    return index < 0 ? null : _pairColors[index % _pairColors.length];
  }

  _Look _termLook(QuizOption term) {
    if (_outcome != null) return _resultLook(term.id, _pairs[term.id]);
    if (term.id == _selectedTermId) return const _Look.selected();
    final color = _pairColor(term.id);
    return color == null ? const _Look.idle() : _Look.paired(color);
  }

  _Look _matchLook(QuizOption match) {
    final termId = _pairs.entries
        .where((pair) => pair.value == match.id)
        .map((pair) => pair.key)
        .firstOrNull;
    if (_outcome != null) return _resultLook(termId, match.id);
    if (termId == null) return const _Look.idle();
    return _Look.paired(_pairColor(termId)!);
  }

  _Look _resultLook(String? termId, String? matchId) =>
      termId != null && termId == matchId
      ? const _Look(QyicColors.success, QyicColors.successSurface)
      : const _Look(QyicColors.failure, QyicColors.failureSurface);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final remaining = _terms.length - _pairs.length;
    final outcome = _outcome;
    final wrongPairs = widget.quiz.options
        .where((option) => _pairs[option.id] != option.id)
        .map((option) => '${option.prompt} → ${option.text}');

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            children: [
              Text(widget.quiz.question, style: textTheme.headlineMedium),
              QuizHintLine(widget.quiz.hint),
              const SizedBox(height: 16),
              for (var row = 0; row < _terms.length; row++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _MatchTile(
                            label: _terms[row].prompt,
                            look: _termLook(_terms[row]),
                            onTap: () => _tapTerm(_terms[row]),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MatchTile(
                            label: _matches[row].text,
                            look: _matchLook(_matches[row]),
                            onTap: () => _tapMatch(_matches[row]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              if (outcome == null)
                Text(
                  remaining == 0
                      ? l10n.matchingAllSet
                      : l10n.matchingInstructions(remaining, _terms.length),
                  style: textTheme.bodyMedium,
                )
              else
                AnswerFeedback(
                  correct: outcome == GradeOutcome.correct,
                  explanation: widget.quiz.explanation,
                  detail: outcome == GradeOutcome.correct
                      ? null
                      : l10n.matchingCorrectPairs(wrongPairs.join('; ')),
                ),
            ],
          ),
        ),
        if (_open)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: QyicPrimaryButton(
              label: l10n.matchingCheck,
              onPressed: remaining == 0 ? _check : null,
            ),
          ),
      ],
    );
  }
}

class _Look {
  const _Look(this.border, this.fill);

  const _Look.idle() : border = QyicColors.border, fill = QyicColors.surface;

  const _Look.selected()
    : border = QyicColors.purple,
      fill = QyicColors.surfaceElevated;

  _Look.paired(Color color)
    : border = color,
      fill = Color.alphaBlend(
        color.withValues(alpha: 0.16),
        QyicColors.surface,
      );

  final Color border;
  final Color fill;
}

class _MatchTile extends StatelessWidget {
  const _MatchTile({
    required this.label,
    required this.look,
    required this.onTap,
  });

  final String label;
  final _Look look;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: look.fill,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: look.border, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
