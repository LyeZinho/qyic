import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:qyic/core/formatting.dart';
import 'package:qyic/l10n/l10n.dart';

void main() {
  final en = lookupAppLocalizations(const Locale('en'));

  setUpAll(() => initializeDateFormatting());

  test('formatInterval picks the largest sensible unit', () {
    expect(formatInterval(en, const Duration(seconds: 10)), '1 min');
    expect(
      formatInterval(en, const Duration(minutes: 59, seconds: 40)),
      '59 min',
    );
    expect(formatInterval(en, const Duration(minutes: 90)), '2 h');
    expect(formatInterval(en, const Duration(days: 3)), '3 d');
    expect(formatInterval(en, const Duration(days: 63)), '2.1 mo');
    expect(formatInterval(en, const Duration(days: 730)), '2 y');
  });

  test('formatElapsed shows minutes or hours and clamps negatives', () {
    expect(formatElapsed(const Duration(minutes: 11, seconds: 42)), '11:42');
    expect(
      formatElapsed(const Duration(hours: 1, minutes: 5, seconds: 9)),
      '1:05:09',
    );
    expect(formatElapsed(const Duration(seconds: -3)), '0:00');
  });

  test('formatBytes uses binary units', () {
    expect(formatBytes(en, 512), '512 B');
    expect(formatBytes(en, 1536), '1.5 KB');
    expect(formatBytes(en, 5 * 1024 * 1024), '5 MB');
  });

  test(
    'formatMinuteOfDay, formatWeekday and formatPercent follow the locale',
    () {
      expect(formatMinuteOfDay(en, 19 * 60 + 5), '7:05\u202fPM');
      expect(formatWeekday(en, DateTime.monday), 'Mon');
      expect(formatWeekday(en, DateTime.sunday), 'Sun');
      expect(formatPercent(en, 0.9), '90%');
    },
  );

  test('localeFromTag accepts only offered languages', () {
    expect(localeFromTag('pt-PT'), const Locale('pt', 'PT'));
    expect(localeFromTag('it'), const Locale('it'));
    expect(localeFromTag('fr'), isNull);
    expect(localeFromTag(null), isNull);
  });
}
