import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/formatting.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../data/exam_repository.dart';
import '../domain/exam.dart';
import 'exam_format.dart';
import 'exam_preset_editor_screen.dart';
import 'exam_session_screen.dart';

/// Exam mode ("intense study"): quick exams, saved presets, recent results.
class ExamHubScreen extends ConsumerWidget {
  const ExamHubScreen({super.key, this.deckId});

  /// Scopes the quick exam and new presets to one deck.
  final String? deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final presets = ref.watch(examPresetsProvider);
    final runs = ref.watch(recentExamRunsProvider);
    final scope = {?deckId};

    return Scaffold(
      appBar: AppBar(title: Text(l10n.examTitle)),
      body: QyicContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            Text(l10n.examIntro, style: textTheme.bodyMedium),
            const SizedBox(height: 16),
            _QuickExamCard(
              preset: ExamPreset(name: l10n.examQuickName, deckIds: scope),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: QyicSectionLabel(l10n.examPresets)),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ExamPresetEditorScreen(
                        preset: ExamPreset(name: '', deckIds: scope),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(l10n.examNewPreset),
                ),
              ],
            ),
            const SizedBox(height: 8),
            QyicAsyncView(
              value: presets,
              data: (list) => list.isEmpty
                  ? Text(l10n.examNoPresets, style: textTheme.bodyMedium)
                  : Column(
                      children: [
                        for (final preset in list)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _PresetTile(preset: preset),
                          ),
                      ],
                    ),
            ),
            const SizedBox(height: 24),
            QyicSectionLabel(l10n.examRecent),
            const SizedBox(height: 8),
            QyicAsyncView(
              value: runs,
              data: (list) => list.isEmpty
                  ? Text(l10n.examNoRuns, style: textTheme.bodyMedium)
                  : QyicPanel(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        children: [
                          for (final (index, run) in list.indexed) ...[
                            if (index > 0) const Divider(indent: 16),
                            _RunRow(run: run),
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void _startExam(BuildContext context, ExamPreset preset) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => ExamSessionScreen(preset: preset)),
  );
}

class _QuickExamCard extends StatelessWidget {
  const _QuickExamCard({required this.preset});

  final ExamPreset preset;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return QyicPanel(
      borderColor: QyicColors.lime.withValues(alpha: 0.6),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt_rounded, color: QyicColors.lime),
              const SizedBox(width: 8),
              Text(preset.name, style: textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 6),
          Text(examPresetSummary(l10n, preset), style: textTheme.bodyMedium),
          const SizedBox(height: 14),
          QyicPrimaryButton(
            label: l10n.examStart,
            icon: Icons.play_arrow_rounded,
            onPressed: () => _startExam(context, preset),
          ),
        ],
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({required this.preset});

  final ExamPreset preset;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return QyicPanel(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ExamPresetEditorScreen(preset: preset),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(preset.name, style: textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  examPresetSummary(l10n, preset),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.examStart,
            color: QyicColors.lime,
            icon: const Icon(Icons.play_circle_fill_rounded, size: 32),
            onPressed: () => _startExam(context, preset),
          ),
        ],
      ),
    );
  }
}

class _RunRow extends StatelessWidget {
  const _RunRow({required this.run});

  final ExamRun run;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final color = scoreColor(run.score);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              formatPercent(l10n, run.score),
              style: QyicTextStyles.mono(
                context,
                size: 18,
                color: color,
                weight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(run.name, style: textTheme.titleMedium),
                Text(
                  [
                    DateFormat.MMMd(l10n.localeName)
                        .add_jm()
                        .format(run.startedAt.toLocal()),
                    l10n.examCorrectOf(run.correctCount, run.questionCount),
                    if (run.endReason != ExamEndReason.completed)
                      run.endReason.label(l10n),
                  ].join(' · '),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
