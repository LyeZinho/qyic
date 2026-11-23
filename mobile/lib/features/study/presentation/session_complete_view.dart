import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../progress/data/progress_repository.dart';
import '../application/study_session_controller.dart';

class SessionCompleteView extends ConsumerWidget {
  const SessionCompleteView({super.key, required this.session});

  final StudySessionState session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final progress = ref.watch(progressProvider).value;
    final textTheme = Theme.of(context).textTheme;
    final elapsed = session.finishedAt!.difference(session.startedAt);
    final count = session.completed;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: QyicPill(l10n.sessionComplete, color: QyicColors.lime),
          ),
          const SizedBox(height: 16),
          Text(
            '${l10n.sessionCards(count)}\n'
            '${session.accuracy >= 0.8 ? l10n.sessionNiceRun : l10n.sessionKeepGoing}',
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Stat(
                value: formatPercent(l10n, session.accuracy),
                label: l10n.statAccuracy,
                color: QyicColors.teal,
              ),
              const SizedBox(width: 12),
              _Stat(
                value: '+${session.xpEarned}',
                label: l10n.statXpEarned,
                color: QyicColors.lime,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _Stat(
                value: '${progress?.streakDays ?? '–'}',
                label: l10n.statDayStreak,
                color: QyicColors.orange,
              ),
              const SizedBox(width: 12),
              _Stat(
                value: formatElapsed(elapsed),
                label: l10n.statTime,
                color: QyicColors.textPrimary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (progress != null)
            QyicPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QyicSectionLabel(
                    progress.level.level > session.levelBefore
                        ? l10n.levelUnlocked(progress.level.level)
                        : l10n.levelProgress(
                            progress.level.level,
                            progress.level.xpIntoLevel,
                            progress.level.xpForLevel,
                          ),
                  ),
                  const SizedBox(height: 12),
                  QyicProgressBar(value: progress.level.fraction, height: 10),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: QyicPill(
              l10n.sessionEventsSaved(count),
              color: QyicColors.teal,
              icon: Icons.check_rounded,
            ),
          ),
          const Spacer(flex: 2),
          QyicPrimaryButton(
            label: l10n.actionBackHome,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QyicPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: QyicTextStyles.mono(
                context,
                size: 26,
                color: color,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
