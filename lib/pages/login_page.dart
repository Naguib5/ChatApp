import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B475E),
      body: Column(children: [
        Image.asset('assets/images/scholar.png'),
        const Text('Chat', style: TextStyle(fontSize: 32, color: Colors.white)),
        const Text('Login',
            style: TextStyle(fontSize: 36, color: Colors.white)),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white)),
            hintText: 'Enter your email',
            hintStyle: const TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }
}
