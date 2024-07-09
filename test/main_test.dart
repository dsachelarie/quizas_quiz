import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/main.dart';
import 'package:quizas_quiz/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets(
      'Opening the application shows a list of topics. (REQUIRED TEST NO. 1)',
      (tester) async {
    nock("https://dad-quiz-api.deno.dev").get("/topics").reply(200, [
      {"id": 0, "name": "first topic", "question_path": ""},
      {"id": 1, "name": "second topic", "question_path": ""},
      {"id": 2, "name": "third topic", "question_path": ""}
    ]);

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();

    final columnFinder = find.byType(Column);

    expect(find.byType(HomeScreen), findsOneWidget);

    expect(
        find.descendant(
            of: columnFinder,
            matching: find.widgetWithText(ElevatedButton, "first topic")),
        findsOneWidget);
    expect(
        find.descendant(
            of: columnFinder,
            matching: find.widgetWithText(ElevatedButton, "second topic")),
        findsOneWidget);
    expect(
        find.descendant(
            of: columnFinder,
            matching: find.widgetWithText(ElevatedButton, "third topic")),
        findsOneWidget);
  });

  testWidgets(
      'Selecting a topic leads to being shown a question for that topic. (REQUIRED TEST NO. 2)',
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

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "first topic"));
    await tester.pumpAndSettle();

    expect(find.text("first question"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, "option1"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, "2"), findsOneWidget);
  });

  testWidgets(
      'Selecting an answer option leads to it being correctly shown as either correct or incorrect. (REQUIRED TEST NO. 3)',
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
  });

  testWidgets(
      'Opening the statistics page shows the total correct answer count. (REQUIRED TEST NO. 4)',
      (tester) async {
    SharedPreferences.setMockInitialValues({'count': 2});

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.tap(find.widgetWithText(TextButton, "Statistics"));
    await tester.pumpAndSettle();

    expect(find.text("Total number of correctly answered questions: 2"),
        findsOneWidget);
  });

  testWidgets(
      'Opening the statistics page shows topic-specific statistics. (REQUIRED TEST NO. 5)',
      (tester) async {
    nock("https://dad-quiz-api.deno.dev").get("/topics").reply(200, [
      {"id": 0, "name": "first topic", "question_path": ""},
      {"id": 1, "name": "second topic", "question_path": ""},
      {"id": 2, "name": "third topic", "question_path": ""}
    ]);

    SharedPreferences.setMockInitialValues(
        {'count_topic_0': 3, 'count_topic_1': 2, 'count_topic_2': 1});

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(TextButton, "Statistics"));
    await tester.pumpAndSettle();

    expect(
        find.text(
            'Total number of correctly answered questions for the topic "first topic": 3'),
        findsOneWidget);
    expect(
        find.text(
            'Total number of correctly answered questions for the topic "second topic": 2'),
        findsOneWidget);
    expect(
        find.text(
            'Total number of correctly answered questions for the topic "third topic": 1'),
        findsOneWidget);
  });

  testWidgets(
      'Choosing the generic practice option leads to being shown a question from a topic with the fewest correct answers. (REQUIRED TEST NO. 6)',
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
      "question": "question first topic",
      "options": ["option1", 2],
      "answer_post_path": ""
    });

    nock("https://dad-quiz-api.deno.dev")
        .get("/topics/1/questions")
        .reply(200, {
      "id": 1,
      "question": "question second topic",
      "options": ["option1", 2],
      "answer_post_path": ""
    });

    nock("https://dad-quiz-api.deno.dev")
        .get("/topics/2/questions")
        .reply(200, {
      "id": 2,
      "question": "question third topic",
      "options": ["option1", 2],
      "answer_post_path": ""
    });

    SharedPreferences.setMockInitialValues(
        {'count_topic_0': 3, 'count_topic_1': 2, 'count_topic_2': 1});

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, "Generic practice"));
    await tester.pumpAndSettle();

    expect(find.text('question third topic'), findsOneWidget);
  });
}
