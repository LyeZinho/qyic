import 'package:flutter/widgets.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:material_ui/material_ui.dart' show GlobalMaterialLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:qyic/core/formatting.dart';
import 'package:qyic/l10n/l10n.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  test('every offered language has app and Material translations', () {
    for (final tag in appLanguages.keys) {
      final locale = localeFromTag(tag)!;
      final l10n = lookupAppLocalizations(locale);
      expect(l10n.appTitle, 'Qyic', reason: tag);
      expect(l10n.cardCount(3), contains('3'), reason: tag);
      expect(
        GlobalMaterialLocalizations.delegate.isSupported(locale),
        isTrue,
        reason: tag,
      );
      expect(
        GlobalCupertinoLocalizations.delegate.isSupported(locale),
        isTrue,
        reason: tag,
      );
    }
  });

  test('Brazilian and European Portuguese are distinct', () {
    final brazil = lookupAppLocalizations(localeFromTag('pt-BR')!);
    final portugal = lookupAppLocalizations(localeFromTag('pt-PT')!);
    expect(brazil.localeName, 'pt');
    expect(portugal.localeName, 'pt_PT');
    expect(brazil.actionSave, isNot(portugal.actionSave));
  });

  test('formatting follows the selected language', () {
    final de = lookupAppLocalizations(const Locale('de'));
    expect(formatMinuteOfDay(de, 19 * 60 + 5), '19:05');
    expect(formatWeekday(de, DateTime.monday), 'Mo');
    expect(formatPercent(de, 0.9), '90\u00a0%');
    expect(formatInterval(de, const Duration(days: 63)), '2,1 Mon.');
    expect(formatBytes(de, 1536), '1,5 KB');

    final ja = lookupAppLocalizations(const Locale('ja'));
    expect(formatInterval(ja, const Duration(days: 3)), '3日');
  });
}
