import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../domain/reminder.dart';

class ReminderRepository {
  ReminderRepository(this._db);

  final AppDatabase _db;

  Stream<List<Reminder>> watchAll() {
    final query = _db.select(_db.reminders)
      ..orderBy([
        (r) => OrderingTerm.asc(r.minuteOfDay),
        (r) => OrderingTerm.asc(r.id),
      ]);
    return query.watch().map((rows) => [for (final row in rows) _fromRow(row)]);
  }

  /// Inserts a new reminder; returns its id.
  Future<int> add(Reminder reminder) {
    _check(reminder);
    return _db
        .into(_db.reminders)
        .insert(
          RemindersCompanion.insert(
            minuteOfDay: reminder.minuteOfDay,
            weekdays: Reminder.weekdayMask(reminder.weekdays),
            enabled: Value(reminder.enabled),
          ),
        );
  }

  Future<void> update(Reminder reminder) async {
    final id = reminder.id;
    if (id == null) throw ArgumentError.value(reminder, 'reminder', 'no id');
    _check(reminder);
    await (_db.update(_db.reminders)..where((r) => r.id.equals(id))).write(
      RemindersCompanion(
        minuteOfDay: Value(reminder.minuteOfDay),
        weekdays: Value(Reminder.weekdayMask(reminder.weekdays)),
        enabled: Value(reminder.enabled),
      ),
    );
  }

  Future<void> delete(int id) =>
      (_db.delete(_db.reminders)..where((r) => r.id.equals(id))).go();

  static void _check(Reminder reminder) => RangeError.checkValueInInterval(
    reminder.minuteOfDay,
    0,
    24 * 60 - 1,
    'minuteOfDay',
  );

  static Reminder _fromRow(ReminderRow row) => Reminder(
    id: row.id,
    minuteOfDay: row.minuteOfDay,
    weekdays: Reminder.weekdaysFromMask(row.weekdays),
    enabled: row.enabled,
  );
}

final reminderRepositoryProvider = Provider<ReminderRepository>(
  (ref) => ReminderRepository(ref.watch(databaseProvider)),
);

final remindersProvider = StreamProvider<List<Reminder>>(
  (ref) => ref.watch(reminderRepositoryProvider).watchAll(),
);
