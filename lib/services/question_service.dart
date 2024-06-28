import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../models/question.dart';
import './api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

            if (isCorrect) {
              Question newQuestion =
                  await ApiService.getQuestion(question.topicId);
              ref
                  .watch(questionProvider.notifier)
                  .update((state) => state = newQuestion);

              final prefs = await SharedPreferences.getInstance();
              int count = 0;

              if (prefs.containsKey('count')) {
                count = prefs.getInt('count')!;
              }

              prefs.setInt('count', count + 1);
            }
          },
          child: Text(answer)));
    }

    widgets.add(const Spacer());

    return widgets;
  }

  static Question fromJson(int topicId, Map<String, dynamic> jsonData) {
    return Question(topicId, jsonData['id'], jsonData['question'],
        jsonData['options'], jsonData['answer_post_path']);
  }
}
