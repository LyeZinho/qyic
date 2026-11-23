import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../decks/presentation/import_deck_flow.dart';
import '../../reminders/data/reminder_repository.dart';
import '../../reminders/presentation/reminders_screen.dart';
import '../settings_repository.dart';
import '../storage_usage.dart';
import 'settings_widgets.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final reminders = ref.watch(remindersProvider).value ?? const [];
    final storage = ref.watch(storageUsedProvider).value;
    final repository = ref.read(settingsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.prefTitle)),
      body: QyicContentWidth(
        child: QyicAsyncView(
          value: settings,
          data: (settings) => ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
            children: [
              _Header(l10n.prefSectionGeneral),
              SettingsRow(
                icon: Icons.translate_rounded,
                label: l10n.prefLanguage,
                value: appLanguages[settings.languageTag] ?? l10n.prefSystem,
                onTap: () => _pickLanguage(context, ref, settings.languageTag),
              ),
              SettingsRow(
                icon: Icons.badge_outlined,
                label: l10n.prefName,
                value: settings.displayName ?? l10n.meDefaultName,
                onTap: () => _editName(context, ref, settings.displayName),
              ),
              _Header(l10n.prefSectionStudy),
              SettingsRow(
                label: l10n.prefDailyGoal,
                value: l10n.cardCount(settings.dailyGoal),
                onTap: () => SettingPickers.dailyGoal(context, ref, settings),
              ),
              SettingsRow(
                label: l10n.prefNewCards,
                value: '${settings.newCardsPerDay}',
                onTap: () =>
                    SettingPickers.newCardsPerDay(context, ref, settings),
              ),
              SettingsRow(
                label: l10n.prefRetention,
                value: formatPercent(l10n, settings.desiredRetention),
                onTap: () =>
                    SettingPickers.desiredRetention(context, ref, settings),
              ),
              SettingsSwitch(
                label: l10n.prefIntervals,
                description: l10n.prefIntervalsDetail,
                value: settings.showIntervalPreviews,
                onChanged: repository.setShowIntervalPreviews,
              ),
              SettingsSwitch(
                label: l10n.prefHaptics,
                description: l10n.prefHapticsDetail,
                value: settings.hapticFeedback,
                onChanged: repository.setHapticFeedback,
              ),
              _Header(l10n.prefSectionNotifications),
              SettingsRow(
                icon: Icons.alarm_rounded,
                label: l10n.remindersTitle,
                value: reminderSummary(l10n, reminders),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const RemindersScreen(),
                  ),
                ),
              ),
              _Header(l10n.prefSectionData),
              SettingsRow(
                icon: Icons.file_open_outlined,
                label: l10n.importAction,
                onTap: () => importDeckFromFile(context, ref),
              ),
              SettingsRow(
                icon: Icons.storage_rounded,
                label: l10n.prefStorage,
                value: storage == null ? '–' : formatBytes(l10n, storage),
              ),
              _Header(l10n.prefSectionAbout),
              SettingsRow(
                icon: Icons.description_outlined,
                label: l10n.prefLicenses,
                onTap: () =>
                    showLicensePage(context: context, applicationName: 'Qyic'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickLanguage(
    BuildContext context,
    WidgetRef ref,
    String? current,
  ) async {
    final l10n = context.l10n;
    // A record wraps the choice so "system" (null) differs from dismissal.
    final choice = await showDialog<({String? tag})>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.prefLanguage),
        children: [
          RadioGroup<String?>(
            groupValue: current,
            onChanged: (tag) => Navigator.of(context).pop((tag: tag)),
            child: Column(
              children: [
                RadioListTile<String?>(
                  value: null,
                  title: Text(l10n.prefSystem),
                ),
                for (final MapEntry(key: tag, value: name)
                    in appLanguages.entries)
                  RadioListTile<String?>(value: tag, title: Text(name)),
              ],
            ),
          ),
        ],
      ),
    );
    if (choice == null) return;
    await ref.read(settingsRepositoryProvider).setLanguageTag(choice.tag);
  }

  Future<void> _editName(
    BuildContext context,
    WidgetRef ref,
    String? current,
  ) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => _NameDialog(initial: current ?? ''),
    );
    if (name == null) return;
    await ref.read(settingsRepositoryProvider).setDisplayName(name);
  }
}

class _NameDialog extends StatefulWidget {
  const _NameDialog({required this.initial});

  final String initial;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void submit() => Navigator.of(context).pop(_controller.text);
    return AlertDialog(
      title: Text(l10n.prefName),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: AppSettings.displayNameMaxLength,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(hintText: l10n.meDefaultName),
        onSubmitted: (_) => submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(onPressed: submit, child: Text(l10n.actionSave)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: QyicSectionLabel(text),
  );
}
