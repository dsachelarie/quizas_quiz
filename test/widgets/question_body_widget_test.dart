import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/main.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Choosing an incorrect answer shows that it was incorrect.',
      (tester) async {
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

    nock("https://dad-quiz-api.deno.dev")
        .post("/topics/0/questions/0/answers", jsonEncode({"answer": 2}))
        .reply(200, {"correct": false});

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "first topic"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, "2"));
    await tester.pumpAndSettle();

    expect(find.text("incorrect"), findsOneWidget);
  });

  testWidgets('Choosing a correct answer allows moving to the next question.',
      (tester) async {
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

    nock("https://dad-quiz-api.deno.dev")
        .post(
            "/topics/0/questions/0/answers", jsonEncode({"answer": "option1"}))
        .reply(200, {"correct": true});

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "first topic"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, "option1"));
    await tester.pumpAndSettle();

    expect(find.text("correct"), findsOneWidget);
    expect(
        find.widgetWithText(ElevatedButton, "Next question"), findsOneWidget);
  });

  testWidgets('Images are shown when available.', (tester) async {
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
      "answer_post_path": "",
      "image_url": ""
    });

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "first topic"));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
}
