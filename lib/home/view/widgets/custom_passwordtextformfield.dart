import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Color cursorColor;
  final InputDecoration? decoration;
  final String hintText;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? hintTxtColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool obscureText;
  final String obscuringCharacter;
  final Color? txtColor;
  final EdgeInsetsGeometry? contentPadding;
  final int errorMaxLines;

  const CustomPasswordTextFormField({
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
    this.obscureText = true,
    this.obscuringCharacter = ".",
    this.txtColor,
    this.contentPadding,
    this.errorMaxLines = 2,
  });

  @override
  _CustomPasswordTextFormFieldState createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      onTap: widget.onTap,
      obscureText: _isObscured,
      obscuringCharacter: widget.obscuringCharacter,
      style: TextStyle(color: widget.txtColor, fontSize: 9.3),
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 9.3),
        errorMaxLines: widget.errorMaxLines,
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintTxtColor,
          fontSize: 9.3,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          child: _isObscured
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility_outlined),
        ),
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
