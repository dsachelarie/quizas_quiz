import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/main.dart';
import 'package:quizas_quiz/screens/question_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Topic button works.', (tester) async {
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

    expect(find.byType(QuestionScreen), findsOneWidget);
  });

  testWidgets('Generic practice button works.', (tester) async {
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

    SharedPreferences.setMockInitialValues(
        {'count_topic_0': 1, 'count_topic_1': 2, 'count_topic_2': 2});

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "Generic practice"));
    await tester.pumpAndSettle();

    expect(find.byType(QuestionScreen), findsOneWidget);
  });
}
