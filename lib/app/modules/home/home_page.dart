import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_bar_default.dart';
import 'widgets/body_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBarDefault(text: "Produtos"),
      body: BodyHome(),
    );
  }
}
