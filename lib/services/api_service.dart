import 'dart:convert';
import 'package:http/http.dart' as http;
import './topic_service.dart';
import '../models/topic.dart';
import './question_service.dart';
import '../models/question.dart';

class ApiService {
  static Future<List<Topic>> getTopics() async {
    final response =
        await http.get(Uri.parse('https://dad-quiz-api.deno.dev/topics'));

    List<dynamic> topics = jsonDecode(response.body);

    return List<Topic>.from(topics.map(
      (jsonData) => TopicService.fromJson(jsonData),
    ));
  }

  static Future<Question> getQuestion(int topicId) async {
    final response = await http.get(
        Uri.parse('https://dad-quiz-api.deno.dev/topics/$topicId/questions'));

    return QuestionService.fromJson(topicId, jsonDecode(response.body));
  }

  static Future<bool> checkAnswerCorrectness(
      int topicId, int questionId, dynamic answer) async {
    final response = await http.post(
        Uri.parse(
            'https://dad-quiz-api.deno.dev/topics/$topicId/questions/$questionId/answers'),
        body: jsonEncode({'answer': answer}));

    return jsonDecode(response.body)['correct'];
  }
}
