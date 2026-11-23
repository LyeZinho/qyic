import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../application/reminder_sync.dart';
import '../data/reminder_repository.dart';
import '../domain/reminder.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> {
  bool _permissionDenied = false;

  ReminderRepository get _repository => ref.read(reminderRepositoryProvider);

  /// Asks for notification permission before a reminder becomes active.
  Future<void> _ensurePermission() async {
    final scheduler = ref.read(reminderSchedulerProvider);
    if (!scheduler.isSupported) return;
    final granted = await scheduler.requestPermission();
    if (mounted) setState(() => _permissionDenied = !granted);
  }

  Future<TimeOfDay?> _pickTime(int minuteOfDay) => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: minuteOfDay ~/ 60, minute: minuteOfDay % 60),
  );

  Future<void> _add() async {
    final time = await _pickTime(19 * 60);
    if (time == null) return;
    await _repository.add(
      Reminder(
        minuteOfDay: time.hour * 60 + time.minute,
        weekdays: Reminder.everyDay,
      ),
    );
    await _ensurePermission();
  }

  Future<void> _update(Reminder reminder) async {
    await _repository.update(reminder);
    if (reminder.isActive) await _ensurePermission();
  }

  Future<void> _editTime(Reminder reminder) async {
    final time = await _pickTime(reminder.minuteOfDay);
    if (time == null) return;
    await _update(reminder.copyWith(minuteOfDay: time.hour * 60 + time.minute));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final reminders = ref.watch(remindersProvider);
    final supported = ref.watch(reminderSchedulerProvider).isSupported;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.remindersTitle)),
      body: QyicContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            Text(l10n.remindersIntro, style: textTheme.bodyMedium),
            if (!supported) ...[
              const SizedBox(height: 16),
              _Notice(text: l10n.remindersUnsupported),
            ] else if (_permissionDenied) ...[
              const SizedBox(height: 16),
              _Notice(text: l10n.remindersPermissionDenied),
            ],
            const SizedBox(height: 16),
            QyicAsyncView(
              value: reminders,
              data: (list) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (list.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        l10n.remindersEmpty,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  for (final reminder in list)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ReminderCard(
                        reminder: reminder,
                        onEditTime: () => _editTime(reminder),
                        onChanged: _update,
                        onDelete: () => _repository.delete(reminder.id!),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            QyicPrimaryButton(
              label: l10n.remindersAdd,
              icon: Icons.add_alarm_rounded,
              onPressed: _add,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({
    required this.reminder,
    required this.onEditTime,
    required this.onChanged,
    required this.onDelete,
  });

  final Reminder reminder;
  final VoidCallback onEditTime;
  final ValueChanged<Reminder> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // Weekday chips follow the locale's first day of the week.
    final firstDay = MaterialLocalizations.of(context).firstDayOfWeekIndex == 0
        ? DateTime.sunday
        : DateTime.monday;
    final days = [for (var i = 0; i < 7; i++) (firstDay - 1 + i) % 7 + 1];

    return Opacity(
      opacity: reminder.enabled ? 1 : 0.6,
      child: QyicPanel(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: onEditTime,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      formatMinuteOfDay(l10n, reminder.minuteOfDay),
                      style: QyicTextStyles.mono(
                        context,
                        size: 30,
                        color: QyicColors.textPrimary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Switch(
                  value: reminder.enabled,
                  onChanged: (value) =>
                      onChanged(reminder.copyWith(enabled: value)),
                ),
                IconButton(
                  tooltip: l10n.actionDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final day in days)
                  FilterChip(
                    label: Text(formatWeekday(l10n, day)),
                    selected: reminder.weekdays.contains(day),
                    visualDensity: VisualDensity.compact,
                    onSelected: (selected) => onChanged(
                      reminder.copyWith(
                        weekdays: selected
                            ? {...reminder.weekdays, day}
                            : ({...reminder.weekdays}..remove(day)),
                      ),
                    ),
                  ),
              ],
            ),
            if (reminder.weekdays.isEmpty) ...[
              const SizedBox(height: 8),
              Text(
                l10n.remindersNoDays,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: QyicColors.orange),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return QyicPanel(
      borderColor: QyicColors.orange,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: QyicColors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

/// Short status for the Me screen: off, the single active time, or a count.
String reminderSummary(AppLocalizations l10n, List<Reminder> reminders) {
  final active = reminders.where((r) => r.isActive).toList();
  if (active.isEmpty) return l10n.remindersOff;
  if (active.length > 1) return l10n.remindersActiveCount(active.length);
  return formatMinuteOfDay(l10n, active.single.minuteOfDay);
}
