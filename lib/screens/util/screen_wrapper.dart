import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget widget;
  // ignore: use_key_in_widget_constructors
  const ScreenWrapper(this.widget);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DAD Jokes"),
      ),
      body: widget,
    );
  }
}
