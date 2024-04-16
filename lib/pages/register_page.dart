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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: Padding(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chat',
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
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  try {
                    userRegister();
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showSnackBar(
                          context, "The password provided is too weak.");
                    } else if (e.code == 'email-already-in-use') {
                      showSnackBar(context,
                          'The account already exists for that email.');
                    }
                  } catch (ex) {
                    showSnackBar(
                        context, 'there was an error please try again later.');
                  }
                  showSnackBar(context, 'successfully registered.');
                }
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
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> userRegister() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
