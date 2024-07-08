import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/main.dart';
import 'package:quizas_quiz/screens/home_screen.dart';

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
    // TODO: Implement test
  });

  testWidgets(
      'Opening the statistics page shows the total correct answer count. (REQUIRED TEST NO. 4)',
      (tester) async {
    // TODO: Implement test
  });

  testWidgets(
      'Opening the statistics page shows topic-specific statistics. (REQUIRED TEST NO. 5)',
      (tester) async {
    // TODO: Implement test
  });

  testWidgets(
      'Choosing the generic practice option leads to being shown a question from a topic with the fewest correct answers. (REQUIRED TEST NO. 6)',
      (tester) async {
    // TODO: Implement test
  });
}
