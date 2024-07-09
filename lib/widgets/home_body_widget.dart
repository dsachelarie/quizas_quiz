import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question.dart';
import '../services/question_service.dart';
import '../providers/providers.dart';
import '../services/topic_service.dart';

class HomeBodyWidget extends ConsumerWidget {
  const HomeBodyWidget({super.key});

  void _navigateToQuestion(BuildContext context) {
    Navigator.pushNamed(context, '/question/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Widget>>(
        future:
            TopicService.getTopicList(ref, () => _navigateToQuestion(context)),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Retrieving topics...");
          } else if (snapshot.hasError) {
            return Text(
                "Error encountered while retrieving topics: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return const Text("No topics available");
          } else {
            List<Widget> widgets = snapshot.data!;
            navigateToQuestion() => _navigateToQuestion(context);

            widgets.add(ElevatedButton(
                onPressed: () async {
                  ref
                      .watch(genericPracticeProvider.notifier)
                      .update((state) => state = true);

                  Question question =
                      await QuestionService.getGenericPracticeQuestion(ref);

                  ref
                      .watch(questionProvider.notifier)
                      .update((state) => state = question);

                  ref
                      .watch(correctnessProvider.notifier)
                      .update((state) => state = -1);

                  ref
                      .watch(genericPracticeProvider.notifier)
                      .update((state) => state = true);

                  navigateToQuestion();
                },
                child: const Text("Generic practice")));

            widgets.add(const Spacer());

            return Center(child: Column(children: widgets));
          }
        });
  }
}
