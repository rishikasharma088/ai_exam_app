
import 'package:flutter/material.dart';
import 'exam_page.dart';
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const TextField(
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),

            const SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExamPage(),
                  ),
                );
              },
              child: const Text("Signup"),
            ),

          ],
        ),
      ),
    );
  }
}