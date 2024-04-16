import 'package:flutter/material.dart';

Widget labelTextWidget(String title, Color? textColor) {
  return Text(
    title,
    style: TextStyle(color: textColor),
  );
}

EdgeInsets commonPadding =
    const EdgeInsets.symmetric(horizontal: 30, vertical: 16);
