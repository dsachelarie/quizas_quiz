import 'package:flutter/material.dart';
import '../widgets/home_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            body: const HomeBodyWidget()));
  }
}
