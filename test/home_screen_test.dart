import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_ranking/screens/home_screen.dart';

void main() {
  testWidgets('Displays stock list and navigates to detail screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('PRAPAT'), findsOneWidget);
    expect(find.text('A5'), findsOneWidget);
    expect(find.text('SAK'), findsOneWidget);

    await tester.tap(find.text('PRAPAT'));
    await tester.pumpAndSettle();
  });
}
