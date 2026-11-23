import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/app/qyic_app.dart';
import 'package:qyic/core/providers.dart';
import 'package:qyic/features/reminders/application/reminder_sync.dart';

import 'helpers.dart';

void main() {
  testWidgets('boots into Home with the starter deck', (tester) async {
    // A typical phone: 360 x 800 logical pixels.
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

    expect(find.text('Ready to study?'), findsOneWidget);
    expect(find.text('Start review'), findsOneWidget);

    // Unmounting cancels drift query streams, which close on a zero-length
    // timer; flush it before the binding checks for pending timers.
    await tester.pumpWidget(const SizedBox());
    await tester.pump(Duration.zero);
    // Real I/O cannot complete inside the fake-async zone.
    await tester.runAsync(db.close);
  });
}

/// Lets real database I/O (outside the fake-async zone) complete between
/// frames until [finder] matches.
Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 50; attempt++) {
    if (finder.evaluate().isNotEmpty) return;
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump();
  }
  throw TestFailure('Timed out waiting for $finder');
}
