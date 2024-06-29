import 'package:flutter/material.dart';
import '../widgets/question_body_widget.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: const Text("Quizas Quiz"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/statistics/');
                      },
                      child: const Text("Statistics",
                          style: TextStyle(fontSize: 20)))
                ],
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(30),
                    child: Row(children: ref.watch(topicsWidgetProvider)))),
            body: const QuestionBodyWidget()));
  }
}
