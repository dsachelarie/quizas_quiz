import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../services/question_service.dart';
import '../providers/providers.dart';
import '../models/question.dart';

class QuestionBodyWidget extends ConsumerWidget {
  const QuestionBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double fontSize = 20;
    double scaleFactor = 1;

    if (MediaQuery.of(context).size.width < 700) {
      fontSize = 13;
      scaleFactor = 2;
    }

    Question question = ref.watch(questionProvider);
    List<Widget> widgets = [
      const Spacer(),
      Text(question.question, style: TextStyle(fontSize: fontSize + 10)),
      const Spacer(),
    ];

    if (question.imageUrl != null) {
      widgets.add(Image.network(question.imageUrl!, scale: scaleFactor));
      widgets.add(const Spacer());
    }

    widgets.add(Text("Choose one of the answers below:",
        style: TextStyle(fontSize: fontSize)));
    widgets.addAll(QuestionService.getAnswerList(ref));

    int correctness = ref.watch(correctnessProvider);

    // If an answer selection has been made, show a text stating whether it was
    // correct or incorrect, and if it was correct, also show a button for
    // moving to the next question
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
            Question newQuestion = Question(0, 0, "", [], "");

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

            if (ref.watch(genericPracticeProvider)) {
              newQuestion =
                  await QuestionService.getGenericPracticeQuestion(ref);
            } else {
              newQuestion = await ApiService.getQuestion(question.topicId);
            }

            ref
                .watch(questionProvider.notifier)
                .update((state) => state = newQuestion);

            ref
                .watch(correctnessProvider.notifier)
                .update((state) => state = -1);
          },
          child: const Text("Next question")));
    }

    widgets.add(const Spacer());

    return Center(child: Column(children: widgets));
  }
}
