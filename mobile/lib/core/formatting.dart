import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

/// Compact interval label for rating buttons: "1 min", "5 h", "3 d", "2.1 mo".
String formatInterval(AppLocalizations l10n, Duration interval) {
  final minutes = interval.inSeconds / 60;
  if (minutes < 60) return l10n.intervalMinutes(minutes.round().clamp(1, 59));
  final hours = minutes / 60;
  if (hours < 24) return l10n.intervalHours(hours.round());
  final days = hours / 24;
  if (days < 30) return l10n.intervalDays(days.round());
  final decimal = _oneDecimal(l10n.localeName);
  if (days < 365) return l10n.intervalMonths(decimal.format(days / 30));
  return l10n.intervalYears(decimal.format(days / 365));
}

/// "11:42" for durations under an hour, "1:05:09" otherwise. Negative
/// durations clamp to zero.
String formatElapsed(Duration elapsed) {
  if (elapsed.isNegative) elapsed = Duration.zero;
  String two(int value) => value.toString().padLeft(2, '0');
  final seconds = two(elapsed.inSeconds.remainder(60));
  if (elapsed.inHours == 0) return '${elapsed.inMinutes}:$seconds';
  return '${elapsed.inHours}:${two(elapsed.inMinutes.remainder(60))}:$seconds';
}

String formatBytes(AppLocalizations l10n, int bytes) {
  const units = ['B', 'KB', 'MB', 'GB'];
  var value = bytes.toDouble();
  var unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  final number = unit == 0
      ? '$bytes'
      : _oneDecimal(l10n.localeName).format(value);
  return '$number ${units[unit]}';
}

/// Local wall-clock time ("07:30" or "7:30 AM" depending on the locale).
String formatMinuteOfDay(AppLocalizations l10n, int minuteOfDay) =>
    DateFormat.jm(
      l10n.localeName,
    ).format(DateTime(2000, 1, 1, minuteOfDay ~/ 60, minuteOfDay % 60));

/// Short weekday name for `DateTime.monday` … `DateTime.sunday`.
String formatWeekday(AppLocalizations l10n, int weekday) =>
    // 2024-01-01 was a Monday.
    DateFormat.E(l10n.localeName).format(DateTime(2024, 1, weekday));

/// Whole-number percentage in the locale's style ("90%", "90 %").
String formatPercent(AppLocalizations l10n, double fraction) =>
    NumberFormat.percentPattern(l10n.localeName).format(fraction);

NumberFormat _oneDecimal(String locale) => NumberFormat('0.#', locale);
