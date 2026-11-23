import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/qyic_colors.dart';
import '../../core/theme/qyic_theme.dart';
import '../../core/widgets/qyic_primary_button.dart';
import '../../core/widgets/qyic_shared_widgets.dart';
import '../../l10n/l10n.dart';
import '../decks/data/deck_repository.dart';
import '../decks/presentation/deck_detail_screen.dart';
import '../decks/presentation/deck_providers.dart';
import '../exam/presentation/exam_hub_screen.dart';
import '../progress/data/progress_repository.dart';
import '../settings/settings_repository.dart';
import '../study/domain/study_scope.dart';
import '../study/presentation/study_session_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// Fallback pace for the queue estimate before there is review history.
  static const _defaultSecondsPerCard = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final progress = ref.watch(progressProvider).value;
    final settings = ref.watch(settingsProvider).value;
    final counts = ref.watch(studyCountsProvider(const StudyRequest())).value;
    final decks = ref.watch(deckSummariesProvider);
    final textTheme = Theme.of(context).textTheme;
    final hour =
        (ref.watch(minuteTickProvider).value ?? ref.read(clockProvider)()).hour;

    final queueSize = counts?.total ?? 0;
    final decksToStudy =
        decks.value
            ?.where((summary) => summary.dueCount + summary.newCount > 0)
            .length ??
        0;
    final secondsPerCard =
        progress?.averageReviewDuration?.inSeconds ?? _defaultSecondsPerCard;
    final minutes = (queueSize * secondsPerCard / 60).ceil();

    return SafeArea(
      child: QyicContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(switch (hour) {
                        < 5 => l10n.greetingEvening,
                        < 12 => l10n.greetingMorning,
                        < 18 => l10n.greetingAfternoon,
                        _ => l10n.greetingEvening,
                      }, style: textTheme.bodyMedium),
                      const SizedBox(height: 4),
                      Text(l10n.homeReady, style: textTheme.headlineLarge),
                    ],
                  ),
                ),
                QyicPill(
                  '${progress?.streakDays ?? 0}',
                  color: QyicColors.orange,
                  icon: Icons.local_fire_department_rounded,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: QyicPill(
                l10n.homeSavedOnDevice,
                color: QyicColors.success,
                icon: Icons.check_circle_outline,
              ),
            ),
            const SizedBox(height: 20),
            QyicPanel(
              borderColor: QyicColors.purple,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QyicSectionLabel(l10n.homeTodaysQueue),
                  const SizedBox(height: 8),
                  Text(
                    l10n.cardCount(queueSize),
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    queueSize == 0
                        ? l10n.homeAllCaughtUp
                        : l10n.homeQueueEstimate(minutes, decksToStudy),
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  QyicPrimaryButton(
                    label: l10n.homeStartReview,
                    icon: Icons.bolt_rounded,
                    onPressed: queueSize == 0
                        ? null
                        : () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const StudySessionScreen(),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            QyicPanel(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ExamHubScreen()),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, color: QyicColors.coral),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.examTitle, style: textTheme.titleMedium),
                        Text(l10n.homeExamTeaser, style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: QyicColors.textMuted,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: l10n.levelShort(progress?.level.level ?? 1),
                    subtitle: progress == null
                        ? ''
                        : l10n.xpProgress(
                            progress.level.xpIntoLevel,
                            progress.level.xpForLevel,
                          ),
                    value: progress?.level.fraction ?? 0,
                    color: QyicColors.lime,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title:
                        '${progress?.reviewsToday ?? 0}/'
                        '${settings?.dailyGoal ?? const AppSettings().dailyGoal}',
                    subtitle: l10n.prefDailyGoal,
                    value: settings == null || progress == null
                        ? 0
                        : progress.reviewsToday / settings.dailyGoal,
                    color: QyicColors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            QyicSectionLabel(l10n.homeYourDecks),
            const SizedBox(height: 12),
            QyicAsyncView(
              value: decks,
              data: (summaries) => Column(
                children: [
                  for (final summary in summaries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _HomeDeckTile(summary: summary),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  final String title;
  final String subtitle;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return QyicPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: QyicTextStyles.mono(
              context,
              size: 16,
              color: color,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          QyicProgressBar(value: value, color: color),
          const SizedBox(height: 8),
          Text(subtitle, style: textTheme.bodyMedium?.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}

class _HomeDeckTile extends StatelessWidget {
  const _HomeDeckTile({required this.summary});

  final DeckSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pending = summary.dueCount + summary.newCount;
    return QyicPanel(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DeckDetailScreen(deckId: summary.deck.id),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  summary.deck.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (summary.dueCount > 0)
                QyicPill(
                  l10n.deckDueCount(summary.dueCount),
                  color: QyicColors.orange,
                )
              else if (summary.newCount > 0)
                QyicPill(
                  l10n.deckNewCount(summary.newCount),
                  color: QyicColors.purple,
                )
              else if (pending == 0 && summary.quizCount > 0)
                QyicPill(l10n.deckDone, color: QyicColors.success),
            ],
          ),
          const SizedBox(height: 12),
          QyicProgressBar(value: summary.learnedFraction),
        ],
      ),
    );
  }
}
