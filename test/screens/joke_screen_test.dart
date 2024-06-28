import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/screens/joke_screen.dart';

void main() {
  testWidgets("Has two containers and a button.", (tester) async {
    await tester.pumpWidget(MaterialApp(home: JokeScreen()));
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsExactly(2));
    final buttonFinder = find.byType(TextButton);
    expect(buttonFinder, findsOneWidget);
  });
}
