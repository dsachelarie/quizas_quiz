import 'package:flutter/material.dart';
import '../services/question_service.dart';
import '../providers/providers.dart';
import '../models/question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Question question = ref.watch(questionProvider);
    List<Widget> answers = QuestionService.getAnswerList(ref);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text(question.question), actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/statistics/');
                  },
                  child:
                      const Text("Statistics", style: TextStyle(fontSize: 20)))
            ]),
            body: Center(child: Column(children: answers))));
  }
}
