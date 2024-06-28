import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../models/question.dart';
import './api_service.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicService {
  static Future<List<Widget>> getTopicList(
      WidgetRef ref, VoidCallback navigateToQuestion) async {
    List<Topic> topics = await ApiService.getTopics();
    List<Widget> widgets = [];

    if (topics.isEmpty) {
      widgets.add(const Text("No topics available"));
    } else {
      for (Topic topic in topics) {
        widgets.add(const Spacer());
        widgets.add(ElevatedButton(
            onPressed: () async {
              Question question = await ApiService.getQuestion(topic.id);
              ref
                  .watch(questionProvider.notifier)
                  .update((state) => state = question);

              ref
                  .watch(correctnessProvider.notifier)
                  .update((state) => state = -1);

              navigateToQuestion();
            },
            child: Text(topic.name)));
      }

      widgets.add(const Spacer());
    }

    ref.watch(topicsWidgetProvider.notifier).update((state) => state = widgets);
    ref.watch(topicsProvider.notifier).update((state) => state = topics);

    return widgets;
  }

  static Topic fromJson(Map<String, dynamic> jsonData) {
    return Topic(jsonData['id'], jsonData['name'], jsonData['question_path']);
  }
}
