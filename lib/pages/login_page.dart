// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:chatapp/constants.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/app_outlined_button.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(children: [
              const SizedBox(
                height: 80,
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
                height: 30,
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
              CustomFormTextField(
                onChanged: (data) {
                  email = data;
                },
                hintText: 'Email',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormTextField(
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
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await userLogin();
                      Navigator.pushNamed(context, ChatPage.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(
                            context, 'Wrong password provided for that user.');
                      }
                    } catch (e) {
                      showSnackBar(context,
                          'there was an error please try again later.');
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
                text: 'Login',
              ),
              _dividerWidget(),
              _socialLoginButtonsWidget(),
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
                  icon: const Icon(Icons.sign_language_outlined,
                      color: Colors.white)),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> userLogin() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  Widget _socialLoginButtonsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _socialButtonWidget(
              onPressed: () {
                signInWithGoogle();
              },
              image: KGoogleIcon,
              title: 'Login With Google'),
          const SizedBox(height: 16),
          _socialButtonWidget(
              onPressed: () {
                signInWithFacebook();
              },
              image: kFacebookIcon,
              title: 'Login With Facebook'),
        ],
      ),
    );
  }

  Widget _socialButtonWidget(
      {required String image,
      required String title,
      required void Function()? onPressed}) {
    return AppOutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _dividerWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'or login with',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(child: Divider(thickness: 1)),
        ],
      ),
    );
  }

  signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Check if the user has canceled the login process
      if (loginResult.status == LoginStatus.cancelled) {
        // Handle canceled login
        return;
      }

      // Get the access token from the login result
      final AccessToken accessToken = loginResult.accessToken!;

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);

      // Sign in with the credential
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      // Access user details if needed
      final User? user = userCredential.user;
      print('User signed in with Facebook: ${user?.displayName}');
    } catch (e) {
      print('Error signing in with Facebook: $e');
      // Handle sign-in error
    }
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
