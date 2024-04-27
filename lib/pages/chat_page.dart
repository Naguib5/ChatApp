import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static const String id = 'chat_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(klogo, height: 50),
          const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          )
        ]),
      ),
    );
  }
}
