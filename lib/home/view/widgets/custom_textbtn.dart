import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? bgcolor;
  final Color bordercolor;
  final Color? txtcolor;

  const CustomTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.bgcolor,
      required this.bordercolor,
      this.txtcolor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed!();
      },
      style: TextButton.styleFrom(
          backgroundColor: bgcolor,
          fixedSize: const Size.fromWidth(230),
          side: BorderSide(width: 2, color: bordercolor)),
      child: Text(text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: txtcolor,
          )),
    );
  }
}
