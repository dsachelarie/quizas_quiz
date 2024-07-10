import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/statistics_service.dart';

class StatisticsBodyWidget extends ConsumerWidget {
  const StatisticsBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double fontSize = 20;
    bool lineBreak = false;

    if (MediaQuery.of(context).size.width < 700) {
      fontSize = 13;
      lineBreak = true;
    }

    return FutureBuilder<List<dynamic>>(
        future: StatisticsService.getCounts(ref, fontSize, lineBreak),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Retrieving statistics...");
          } else if (snapshot.hasError) {
            return Text(
                "Error encountered while retrieving statistics: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return const Text("No statistics available");
          } else {
            return Center(child: Column(children: snapshot.data!));
          }
        });
  }
}
