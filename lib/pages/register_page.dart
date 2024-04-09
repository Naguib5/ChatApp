import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset('assets/images/scholar.png'),
          const SizedBox(
            height: 12,
          ),
          const Text('Chat',
              style: TextStyle(
                  fontSize: 32, color: Colors.white, fontFamily: 'Pacifico')),
          const SizedBox(
            height: 90,
          ),
          const Row(
            children: [
              Text('Register',
                  style: TextStyle(fontSize: 36, color: Colors.white)),
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          CustomTextField(
            hintText: 'Email',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            hintText: 'Password',
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            text: 'Register',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('already have an account?',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF00E676),
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
    ;
  }
}
