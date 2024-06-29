import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            return Center(child: Column(children: snapshot.data!));
          }
        });
  }
}
