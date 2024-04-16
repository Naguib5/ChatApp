import 'package:chatapp/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? textColor;

  final EdgeInsets? padding;

  const AppOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.textColor,
  }) : super(key: key);

  factory AppOutlinedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color? textColor,
    required String title,
  }) {
    return AppOutlinedButton(
      key: key,
      onPressed: onPressed,
      padding: padding,
      child: labelTextWidget(title, textColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: Colors.white, width: 1),
          padding: padding ?? commonPadding,
        ),
        onPressed: onPressed,
        child: child);
  }
}
