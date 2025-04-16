import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../widgets/app_button_default.dart';
import '../home_controller.dart';
import 'card_list_body.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final products = controller.filteredProducts;
        return Column(
          children: [
            CardListBody(product: products),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppButtonDefault(
                isValid: true,
                paddingVertical: 18,
                onTap: controller.navigateToLocationSelection,
                text: "Selecionar localização",
              ),
            ),
          ],
        );
      },
    );
  }
}
