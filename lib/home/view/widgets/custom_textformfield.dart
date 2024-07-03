import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Color cursorColor;
  final InputDecoration? decoration;
  final String hintText;
  final TextEditingController controller;
  final Color? txtColor;
  final Color? fillColor;
  final Color? hintTxtColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool? showCursor;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final int errorMaxLines;

  const CustomTextFormField({
    super.key,
    required this.keyboardType,
    this.cursorColor = Colors.grey,
    required this.controller,
    required this.hintText,
    this.validator,
    this.decoration,
    this.fillColor,
    this.hintTxtColor,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.txtColor,
    this.showCursor,
    this.maxLines,
    this.contentPadding,
    this.maxLength,
    this.errorMaxLines = 2,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      showCursor: widget.showCursor,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      onTap: widget.onTap,
      style: TextStyle(color: widget.txtColor, fontSize: 9.3),
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        errorMaxLines: widget.errorMaxLines,
        errorStyle: const TextStyle(fontSize: 9.3),
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintTxtColor,
          fontSize: 9.3,
        ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding: widget.contentPadding,
        constraints: const BoxConstraints(maxWidth: 230),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
    );
  }
}
