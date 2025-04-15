import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/text_default.dart';
import 'widgets/body_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        title: TextDefault(
          text: 'Produtos',
          color: AppColors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundLight,
      ),
      body: BodyHome(),
    );
  }
}
