import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/screens/home_screen.dart';

void main() {
  testWidgets("HomeScreen has button with text 'Hmm...'.", (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    final elevatedButtonFinder = find.byType(ElevatedButton);
    expect(elevatedButtonFinder, findsOneWidget);
    final hmmFinder = find.text('Hmm...');
    expect(hmmFinder, findsOneWidget);
  });
}
