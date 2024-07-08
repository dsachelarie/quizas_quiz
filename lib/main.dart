import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/question_screen.dart';
import './screens/statistics_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

main() {
  runApp(createApp());
}

Widget createApp() {
  return ProviderScope(
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/question/': (_) => const QuestionScreen(),
        '/statistics/': (_) => const StatisticsScreen(),
      },
    ),
  );
}
