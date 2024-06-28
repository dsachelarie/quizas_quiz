import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/jokes/jokes.dart';

void main() {
  test("Random joke is an instance of joke and is not the parrot question.",
      () async {
    final joke = JokeRepository.randomJoke();

    expect(joke, isA<Joke>());
    expect(joke.question, isNot("What's orange and sounds like a parrot?"));
  });
}
