import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('All statistics are shown.', (tester) async {
    SharedPreferences.setMockInitialValues({'count': 4, 'count_topic_0': 3});

    nock("https://dad-quiz-api.deno.dev").get("/topics").reply(200, [
      {"id": 0, "name": "first topic", "question_path": ""},
      {"id": 1, "name": "second topic", "question_path": ""},
      {"id": 2, "name": "third topic", "question_path": ""}
    ]);

    final app = createApp();
    await tester.pumpWidget(app);
    await tester.pump();
    await tester.tap(find.widgetWithText(TextButton, "Statistics"));
    await tester.pumpAndSettle();

    expect(find.text('- overall: 4'), findsOneWidget);
    expect(find.text('- for the topic "first topic": 3'), findsOneWidget);
  });
}
