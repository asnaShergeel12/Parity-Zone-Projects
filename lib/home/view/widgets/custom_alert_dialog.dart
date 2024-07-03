import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const CustomText(
            text: 'Cancel',
            fontSize: 12,
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const CustomText(
            text: 'Delete',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
