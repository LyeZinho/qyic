import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../domain/reminder.dart';

/// Localized notification copy.
typedef ReminderText = ({String title, String body, String channelName});

/// Hands planned reminders to the operating system.
abstract interface class ReminderScheduler {
  /// Whether this platform can schedule local notifications.
  bool get isSupported;

  /// Asks for permission to show notifications; true if granted.
  Future<bool> requestPermission();

  /// Replaces every scheduled reminder with [plan].
  Future<void> apply(List<PlannedNotification> plan, ReminderText text);
}

/// [ReminderScheduler] backed by `flutter_local_notifications`. Reminders
/// repeat weekly in the device's time zone and are rescheduled by the OS
/// plugin after a reboot.
class LocalNotificationsReminderScheduler implements ReminderScheduler {
  LocalNotificationsReminderScheduler([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _channelId = 'study_reminders';

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _ready;

  @override
  bool get isSupported =>
      !kIsWeb &&
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  @override
  Future<bool> requestPermission() async {
    if (!isSupported) return false;
    await _ensureReady();
    final granted = switch (defaultTargetPlatform) {
      TargetPlatform.android =>
        await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission(),
      TargetPlatform.iOS =>
        await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, sound: true),
      TargetPlatform.macOS =>
        await _plugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, sound: true),
      _ => false,
    };
    return granted ?? false;
  }

  @override
  Future<void> apply(List<PlannedNotification> plan, ReminderText text) async {
    if (!isSupported) return;
    await _ensureReady();
    await _ensureChannel(text.channelName);
    await _plugin.cancelAllPendingNotifications();
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        text.channelName,
        icon: 'ic_notification',
        category: AndroidNotificationCategory.reminder,
      ),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );
    final now = tz.TZDateTime.now(tz.local);
    for (final notification in plan) {
      await _plugin.zonedSchedule(
        id: notification.id,
        title: text.title,
        body: text.body,
        scheduledDate: nextOccurrence(notification, now),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  Future<void> _ensureReady() => _ready ??= _initialize();

  /// Android 8+ only shows notifications on a channel that exists. Creating
  /// it again with the same id just refreshes its name (the UI language may
  /// have changed).
  Future<void> _ensureChannel(String name) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            _channelId,
            name,
            importance: Importance.defaultImportance,
          ),
        );
  }

  Future<void> _initialize() async {
    tz_data.initializeTimeZones();
    final zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zone.identifier));
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
        iOS: darwin,
        macOS: darwin,
      ),
    );
  }
}

/// The first local time strictly after [now] that falls on
/// `notification.weekday` at its hour and minute. Built from calendar
/// fields so it stays at the same wall-clock time across DST changes.
tz.TZDateTime nextOccurrence(
  PlannedNotification notification,
  tz.TZDateTime now,
) {
  var daysAhead = (notification.weekday - now.weekday) % 7;
  while (true) {
    final candidate = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day + daysAhead,
      notification.hour,
      notification.minute,
    );
    if (candidate.isAfter(now)) return candidate;
    daysAhead += 7;
  }
}
