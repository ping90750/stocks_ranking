import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_ranking/screens/details_screen.dart';

void main() {
  testWidgets('Displays stock details correctly', (WidgetTester tester) async {
    const stockSymbol = "PRM";
    const stockId = "BKK:PRM";
    const jittaScore = "6.48";
    const rank = "2";

    await tester.pumpWidget(
      MaterialApp(
        home: DetailsScreen(
            stockSymbol: stockSymbol,
            stockId: stockId,
            jittaScore: jittaScore,
            rank: rank),
      ),
    );

    expect(find.text('Full name: Prima Marine Public Company Limited'),
        findsOneWidget);
    expect(find.text('Short name:: Prima Marine'), findsOneWidget);
  });
}
