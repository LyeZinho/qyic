import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/features/reminders/application/reminder_scheduler.dart';
import 'package:qyic/features/reminders/application/reminder_sync.dart';
import 'package:qyic/features/reminders/data/reminder_repository.dart';
import 'package:qyic/features/reminders/domain/reminder.dart';
import 'package:qyic/features/settings/settings_repository.dart';
import 'package:qyic/l10n/l10n.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../helpers.dart';

void main() {
  group('weekday masks', () {
    test('round-trip every subset of days', () {
      for (var mask = 0; mask < 1 << 7; mask++) {
        expect(Reminder.weekdayMask(Reminder.weekdaysFromMask(mask)), mask);
      }
      expect(Reminder.weekdayMask(Reminder.everyDay), 0x7f);
    });

    test('reject values that are not weekdays', () {
      expect(() => Reminder.weekdayMask({0}), throwsRangeError);
      expect(() => Reminder.weekdayMask({8}), throwsRangeError);
    });
  });

  test('planNotifications expands active, saved reminders per weekday', () {
    final plan = planNotifications([
      const Reminder(
        id: 2,
        minuteOfDay: 19 * 60 + 30,
        weekdays: {DateTime.friday, DateTime.monday},
      ),
      const Reminder(id: 3, minuteOfDay: 0, weekdays: {}),
      const Reminder(
        id: 4,
        minuteOfDay: 8 * 60,
        weekdays: Reminder.everyDay,
        enabled: false,
      ),
      const Reminder(minuteOfDay: 8 * 60, weekdays: Reminder.everyDay),
      const Reminder(id: 1, minuteOfDay: 7 * 60 + 5, weekdays: {7}),
    ]);
    expect(plan, const [
      PlannedNotification(id: 15, weekday: 7, hour: 7, minute: 5),
      PlannedNotification(id: 17, weekday: 1, hour: 19, minute: 30),
      PlannedNotification(id: 21, weekday: 5, hour: 19, minute: 30),
    ]);
  });

  group('nextOccurrence', () {
    late tz.Location berlin;

    setUpAll(() {
      tz_data.initializeTimeZones();
      berlin = tz.getLocation('Europe/Berlin');
    });

    const sundayNine = PlannedNotification(
      id: 1,
      weekday: DateTime.sunday,
      hour: 9,
      minute: 0,
    );

    test('is later today when the time has not passed yet', () {
      final now = tz.TZDateTime(berlin, 2026, 5, 3, 8, 59);
      expect(
        nextOccurrence(sundayNine, now),
        tz.TZDateTime(berlin, 2026, 5, 3, 9),
      );
    });

    test('is next week once the time has passed', () {
      final now = tz.TZDateTime(berlin, 2026, 5, 3, 9);
      expect(
        nextOccurrence(sundayNine, now),
        tz.TZDateTime(berlin, 2026, 5, 10, 9),
      );
    });

    test('keeps the wall-clock time across a DST change', () {
      // Clocks go forward in the early hours of Sunday 2026-03-29.
      final now = tz.TZDateTime(berlin, 2026, 3, 28, 12);
      final next = nextOccurrence(sundayNine, now);
      expect((next.day, next.hour, next.minute), (29, 9, 0));
      expect(next.timeZoneOffset, const Duration(hours: 2));
      expect(next.difference(now), const Duration(hours: 20));
    });
  });

  group('reminders', () {
    late AppDatabase db;
    late ProviderContainer container;
    late FakeReminderScheduler scheduler;

    ProviderContainer containerWith(FakeReminderScheduler fake) {
      scheduler = fake;
      return ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          reminderSchedulerProvider.overrideWithValue(fake),
        ],
      );
    }

    setUp(() {
      db = inMemoryDatabase();
      container = containerWith(FakeReminderScheduler());
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('are stored, updated, and deleted', () async {
      final repository = container.read(reminderRepositoryProvider);
      final id = await repository.add(
        const Reminder(minuteOfDay: 600, weekdays: {1, 3, 5}),
      );
      var [stored] = await repository.watchAll().first;
      expect(
        stored,
        Reminder(id: id, minuteOfDay: 600, weekdays: const {1, 3, 5}),
      );

      await repository.update(stored.copyWith(enabled: false, weekdays: {6}));
      [stored] = await repository.watchAll().first;
      expect(stored.enabled, isFalse);
      expect(stored.weekdays, {6});

      await repository.delete(id);
      expect(await repository.watchAll().first, isEmpty);
    });

    test(
      'sync hands the planned schedule to the OS in the UI language',
      () async {
        await container.read(settingsRepositoryProvider).setLanguageTag('en');
        final id = await container
            .read(reminderRepositoryProvider)
            .add(const Reminder(minuteOfDay: 20 * 60, weekdays: {2, 4}));

        final subscription = container.listen(reminderSyncProvider, (_, _) {});
        addTearDown(subscription.close);
        await container.read(remindersProvider.future);
        await container.read(reminderSyncProvider.future);

        final (plan, text) = scheduler.applied.last;
        expect(plan.map((n) => n.id), [id * 8 + 2, id * 8 + 4]);
        expect(text.title, 'Time to study');

        // Changing the language re-plans with translated text.
        final italian = lookupAppLocalizations(
          const Locale('it'),
        ).reminderTitle;
        await container.read(settingsRepositoryProvider).setLanguageTag('it');
        for (var attempt = 0; attempt < 100; attempt++) {
          if (scheduler.applied.last.$2.title == italian) break;
          await Future<void>.delayed(const Duration(milliseconds: 5));
        }
        expect(scheduler.applied.last.$2.title, italian);
        expect(scheduler.applied.last.$1, plan);
      },
    );

    test('sync does nothing where notifications are unsupported', () async {
      container.dispose();
      container = containerWith(FakeReminderScheduler(isSupported: false));
      await container
          .read(reminderRepositoryProvider)
          .add(const Reminder(minuteOfDay: 60, weekdays: {1}));
      await container.read(reminderSyncProvider.future);
      expect(scheduler.applied, isEmpty);
    });
  });
}
