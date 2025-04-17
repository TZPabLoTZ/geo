import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_bar_default.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  static const route = '/profile_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarDefault(text: "Perfil"), body: Container());
  }
}
