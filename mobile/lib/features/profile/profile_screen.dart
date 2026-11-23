import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/formatting.dart';
import '../../core/theme/qyic_colors.dart';
import '../../core/theme/qyic_theme.dart';
import '../../core/widgets/qyic_shared_widgets.dart';
import '../../l10n/l10n.dart';
import '../exam/presentation/exam_hub_screen.dart';
import '../progress/data/progress_repository.dart';
import '../reminders/data/reminder_repository.dart';
import '../reminders/presentation/reminders_screen.dart';
import '../settings/presentation/preferences_screen.dart';
import '../settings/presentation/settings_widgets.dart';
import '../settings/settings_repository.dart';
import '../settings/storage_usage.dart';

/// "Me": profile summary, sync status, and the most used settings.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final progress = ref.watch(progressProvider).value;
    final settings = ref.watch(settingsProvider).value;
    final reminders = ref.watch(remindersProvider).value ?? const [];
    final storage = ref.watch(storageUsedProvider).value;
    final textTheme = Theme.of(context).textTheme;
    final events = progress?.totalReviews ?? 0;
    final name = settings?.displayName ?? l10n.meDefaultName;

    void open(Widget screen) => Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => screen));

    return SafeArea(
      child: QyicContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: QyicColors.purpleMuted,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    name.characters.first.toUpperCase(),
                    style: textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: textTheme.titleLarge),
                      if (progress != null)
                        Text(
                          l10n.meSummary(
                            progress.level.level,
                            progress.streakDays,
                          ),
                          style: textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.prefTitle,
                  icon: const Icon(Icons.tune_rounded),
                  onPressed: () => open(const PreferencesScreen()),
                ),
              ],
            ),
            const SizedBox(height: 20),
            QyicPanel(
              borderColor: QyicColors.orange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.cloud_off_rounded,
                        color: QyicColors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.meSyncOff,
                          style: textTheme.titleMedium?.copyWith(
                            color: QyicColors.orange,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: QyicColors.orange),
                        ),
                        child: Text(
                          l10n.meEventsOnDevice(events),
                          style: QyicTextStyles.mono(
                            context,
                            size: 11,
                            color: QyicColors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(l10n.meSyncBody, style: textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 24),
            QyicSectionLabel(l10n.meSettings),
            const SizedBox(height: 10),
            if (settings != null) ...[
              SettingsRow(
                label: l10n.prefDailyGoal,
                value: l10n.cardCount(settings.dailyGoal),
                onTap: () => SettingPickers.dailyGoal(context, ref, settings),
              ),
              SettingsRow(
                label: l10n.prefRetention,
                value: formatPercent(l10n, settings.desiredRetention),
                onTap: () =>
                    SettingPickers.desiredRetention(context, ref, settings),
              ),
            ],
            SettingsRow(
              label: l10n.prefStorage,
              value: storage == null ? '–' : formatBytes(l10n, storage),
            ),
            SettingsRow(
              label: l10n.remindersTitle,
              value: reminderSummary(l10n, reminders),
              onTap: () => open(const RemindersScreen()),
            ),
            const SizedBox(height: 16),
            QyicSectionLabel(l10n.meMore),
            const SizedBox(height: 10),
            SettingsRow(
              icon: Icons.timer_outlined,
              label: l10n.examTitle,
              onTap: () => open(const ExamHubScreen()),
            ),
            SettingsRow(
              icon: Icons.tune_rounded,
              label: l10n.prefTitle,
              onTap: () => open(const PreferencesScreen()),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: null,
              child: Text(l10n.meSyncUnavailable),
            ),
          ],
        ),
      ),
    );
  }
}
