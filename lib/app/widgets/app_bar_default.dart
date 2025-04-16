import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'text_default.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const AppBarDefault({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      title: TextDefault(
        text: text,
        color: AppColors.black,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
      backgroundColor: AppColors.backgroundLight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
