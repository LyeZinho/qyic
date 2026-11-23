import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../../settings/settings_repository.dart';
import '../data/reminder_repository.dart';
import '../domain/reminder.dart';
import 'reminder_scheduler.dart';

final reminderSchedulerProvider = Provider<ReminderScheduler>(
  (ref) => LocalNotificationsReminderScheduler(),
);

/// Keeps the OS schedule equal to the stored reminders, in the UI language.
/// Watched for the app's lifetime by `QyicApp`.
final reminderSyncProvider = FutureProvider<void>((ref) async {
  final scheduler = ref.watch(reminderSchedulerProvider);
  if (!scheduler.isSupported) return;
  final reminders = await ref.watch(remindersProvider.future);
  final languageTag = await ref.watch(
    settingsProvider.selectAsync((settings) => settings.languageTag),
  );
  final l10n = lookupAppLocalizations(resolveAppLocale(languageTag));
  await scheduler.apply(planNotifications(reminders), (
    title: l10n.reminderTitle,
    body: l10n.reminderBody,
    channelName: l10n.reminderChannel,
  ));
});

/// The locale the UI uses: the chosen language, else the best supported
/// match for the system languages.
Locale resolveAppLocale(String? languageTag) =>
    localeFromTag(languageTag) ??
    basicLocaleListResolution(
      PlatformDispatcher.instance.locales,
      AppLocalizations.supportedLocales,
    );
