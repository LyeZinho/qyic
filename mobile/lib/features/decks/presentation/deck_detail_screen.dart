import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../../exam/domain/exam.dart';
import '../../exam/presentation/exam_hub_screen.dart';
import '../../exam/presentation/exam_session_screen.dart';
import '../../study/domain/study_scope.dart';
import '../../study/presentation/study_session_screen.dart';
import '../data/deck_repository.dart';
import '../domain/deck.dart';
import 'deck_cards_screen.dart';
import 'deck_editor_dialog.dart';
import 'deck_providers.dart';

enum _DeckAction { edit, delete }

class DeckDetailScreen extends ConsumerWidget {
  const DeckDetailScreen({super.key, required this.deckId});

  final String deckId;

  Future<void> _onAction(
    BuildContext context,
    WidgetRef ref,
    _DeckAction action,
    Deck deck,
  ) async {
    final l10n = context.l10n;
    final repository = ref.read(deckRepositoryProvider);
    switch (action) {
      case _DeckAction.edit:
        final fields = await showDeckEditorDialog(
          context,
          initial: (title: deck.title, description: deck.description),
        );
        if (fields == null) return;
        await repository.updateDeck(
          deck.id,
          title: fields.title,
          description: fields.description,
        );
      case _DeckAction.delete:
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(l10n.deckDeleteTitle(deck.title)),
            content: Text(l10n.deckDeleteBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.actionCancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: QyicColors.coral,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.actionDelete),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
        await repository.deleteDeck(deck.id);
        if (context.mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref.watch(deckProvider(deckId));
    final stats = ref.watch(deckStatsProvider(deckId));
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (deck.value != null)
            IconButton(
              tooltip: l10n.examTitle,
              icon: const Icon(Icons.timer_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ExamHubScreen(deckId: deckId),
                ),
              ),
            ),
          if (deck.value case final current?)
            PopupMenuButton<_DeckAction>(
              onSelected: (action) => _onAction(context, ref, action, current),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: _DeckAction.edit,
                  child: Text(l10n.actionEdit),
                ),
                PopupMenuItem(
                  value: _DeckAction.delete,
                  child: Text(l10n.actionDelete),
                ),
              ],
            ),
        ],
      ),
      body: QyicAsyncView(
        value: deck,
        data: (current) {
          if (current == null) {
            return Center(child: Text(l10n.deckGone));
          }
          return _DeckStudy(deckId: deckId, deck: current, stats: stats.value);
        },
      ),
    );
  }
}

/// Study-mode picker for one deck. Card editing lives on [DeckCardsScreen].
class _DeckStudy extends ConsumerStatefulWidget {
  const _DeckStudy({
    required this.deckId,
    required this.deck,
    required this.stats,
  });

  final String deckId;
  final Deck deck;
  final DeckStats? stats;

  @override
  ConsumerState<_DeckStudy> createState() => _DeckStudyState();
}

class _DeckStudyState extends ConsumerState<_DeckStudy> {
  /// Null selects the deck exam; otherwise a normal study scope.
  StudyScope? _scope = StudyScope.mixed;

  StudyRequest get _request =>
      StudyRequest(deckId: widget.deckId, scope: _scope ?? StudyScope.mixed);

