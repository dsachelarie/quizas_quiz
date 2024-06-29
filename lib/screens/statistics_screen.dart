import 'package:flutter/material.dart';
import '../widgets/statistics_body_widget.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('Statistics')),
            body: const StatisticsBodyWidget()));
  }
}
