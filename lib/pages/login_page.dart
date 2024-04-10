import 'package:chatapp/constants.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String id = 'LoginPage';
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
              Text('Login',
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
            onPressed: () {
              signInWithGoogle();
            },
            text: 'Login',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      color: kSecondaryColor,
                    ),
                  ))
            ],
          ),
          IconButton(
              onPressed: () async {
                await signOutWithgoogle();
              },
              icon: Icon(Icons.sign_language_outlined, color: Colors.white)),
        ]),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }

  Future<void> signOutWithgoogle() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }
}
