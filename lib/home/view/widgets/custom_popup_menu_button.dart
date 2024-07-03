import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Function(String) onSelected;
  const CustomPopupMenuButton({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: onSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ]);
  }
}
