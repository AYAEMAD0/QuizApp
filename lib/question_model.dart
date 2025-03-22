class QuestionModel {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  QuestionModel({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
}

List<QuestionModel> questionsList = [
  QuestionModel(
    question: "What is Flutter?",
    answers: ["Framework", "Language", "IDE", "Programs"],
    correctAnswer: "Framework",
  ),
  QuestionModel(
    question: "Who developed Flutter?",
    answers: ["Google", "Microsoft", "Apple", "Oppo"],
    correctAnswer: "Google",
  ),
  QuestionModel(
    question: "Which language does Flutter use?",
    answers: ["C++", "Dart", "Java", "Python"],
    correctAnswer: "Dart",
  ),
  QuestionModel(
    question: "What is the primary purpose of Flutter?",
    answers: [
      "Web Development",
      "Mobile App Development",
      "Game Development",
      "Cyber Security"
    ],
    correctAnswer: "Mobile App Development",
  ),
  QuestionModel(
    question: "What is the main function in a Flutter app?",
    answers: ["startApp()", "runApp()", "launchApp()", "start()"],
    correctAnswer: "runApp()",
  ),
  QuestionModel(
    question: "Which widget is used to create a scrollable list?",
    answers: ["Column", "ListView", "Row", "List"],
    correctAnswer: "ListView",
  ),
  QuestionModel(
    question: "Which widget is used to arrange widgets vertically?",
    answers: ["Column", "Row", "List", "Stack"],
    correctAnswer: "Column",
  ),
  QuestionModel(
    question: "How do you update the state of a StatefulWidget?",
    answers: ["setState()", "updateState()", "restart()", "refreshState()"],
    correctAnswer: "setState()",
  ),
  QuestionModel(
    question: "Which widget is used to create a navigation drawer?",
    answers: ["Drawer", "Sidebar", "Menu", "button"],
    correctAnswer: "Drawer",
  ),
  QuestionModel(
    question: "Which Flutter widget is used for user input?",
    answers: ["Text", "TextField", "Label", "Form"],
    correctAnswer: "TextField",
  ),
];
