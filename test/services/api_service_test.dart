import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:quizas_quiz/models/question.dart';
import 'package:quizas_quiz/models/topic.dart';
import 'package:quizas_quiz/services/api_service.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  test('Getting topics from the API works.', () async {
    nock("https://dad-quiz-api.deno.dev").get("/topics").reply(200, [
      {"id": 0, "name": "first topic", "question_path": ""},
      {"id": 1, "name": "second topic", "question_path": ""},
      {"id": 2, "name": "third topic", "question_path": ""}
    ]);

    List<Topic> topics = [
      Topic(0, "first topic", ""),
      Topic(1, "second topic", ""),
      Topic(2, "third topic", "")
    ];
    final apiTopics = await ApiService.getTopics();

    expect(apiTopics[0].id, topics[0].id);
    expect(apiTopics[1].id, topics[1].id);
    expect(apiTopics[2].id, topics[2].id);
  });

  test('Getting a question from the API works.', () async {
    nock("https://dad-quiz-api.deno.dev")
        .get("/topics/0/questions")
        .reply(200, {
      "id": 0,
      "question": "question first topic",
      "options": ["option1", 2],
      "answer_post_path": ""
    });

    Question question =
        Question(0, 0, "question first topic", ["option1", 2], "");
    final apiQuestion = await ApiService.getQuestion(0);

    expect(question.id, apiQuestion.id);
  });

  test('Checking an answer\'s correctness works.', () async {
    nock("https://dad-quiz-api.deno.dev")
        .post(
            "/topics/0/questions/0/answers", jsonEncode({"answer": "option1"}))
        .reply(200, {"correct": true});

    expect(await ApiService.checkAnswerCorrectness(0, 0, "option1"), true);
  });
}
