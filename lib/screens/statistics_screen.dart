import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  static Future<int> getCount() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('count')) {
      return prefs.getInt('count')!;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('Statistics')),
            body: FutureBuilder<int>(
                future: getCount(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Center(child: Text(snapshot.data.toString()));
                  }

                  return const Center(child: Text("0"));
                })));
  }
}
