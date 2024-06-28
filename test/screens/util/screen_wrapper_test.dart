import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../../../lib/screens/util/screen_wrapper.dart';

void main() {
  testWidgets("Screen wrapper has the proper title.", (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: ScreenWrapper(
            ElevatedButton(onPressed: null, child: Text("some button")))));
    final elevatedButtonFinder = find.byType(ElevatedButton);
    expect(elevatedButtonFinder, findsOneWidget);
    final textFinder = find.text('DAD Jokes');
    expect(textFinder, findsOneWidget);
  });
}
