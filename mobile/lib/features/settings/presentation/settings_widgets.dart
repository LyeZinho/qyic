import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../settings_repository.dart';

/// A tappable settings row with a monospace value, as in the mockups.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.label,
    this.value,
    this.icon,
    this.onTap,
  });

  final String label;
  final String? value;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: QyicPanel(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: QyicColors.textSecondary),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (value != null)
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: QyicTextStyles.mono(context),
                ),
              ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right_rounded,
                color: QyicColors.textMuted,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A settings switch in the same visual language as [SettingsRow].
class SettingsSwitch extends StatelessWidget {
  const SettingsSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.description,
  });

  final String label;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: QyicPanel(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        onTap: () => onChanged(!value),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: textTheme.titleMedium),
                  if (description != null)
                    Text(description!, style: textTheme.bodySmall),
                ],
              ),
            ),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

/// Editors for the numeric study settings, shared by Me and Preferences.
abstract final class SettingPickers {
  static Future<void> dailyGoal(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final l10n = context.l10n;
    final range = AppSettings.dailyGoalRange;
    final value = await _pickNumber(
      context,
      title: l10n.prefDailyGoal,
      description: l10n.prefDailyGoalDetail,
      initial: settings.dailyGoal.toDouble(),
      min: range.min.toDouble(),
      max: range.max.toDouble(),
      divisions: (range.max - range.min) ~/ 5,
      format: (v) => l10n.cardCount(v.round()),
    );
    if (value != null) {
      await ref.read(settingsRepositoryProvider).setDailyGoal(value.round());
    }
  }

  static Future<void> newCardsPerDay(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final l10n = context.l10n;
    final range = AppSettings.newCardsPerDayRange;
    final value = await _pickNumber(
      context,
      title: l10n.prefNewCards,
      description: l10n.prefNewCardsDetail,
      initial: settings.newCardsPerDay.toDouble(),
      min: range.min.toDouble(),
      max: range.max.toDouble(),
      divisions: range.max - range.min,
      format: (v) => '${v.round()}',
    );
    if (value != null) {
      await ref
          .read(settingsRepositoryProvider)
          .setNewCardsPerDay(value.round());
    }
  }

  static Future<void> desiredRetention(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final l10n = context.l10n;
    final range = AppSettings.desiredRetentionRange;
    final value = await _pickNumber(
      context,
      title: l10n.prefRetention,
      description: l10n.prefRetentionDetail,
      initial: settings.desiredRetention,
      min: range.min,
      max: range.max,
      divisions: ((range.max - range.min) * 100).round(),
      format: (v) => formatPercent(l10n, v),
    );
    if (value != null) {
      await ref
          .read(settingsRepositoryProvider)
          .setDesiredRetention((value * 100).round() / 100);
    }
  }

  static Future<double?> _pickNumber(
    BuildContext context, {
    required String title,
    required double initial,
    required double min,
    required double max,
    required int divisions,
    required String Function(double value) format,
    String? description,
  }) {
    final l10n = context.l10n;
    var value = initial.clamp(min, max);
    return showDialog<double>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (description != null) ...[
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
              ],
              Center(
                child: Text(
                  format(value),
                  style: QyicTextStyles.mono(
                    context,
                    size: 28,
                    color: QyicColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: format(value),
                onChanged: (next) => setState(() => value = next),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(value),
              child: Text(l10n.actionSave),
            ),
          ],
        ),
      ),
    );
  }
}
