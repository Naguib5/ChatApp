import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomRight: Radius.circular(28),
          )),
      height: 65,
      width: 150,
      child: Text(
        'i am a new user',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
