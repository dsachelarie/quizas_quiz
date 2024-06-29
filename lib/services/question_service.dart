import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
