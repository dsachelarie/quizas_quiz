import 'package:flutter/material.dart';
import '../services/topic_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _navigateToQuestion(BuildContext context) {
    Navigator.pushNamed(context, '/question/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<Widget>>? topics =
        TopicService.getTopicList(ref, () => _navigateToQuestion(context));

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: const Center(
                    child: Text("Quizas Quiz", style: TextStyle(fontSize: 30))),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(30),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/statistics/');
                        },
                        child: const Text("Statistics",
                            style: TextStyle(fontSize: 20))))),
            body: FutureBuilder<List<Widget>>(
                future: topics,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Widget>> snapshot) {
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
                })));
  }
}
