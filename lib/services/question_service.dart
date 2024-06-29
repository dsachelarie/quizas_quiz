import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/topic.dart';
import '../providers/providers.dart';
import '../models/question.dart';
import './api_service.dart';

class QuestionService {
  static List<Widget> getAnswerList(WidgetRef ref) {
    Question question = ref.watch(questionProvider);
    List<Widget> widgets = [];

    for (dynamic answer in question.answers) {
      widgets.add(const Spacer());
      widgets.add(ElevatedButton(
          onPressed: () async {
            bool isCorrect = await ApiService.checkAnswerCorrectness(
                question.topicId, question.id, answer);

            if (!isCorrect) {
              ref
                  .watch(correctnessProvider.notifier)
                  .update((state) => state = 0);
            }

            if (isCorrect) {
              ref
                  .watch(correctnessProvider.notifier)
                  .update((state) => state = 1);
            }
          },
          child: Text(answer)));
    }

    widgets.add(const Spacer());

    return widgets;
  }

  static Future<Question> getRandomQuestion(WidgetRef ref) async {
    List<Topic> topics = ref.watch(topicsProvider);
    final prefs = await SharedPreferences.getInstance();
    int minCount = 0;
    int minTopicId = 0;

    for (Topic topic in topics) {
      if (prefs.containsKey('count_topic_${topic.id}')) {
        int count = prefs.getInt('count_topic_${topic.id}')!;

        if (count < minCount) {
          minCount = count;
          minTopicId = topic.id;
        }
      } else {
        minCount = 0;
        minTopicId = topic.id;
        break;
      }
    }

    return ApiService.getQuestion(minTopicId);
  }

  static Question fromJson(int topicId, Map<String, dynamic> jsonData) {
    if (jsonData.containsKey('image_url')) {
      return Question(topicId, jsonData['id'], jsonData['question'],
          jsonData['options'], jsonData['answer_post_path'],
          imageUrl: jsonData['image_url']);
    }

    return Question(topicId, jsonData['id'], jsonData['question'],
        jsonData['options'], jsonData['answer_post_path']);
  }
}
