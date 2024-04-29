import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14, top: 18, bottom: 18),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
              bottomRight: Radius.circular(22),
            )),
        child: Text(
          'i am a new user ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
