import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const route = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        Get.offAllNamed(LoginPage.route);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF407CE2),
      body: Center(
        child: Image.asset(
          "assets/images/lojas.png",
          width: MediaQuery.of(context).size.width * 0.4,
        ),
      ),
    );
  }
}
