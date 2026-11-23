import 'package:flutter/foundation.dart';

/// A recurring study reminder at a local wall-clock time on chosen weekdays.
@immutable
class Reminder {
  const Reminder({
    this.id,
    required this.minuteOfDay,
    required this.weekdays,
    this.enabled = true,
  });

  static const everyDay = {
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  };

  /// Null until stored.
  final int? id;

  /// Minutes after local midnight, 0 … 1439.
  final int minuteOfDay;

  /// `DateTime.monday` … `DateTime.sunday`.
  final Set<int> weekdays;
  final bool enabled;

  int get hour => minuteOfDay ~/ 60;
  int get minute => minuteOfDay % 60;

  /// Enabled and set for at least one day.
  bool get isActive => enabled && weekdays.isNotEmpty;

  Reminder copyWith({int? minuteOfDay, Set<int>? weekdays, bool? enabled}) =>
      Reminder(
        id: id,
        minuteOfDay: minuteOfDay ?? this.minuteOfDay,
        weekdays: weekdays ?? this.weekdays,
        enabled: enabled ?? this.enabled,
      );

  /// Bit `n` set = weekday `n + 1`, as stored in `reminders.weekdays`.
  static int weekdayMask(Set<int> weekdays) {
    var mask = 0;
    for (final day in weekdays) {
      RangeError.checkValueInInterval(
        day,
        DateTime.monday,
        DateTime.sunday,
        'weekday',
      );
      mask |= 1 << (day - 1);
    }
    return mask;
  }

  static Set<int> weekdaysFromMask(int mask) => {
    for (var day = DateTime.monday; day <= DateTime.sunday; day++)
      if (mask & (1 << (day - 1)) != 0) day,
  };

  @override
  bool operator ==(Object other) =>
      other is Reminder &&
      other.id == id &&
      other.minuteOfDay == minuteOfDay &&
      setEquals(other.weekdays, weekdays) &&
      other.enabled == enabled;

  @override
  int get hashCode =>
      Object.hash(id, minuteOfDay, Object.hashAllUnordered(weekdays), enabled);
}

/// One weekly OS notification derived from a [Reminder].
@immutable
class PlannedNotification {
  const PlannedNotification({
    required this.id,
    required this.weekday,
    required this.hour,
    required this.minute,
  });

  /// Stable per (reminder, weekday), so re-planning replaces in place.
  final int id;
  final int weekday;
  final int hour;
  final int minute;

  @override
  bool operator ==(Object other) =>
      other is PlannedNotification &&
      other.id == id &&
      other.weekday == weekday &&
      other.hour == hour &&
      other.minute == minute;

  @override
  int get hashCode => Object.hash(id, weekday, hour, minute);

  @override
  String toString() => 'PlannedNotification($id, $weekday $hour:$minute)';
}

/// The weekly notifications that must exist for [reminders], ordered by id.
/// Inactive or unsaved reminders produce none.
List<PlannedNotification> planNotifications(Iterable<Reminder> reminders) {
  final plan = [
    for (final reminder in reminders)
      if (reminder.isActive && reminder.id != null)
        for (final weekday in reminder.weekdays)
          PlannedNotification(
            id: reminder.id! * 8 + weekday,
            weekday: weekday,
            hour: reminder.hour,
            minute: reminder.minute,
          ),
  ];
  return plan..sort((a, b) => a.id.compareTo(b.id));
}
