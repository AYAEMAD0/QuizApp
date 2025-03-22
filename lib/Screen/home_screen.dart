import 'dart:async';
import 'dart:convert';
import 'package:first/Screen/score_screen.dart';
import 'package:first/constant.dart';
import 'package:first/question_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentQuestionIndex = 0;
  int _timeLeft = 10;
  int _score = 0;
  String? _selectedAnswer;
  Timer? _timer;
  List<Question> questionsList = [];
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final url =
        Uri.parse("https://opentdb.com/api.php?amount=10&type=multiple");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Question> fetchedQuestions =
            (data['results'] as List).map((q) => Question.fromJson(q)).toList();

        setState(() {
          questionsList = fetchedQuestions;
          isLoading = false;
          _startTimer();
        });
      } else {
        throw Exception("Failed to load questions");
      }
    } catch (e) {
      print("Error fetching questions: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _checkAnswer(String selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
    });

    if (selectedAnswer == questionsList[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    Future.delayed(const Duration(seconds: 1), _nextQuestion);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questionsList.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
      _startTimer();
    } else {
      _timer?.cancel();
      _navigateToScoreScreen();
    }
  }

  void _navigateToScoreScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ScoreScreen(score: _score, totalQuestions: questionsList.length),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Quiz",
          style: TextStyle(
              color: nartual, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${_currentQuestionIndex + 1}/${questionsList.length}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: nartual),
                      ),
                      Text(
                        "Time : $_timeLeft sec",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _timeLeft < 4 ? incorrect : nartual,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: nartual,
                    thickness: 1.5,
                    height: 20,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: nartual,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      questionsList[_currentQuestionIndex].question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: questionsList[_currentQuestionIndex]
                          .answers
                          .map<Widget>((answer) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () => _checkAnswer(answer),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: _selectedAnswer == answer
                                          ? (answer ==
                                                  questionsList[
                                                          _currentQuestionIndex]
                                                      .correctAnswer
                                              ? correct
                                              : incorrect)
                                          : nartual,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      answer,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