  void _start() {
    final scope = _scope;
    final quizCount = widget.stats?.summary.quizCount ?? 0;
    if (scope == null) {
      if (quizCount <= 0) return;
      final count = deckExamQuestionCount(quizCount, math.Random());
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ExamSessionScreen(
            preset: ExamPreset(
              name: context.l10n.deckModeExam,
              deckIds: {widget.deckId},
              selection: ExamSelection.random,
              questionCount: count,
              timeLimit: null,
              timePerQuestion: null,
              quizTypes: QuizType.values.toSet(),
              includeNew: true,
            ),
          ),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudySessionScreen(request: _request),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final quizCount = widget.stats?.summary.quizCount ?? 0;
    final counts = ref.watch(studyCountsProvider(_request)).value;
    final examDetail = quizCount > deckExamFullDraw
        ? l10n.deckModeExamDetailLarge(quizCount)
        : l10n.deckModeExamDetailSmall(
            quizCount == 0
                ? 0
                : deckExamQuestionCount(quizCount, math.Random(0)),
          );
    final canStart = _scope == null ? quizCount > 0 : (counts?.total ?? 0) > 0;

    return Column(
      children: [
        Expanded(
          child: QyicContentWidth(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                _Header(deck: widget.deck, stats: widget.stats),
                const SizedBox(height: 20),
                if (widget.stats case final deckStats?) ...[
                  _Metrics(stats: deckStats),
                  const SizedBox(height: 24),
                  _QuizTypes(stats: deckStats),
                  const SizedBox(height: 8),
                ],
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => DeckCardsScreen(deckId: widget.deckId),
                      ),
                    ),
                    icon: const Icon(Icons.style_outlined, size: 18),
                    label: Text(l10n.deckManageCards),
                  ),
                ),
                const SizedBox(height: 8),
                _ModeButton(
                  label: l10n.deckModeMixed,
                  detail: l10n.deckModeMixedDetail,
                  selected: _scope == StudyScope.mixed,
                  onTap: () => setState(() => _scope = StudyScope.mixed),
                ),
                _ModeButton(
                  label: l10n.deckModeQuizzes,
                  detail: l10n.deckModeQuizzesDetail,
                  selected: _scope == StudyScope.quizzes,
                  onTap: () => setState(() => _scope = StudyScope.quizzes),
                ),
                _ModeButton(
                  label: l10n.deckModeFlashcards,
                  detail: l10n.deckModeFlashcardsDetail,
                  selected: _scope == StudyScope.flashcards,
                  onTap: () => setState(() => _scope = StudyScope.flashcards),
                ),
                _ModeButton(
                  label: l10n.deckModeExam,
                  detail: examDetail,
                  selected: _scope == null,
                  onTap: () => setState(() => _scope = null),
                ),
                const SizedBox(height: 16),
                QyicPanel(
                  child: Text(
                    l10n.deckSyncNote,
                    style: const TextStyle(color: QyicColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: QyicPrimaryButton(
              label: _scope == null
                  ? l10n.deckExamStart
                  : switch (counts?.total) {
                      null => l10n.deckStudy,
                      0 => l10n.deckNothingToStudy,
                      final n => l10n.deckStudyCards(n),
                    },
              onPressed: canStart ? _start : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.label,
    required this.detail,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String detail;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: QyicPanel(
        onTap: onTap,
        borderColor: selected ? QyicColors.lime : QyicColors.border,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected ? QyicColors.lime : QyicColors.textMuted,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(detail, style: textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.deck, required this.stats});

  final Deck deck;
  final DeckStats? stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final quizCount = stats?.summary.quizCount;
    final meta = [
      if (deck.author.isNotEmpty) l10n.deckBy(deck.author),
      if (quizCount != null) l10n.quizCount(quizCount),
      'v${deck.version}',
    ].join(' · ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(deck.title, style: textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(meta, style: textTheme.bodyMedium),
        if (deck.description.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(deck.description, style: textTheme.bodyMedium),
        ],
      ],
    );
  }
}

class _Metrics extends StatelessWidget {
  const _Metrics({required this.stats});

  final DeckStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final retention = stats.retention;
    return Row(
      children: [
        _MetricTile(
          label: l10n.deckMetricDue,
          value: '${stats.summary.dueCount}',
          color: QyicColors.orange,
        ),
        const SizedBox(width: 10),
        _MetricTile(
          label: l10n.deckMetricRetention,
          value: retention == null ? '–' : formatPercent(l10n, retention),
          color: QyicColors.teal,
        ),
        const SizedBox(width: 10),
        _MetricTile(
          label: l10n.deckMetricMature,
          value: formatPercent(l10n, stats.matureFraction),
          color: QyicColors.lime,
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QyicPanel(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          children: [
            Text(
              value,
              style: QyicTextStyles.mono(
                context,
                size: 22,
                color: color,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizTypes extends StatelessWidget {
  const _QuizTypes({required this.stats});

  final DeckStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final total = stats.summary.quizCount;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QyicSectionLabel(l10n.deckQuizTypes),
        const SizedBox(height: 12),
        for (final type in QuizType.values)
          if (stats.typeCounts[type] case final count?)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          type.label(l10n),
                          style: textTheme.titleMedium,
                        ),
                      ),
                      Text('$count', style: QyicTextStyles.mono(context)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  QyicProgressBar(
                    value: total == 0 ? 0 : count / total,
                    color: QyicColors.purple,
                    height: 6,
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
