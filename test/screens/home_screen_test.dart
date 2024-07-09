import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizas_quiz/main.dart';
import 'package:quizas_quiz/screens/home_screen.dart';
import 'package:quizas_quiz/screens/statistics_screen.dart';
import 'package:quizas_quiz/widgets/home_body_widget.dart';

void main() {
  testWidgets('All required HomeScreen elements are present.', (tester) async {
    const app = MaterialApp(home: HomeScreen());
    await tester.pumpWidget(app);

    expect(find.byType(HomeBodyWidget), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);

    expect(find.text("Quizas Quiz"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "Statistics"), findsOneWidget);
  });

  testWidgets('Statistics button works.', (tester) async {
    final app = createApp();
    await tester.pumpWidget(app);
    await tester.tap(find.widgetWithText(TextButton, "Statistics"));
    await tester.pumpAndSettle();

    expect(find.byType(StatisticsScreen), findsOneWidget);
  });
}
