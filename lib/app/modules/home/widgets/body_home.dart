import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_button_default.dart';
import '../../../widgets/text_default.dart';
import '../../product_details/product_details_page.dart';
import '../home_controller.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (control) {
        final product = control.productList;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Raio: ${control.raioKm.toStringAsFixed(0)} km'),
                  Slider(
                    min: 1,
                    max: 10,
                    value: control.raioKm,
                    divisions: 9,
                    activeColor: AppColors.secondary,
                    label: '${control.raioKm.toStringAsFixed(0)} km',
                    onChanged: (value) {
                      control.updateRaio(value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  product.isEmpty
                      ? Center(child: Text('Nenhum produto próximo.'))
                      : ListView.builder(
                        itemCount: product.length,
                        itemBuilder: (context, index) {
                          final p = product[index];

                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextDefault(
                                      text: p.name,
                                      color: AppColors.text,
                                      fontSize: 20,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.border,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(p.image, height: 125),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextDefault(
                                      text: 'R\$ ${p.price}',
                                      color: AppColors.text,
                                    ),
                                    AppButtonDefault(
                                      isValid: true,
                                      onTap: () {
                                        Get.to(
                                          () => ProductDetailsPage(product: p),
                                        );
                                      },
                                      text: "Ver mais",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ],
        );
      },
    );
  }
}
