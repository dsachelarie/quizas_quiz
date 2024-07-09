import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/main.dart';
import 'package:quizas_quiz/screens/home_screen.dart';
import 'package:quizas_quiz/screens/question_screen.dart';
import 'package:quizas_quiz/screens/statistics_screen.dart';
import 'package:quizas_quiz/widgets/question_body_widget.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('All basic QuestionScreen elements are present.', (tester) async {
    const app = ProviderScope(child: MaterialApp(home: QuestionScreen()));
    await tester.pumpWidget(app);

    expect(find.byType(QuestionBodyWidget), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Quizas Quiz"), findsOneWidget);
  });

  testWidgets('Statistics button works.', (tester) async {
    nock("https://dad-quiz-api.deno.dev").get("/topics").reply(200, [
      {"id": 0, "name": "first topic", "question_path": ""},
      {"id": 1, "name": "second topic", "question_path": ""},
      {"id": 2, "name": "third topic", "question_path": ""}
    ]);

    nock("https://dad-quiz-api.deno.dev")
        .get("/topics/0/questions")
        .reply(200, {
      "id": 0,
      "question": "first question",
      "options": ["option1", 2],
      "answer_post_path": ""
    });

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "first topic"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, "Statistics"));
    await tester.pumpAndSettle();

    expect(find.byType(StatisticsScreen), findsOneWidget);
  });

  testWidgets('Back button works.', (tester) async {
    nock("https://dad-quiz-api.deno.dev").get("/topics").reply(200, [
      {"id": 0, "name": "first topic", "question_path": ""},
      {"id": 1, "name": "second topic", "question_path": ""},
      {"id": 2, "name": "third topic", "question_path": ""}
    ]);

    nock("https://dad-quiz-api.deno.dev")
        .get("/topics/0/questions")
        .reply(200, {
      "id": 0,
      "question": "first question",
      "options": ["option1", 2],
      "answer_post_path": ""
    });

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "first topic"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithIcon(IconButton, Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
