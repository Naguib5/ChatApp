import 'package:chatapp/constants.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/app_outlined_button.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
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
            onPressed: () {},
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
    );
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
