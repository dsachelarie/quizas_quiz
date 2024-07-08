import 'package:flutter_test/flutter_test.dart';
import 'package:quizas_quiz/models/topic.dart';

void main() {
  test('Topic constructor works correctly.', () async {
    Topic topic = Topic(0, "some name", "some/path/");

    expect(topic.id, 0);
    expect(topic.name, "some name");
    expect(topic.questionPath, "some/path/");
  });
}
