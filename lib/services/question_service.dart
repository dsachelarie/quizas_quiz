import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../models/question.dart';
import './api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionService {
  static List<Widget> getAnswerList(WidgetRef ref) {
    Question question = ref.watch(questionProvider);
    List<Widget> widgets = [
      const Spacer(),
      Text(question.question, style: const TextStyle(fontSize: 30))
    ];

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

    int correctness = ref.watch(correctnessProvider);

    if (correctness == -1) {
      widgets.add(const Text(""));
      widgets.add(const Spacer());
    } else if (correctness == 0) {
      widgets.add(const Text("incorrect"));
      widgets.add(const Spacer());
    } else if (correctness == 1) {
      widgets.add(const Text("correct"));
      widgets.add(ElevatedButton(
          onPressed: () async {
            Question newQuestion =
                await ApiService.getQuestion(question.topicId);

            ref
                .watch(questionProvider.notifier)
                .update((state) => state = newQuestion);

            ref
                .watch(correctnessProvider.notifier)
                .update((state) => state = -1);

            final prefs = await SharedPreferences.getInstance();
            int count = 0;

            if (prefs.containsKey('count')) {
              count = prefs.getInt('count')!;
            }

            int topicCount = 0;

            if (prefs.containsKey('count_topic_${question.topicId}')) {
              topicCount = prefs.getInt('count_topic_${question.topicId}')!;
            }

            prefs.setInt('count', count + 1);
            prefs.setInt('count_topic_${question.topicId}', topicCount + 1);
          },
          child: const Text("Next question")));
    }

    widgets.add(const Spacer());

    return widgets;
  }

  static Question fromJson(int topicId, Map<String, dynamic> jsonData) {
    return Question(topicId, jsonData['id'], jsonData['question'],
        jsonData['options'], jsonData['answer_post_path']);
  }
}
