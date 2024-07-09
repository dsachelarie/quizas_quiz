import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizas_quiz/main.dart';
import 'package:quizas_quiz/screens/home_screen.dart';
import 'package:quizas_quiz/screens/statistics_screen.dart';
import 'package:quizas_quiz/widgets/statistics_body_widget.dart';

void main() {
  testWidgets('All basic StatisticsScreen elements are present.',
      (tester) async {
    const app = ProviderScope(child: MaterialApp(home: StatisticsScreen()));
    await tester.pumpWidget(app);

    expect(find.byType(StatisticsBodyWidget), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Statistics"), findsOneWidget);
  });

  testWidgets('Back button works.', (tester) async {
    final app = createApp();
    await tester.pumpWidget(app);
    await tester.tap(find.widgetWithText(TextButton, "Statistics"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithIcon(IconButton, Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
