import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset('assets/images/scholar.png'),
          const Text('Chat',
              style: TextStyle(fontSize: 32, color: Colors.white)),
          const Text('Login',
              style: TextStyle(fontSize: 36, color: Colors.white)),
          CustomTextField(
            hintText: 'Email',
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Password',
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(),
        ]),
      ),
    );
  }
}
