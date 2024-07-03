import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double fontSize;
  final FontStyle? fontStyle;
  final Color? color;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.decoration,
      this.fontStyle,
      this.color,
      this.maxLines,
      this.overflow,
      this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          decoration: decoration),
    );
  }
}
