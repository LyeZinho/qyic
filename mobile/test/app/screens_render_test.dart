import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:qyic/app/qyic_app.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/features/reminders/application/reminder_sync.dart';
import 'package:qyic/l10n/l10n.dart';

import '../helpers.dart';
import '../widget_test.dart' show pumpUntilFound;

void main() {
  // Every UI language, because material_ui widgets (BackButton, NavigationBar
  // tooltips) look up material_ui's MaterialLocalizations, and its built-in
  // fallback only covers English. A missing lookup renders as a grey box in
  // release builds.
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('main screens render without build errors ($locale)', (
      tester,
    ) async {
      tester.view
        ..physicalSize = const Size(1080, 2400)
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      tester.platformDispatcher.localesTestValue = [locale];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      final l10n = lookupAppLocalizations(locale);
      final db = inMemoryDatabase();
      // The test font draws every glyph as a full em square, so longer
      // translations overflow rows that fit with the real fonts. This test is
      // about build errors; ignore layout overflow.
      final reportError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exception case FlutterError(:final message)
            when message.contains('overflowed')) {
          return;
        }
        reportError?.call(details);
      };

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
            reminderSchedulerProvider.overrideWithValue(
              FakeReminderScheduler(),
            ),
          ],
          child: const QyicApp(),
        ),
      );
      await pumpUntilFound(tester, find.text('Welcome to Qyic'));
      expect(tester.takeException(), isNull, reason: 'home');
      expect(find.byType(ErrorWidget), findsNothing, reason: 'home');

      await tester.tap(find.text(l10n.homeStartReview));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull, reason: 'study setup');
      expect(find.byType(ErrorWidget), findsNothing, reason: 'study setup');
      // Leave the screen with the back button, which needs
      // MaterialLocalizations.
      final back = find.byType(BackButton);
      if (back.evaluate().isNotEmpty) {
        await tester.tap(back.first);
        await tester.pumpAndSettle();
      }
      expect(tester.takeException(), isNull, reason: 'after study');

      await tester.pumpWidget(const SizedBox());
      await tester.pump(Duration.zero);
      await tester.runAsync(db.close);
      // Restored here, not in addTearDown: the binding checks the handler
      // before tear-downs run.
      FlutterError.onError = reportError;
    });
  }
}
