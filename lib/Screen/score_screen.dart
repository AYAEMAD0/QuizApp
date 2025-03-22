import 'package:first/Screen/home_screen.dart';
import 'package:first/constant.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Quiz Result",
          style: TextStyle(
            color: nartual,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -20), 
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    score < 5 ? 'images/sad.jpg' : 'images/perfect.jpg',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Your Score",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: nartual,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "$score / $totalQuestions",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: score > (totalQuestions / 2) ? correct : incorrect,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPhoto,
                foregroundColor: background,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Try Again",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
