import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qyic/main.dart';

void main() {
  testWidgets('renders the Qyic home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const QyicApp());

    expect(find.text('Qyic'), findsOneWidget);
    expect(
      find.text('Spaced repetition that plays like a game.'),
      findsOneWidget,
    );
  });
}
