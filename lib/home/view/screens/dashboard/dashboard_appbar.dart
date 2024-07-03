import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 40.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: "Studio",
                color: Colors.white,
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 3),
              CustomText(
                text: "Shodwe",
                fontSize: 11.5,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
