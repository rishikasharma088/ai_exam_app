import 'package:flutter/material.dart';
import 'dart:async';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {

  int questionIndex = 0;
  int score = 0;

  int timeLeft = 30;
  Timer? timer;

  String? selectedAnswer;
  String resultMessage = "";

  List<Map<String, Object>> questions = [
    {
      'question': 'What does AI stand for?',
      'options': [
        'Artificial Intelligence',
        'Automatic Input',
        'Advanced Internet',
        'Applied Integration'
      ],
      'answer': 'Artificial Intelligence'
    },
    {
      'question': 'Which language is used in Flutter?',
      'options': [
        'Java',
        'Dart',
        'Python',
        'C++'
      ],
      'answer': 'Dart'
    },
    {
      'question': 'Which company developed Flutter?',
      'options': [
        'Microsoft',
        'Google',
        'Apple',
        'Amazon'
      ],
      'answer': 'Google'
    },
    {
      'question': 'Who is known as father of AI?',
      'options': [
        'John McCarthy',
        'Elon Musk',
        'Bill Gates',
        'Alan Walker'
      ],
      'answer': 'John McCarthy'
    }
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        showResult();
      }
    });
  }

  void checkAnswer(String answer) {

    if (answer == questions[questionIndex]['answer']) {
      score++;
      resultMessage = "Correct Answer ✅";
    } else {
      resultMessage = "Wrong Answer ❌";
    }

  }

  void nextQuestion() {

    setState(() {

      selectedAnswer = null;
      resultMessage = "";

      if (questionIndex < questions.length - 1) {
        questionIndex++;
      } else {
        timer?.cancel();
        showResult();
      }

    });

  }

  void showResult() {

    timer?.cancel();

    String message;

    if (score == questions.length) {
      message = "Excellent 🎉";
    } else if (score >= questions.length / 2) {
      message = "Good Job 👍";
    } else {
      message = "Try Again 😅";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exam Finished 🎓"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              "Your Score: $score / ${questions.length}",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 10),

            Text(
              message,
              style: const TextStyle(fontSize: 18),
            ),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () {

              Navigator.pop(context);

              setState(() {
                questionIndex = 0;
                score = 0;
                timeLeft = 30;
                selectedAnswer = null;
                resultMessage = "";
              });

              startTimer();

            },
            child: const Text("Restart Exam"),
          )
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    var currentQuestion = questions[questionIndex];

    return Scaffold(

      appBar: AppBar(
        title: const Text("AI Exam"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Time Left: $timeLeft seconds",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Question ${questionIndex + 1} / ${questions.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              currentQuestion['question'] as String,
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            ...(currentQuestion['options'] as List<String>).map((option) {

              Color buttonColor = Colors.blue;

              if (selectedAnswer != null) {

                if (option == currentQuestion['answer']) {
                  buttonColor = Colors.green;
                }
                else if (option == selectedAnswer) {
                  buttonColor = Colors.red;
                }

              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                  ),

                  onPressed: () {

                    if (selectedAnswer == null) {

                      setState(() {

                        selectedAnswer = option;
                        checkAnswer(option);

                      });

                    }

                  },

                  child: Text(option),

                ),

              );

            }).toList(),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: nextQuestion,
                child: const Text("Next Question"),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                resultMessage,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}