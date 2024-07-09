import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../models/topic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsService {
  static Future<List<Widget>> getCounts(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    int totalCount = 0;

    if (prefs.containsKey('count')) {
      totalCount = prefs.getInt('count')!;
    }

    Map<String, int> counts = {};
    List<Topic> topics = ref.watch(topicsProvider);

    for (Topic topic in topics) {
      if (prefs.containsKey('count_topic_${topic.id}')) {
        counts[topic.name] = prefs.getInt('count_topic_${topic.id}')!;
      } else {
        counts[topic.name] = 0;
      }
    }

    List<Widget> widgets = [
      const Spacer(),
      const Text("Total number of correctly answered questions",
          style: TextStyle(fontSize: 30)),
      Text('- overall: $totalCount', style: const TextStyle(fontSize: 20))
    ];
    List<MapEntry<String, int>> countsList = counts.entries.toList();

    countsList.sort((a, b) => b.value.compareTo(a.value));

    for (MapEntry<String, int> count in countsList) {
      widgets.add(Text('- for the topic "${count.key}": ${count.value}',
          style: const TextStyle(fontSize: 20)));
    }

    widgets.add(const Spacer());

    return widgets;
  }
}
