import 'package:flutter/material.dart';
import './util/screen_wrapper.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      Center(
        child: ElevatedButton(
          child: const Text("Hmm..."),
          onPressed: () => Navigator.pushNamed(context, '/joke'),
        ),
      ),
    );
  }
}
