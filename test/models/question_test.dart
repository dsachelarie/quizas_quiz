import 'package:flutter_test/flutter_test.dart';
import 'package:quizas_quiz/models/question.dart';

void main() {
  test('Question constructor works correctly.', () async {
    Question question = Question(
        0, 1, "Some question?", ["Yes", 2], "some/path/",
        imageUrl: "some/image/url/");

    expect(question.topicId, 0);
    expect(question.id, 1);
    expect(question.question, "Some question?");
    expect(question.answers, ["Yes", 2]);
    expect(question.correctAnswerPath, "some/path/");
    expect(question.imageUrl, "some/image/url/");
  });
}
