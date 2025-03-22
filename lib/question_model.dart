class Question {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> allAnswers = List<String>.from(json['incorrect_answers']);
    allAnswers.add(json['correct_answer']);
    allAnswers.shuffle(); 

    return Question(
      question: json['question'],
      answers: allAnswers,
      correctAnswer: json['correct_answer'],
    );
  }
}
