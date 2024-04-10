import 'package:chatapp/constants.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static const String id = 'RegisterPage';
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            'assets/images/scholar.png',
            height: 100,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Chat',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico')),
            ],
          ),
          const SizedBox(
            height: 60,
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
            onChanged: (data) {
              email = data;
            },
            hintText: 'Email',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onChanged: (data) {
              password = data;
            },
            hintText: 'Password',
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            onPressed: () async {
              var auth = FirebaseAuth.instance;
              auth.createUserWithEmailAndPassword(
                  email: email!, password: password!);
            },
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
                      color: kSecondaryColor,
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
