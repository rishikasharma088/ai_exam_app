import 'package:flutter/material.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
              onPressed: () {},
              child: const Text("Login"),
            ),
            const SizedBox(height: 15),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage(),),
                );
              },
              child: const Text("Create Account"),
            ),

          ],
        ),
      ),
    );
  }
}