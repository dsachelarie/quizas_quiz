class Joke {
  String question;
  String punchline;

  Joke(this.question, this.punchline);
}

class JokeRepository {
  static final _jokes = <Joke>[
    Joke("What has four wheels and flies?", "A garbage truck."),
    Joke("What do you call a fake noodle?", "An impasta."),
    Joke("What kind of a car does a sheep like to drive?", "A lamborghini.")
  ];

  static Joke randomJoke() {
    return (_jokes..shuffle()).first;
  }
}
