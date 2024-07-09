import 'package:flutter_test/flutter_test.dart';
import 'package:quizas_quiz/models/question.dart';
import 'package:quizas_quiz/services/question_service.dart';

void main() {
  test(
      'A Question object without an image url is obtained correctly from json.',
      () async {
    Question question = QuestionService.fromJson(0, {
      "id": 1,
      "question": "Some question?",
      "options": ["Yes", 2],
      "answer_post_path": "some/path/"
    });

    expect(question.topicId, 0);
    expect(question.id, 1);
    expect(question.question, "Some question?");
    expect(question.answers, ["Yes", 2]);
    expect(question.correctAnswerPath, "some/path/");
  });

  test('A Question object with an image url is obtained correctly from json.',
      () async {
    Question question = QuestionService.fromJson(0, {
      "id": 1,
      "question": "Some question?",
      "options": ["Yes", 2],
      "answer_post_path": "some/path/",
      "image_url": "some/image/url/"
    });

    expect(question.topicId, 0);
    expect(question.id, 1);
    expect(question.question, "Some question?");
    expect(question.answers, ["Yes", 2]);
    expect(question.correctAnswerPath, "some/path/");
    expect(question.imageUrl, "some/image/url/");
  });
}
