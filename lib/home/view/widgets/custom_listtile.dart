import 'package:flutter/material.dart';
import 'custom_popup_menu_button.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget? leading;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      this.leading,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 1,
      contentPadding: const EdgeInsets.only(right: 0.1, left: 5.0),
      visualDensity: const VisualDensity(horizontal: 4, vertical: -4),
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
