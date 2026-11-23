import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:qyic/app/qyic_app.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/features/reminders/application/reminder_sync.dart';

import '../helpers.dart';
import '../widget_test.dart' show pumpUntilFound;

void main() {
  testWidgets('main screens render without build errors', (tester) async {
    tester.view
      ..physicalSize = const Size(1080, 2400)
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final db = inMemoryDatabase();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          reminderSchedulerProvider.overrideWithValue(FakeReminderScheduler()),
        ],
        child: const QyicApp(),
      ),
    );
    await pumpUntilFound(tester, find.text('Welcome to Qyic'));
    expect(tester.takeException(), isNull, reason: 'home');
    expect(find.byType(ErrorWidget), findsNothing, reason: 'home');

    await tester.tap(find.text('Start review'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull, reason: 'study setup');
    expect(find.byType(ErrorWidget), findsNothing, reason: 'study setup');
    // Leave the screen with the back button, which needs MaterialLocalizations.
    final back = find.byType(BackButton);
    if (back.evaluate().isNotEmpty) {
      await tester.tap(back.first);
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull, reason: 'after study');

    await tester.pumpWidget(const SizedBox());
    await tester.pump(Duration.zero);
    await tester.runAsync(db.close);
  });
}
