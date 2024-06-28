// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../lib/screens/home_screen.dart';
// ignore: avoid_relative_lib_imports
import '../lib/jokes_app.dart';

void main() {
  testWidgets("JokesApp shows HomeScreen at start.", (tester) async {
    await tester.pumpWidget(JokesApp());
    final homeScreenFinder = find.byType(HomeScreen);
    expect(homeScreenFinder, findsOneWidget);
  });
}
