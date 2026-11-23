import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/features/reminders/application/reminder_scheduler.dart';
import 'package:qyic/features/reminders/domain/reminder.dart';

AppDatabase inMemoryDatabase() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(NativeDatabase.memory());
}

/// A controllable clock for scheduling-dependent tests.
class TestClock {
  TestClock(this.now);

  DateTime now;

  DateTime call() => now;

  void advance(Duration duration) => now = now.add(duration);
}

/// Records what would be handed to the OS instead of scheduling it.
class FakeReminderScheduler implements ReminderScheduler {
  FakeReminderScheduler({this.isSupported = true, this.grantPermission = true});

  @override
  final bool isSupported;
  final bool grantPermission;

  final applied = <(List<PlannedNotification>, ReminderText)>[];

  @override
  Future<bool> requestPermission() async => grantPermission;

  @override
  Future<void> apply(List<PlannedNotification> plan, ReminderText text) async =>
      applied.add((plan, text));
}
