import 'package:flutter_test/flutter_test.dart';
import 'package:quizas_quiz/models/topic.dart';
import 'package:quizas_quiz/services/topic_service.dart';

void main() {
  test('A Topic object is obtained correctly from json.', () async {
    Topic topic = TopicService.fromJson(
        {"id": 0, "name": "some name", "question_path": "some/path/"});

    expect(topic.id, 0);
    expect(topic.name, "some name");
    expect(topic.questionPath, "some/path/");
  });
}
