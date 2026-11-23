import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qyic/main.dart';
import 'package:qyic/theme.dart';

void main() {
  testWidgets('renders the Qyic home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const QyicApp());

    expect(find.text('Qyic'), findsOneWidget);
    expect(
      find.text('Spaced repetition that plays like a game.'),
      findsOneWidget,
    );
    expect(find.text('Gamified quizzes'), findsOneWidget);
    expect(find.text('Spaced repetition'), findsOneWidget);
    expect(find.text('Offline-first'), findsOneWidget);
  });

  testWidgets('uses the dark Qyic design tokens', (WidgetTester tester) async {
    await tester.pumpWidget(const QyicApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme?.brightness, Brightness.dark);
    expect(app.theme?.scaffoldBackgroundColor, QyicColors.base);
    expect(app.theme?.colorScheme.primary, QyicColors.primary);
  });

  testWidgets('does not overflow on a small phone', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const QyicApp());

    expect(tester.takeException(), isNull);
  });
}
