class Question {
  final int topicId;
  final int id;
  final String question;
  final List<dynamic> answers;
  final String correctAnswerPath;
  final String? imageUrl;

  Question(this.topicId, this.id, this.question, this.answers,
      this.correctAnswerPath,
      {this.imageUrl});
}
