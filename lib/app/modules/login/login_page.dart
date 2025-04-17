import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/app_button_default.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const route = '/login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBarDefault(text: "Login"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<LoginController>(
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/images/lojas.png'),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome de usuário',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: 'Endereço',
                      hintText: 'Ex: Av. Paulista, 1000, São Paulo',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon:
                          controller.isAddressValidated
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : IconButton(
                                icon: Icon(
                                  Icons.my_location,
                                  color: AppColors.secondary,
                                ),
                                onPressed:
                                    () => controller.getLocationAndAddress(),
                                tooltip: 'Usar localização atual',
                              ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppButtonDefault(
                    text:
                        controller.isAddressValidated
                            ? 'Endereço Validado'
                            : 'Validar Endereço',
                    isValid: true,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (controller.addressController.text.isNotEmpty) {
                        controller.validateAddress(
                          controller.addressController.text,
                        );
                      }
                    },
                    paddingVertical: 15,
                    fontSize: 16,
                    buttonColor:
                        controller.isAddressValidated
                            ? Colors.green
                            : AppColors.secondary,
                  ),
                  const SizedBox(height: 30),
                  AppButtonDefault(
                    text: 'Entrar',
                    isValid: controller.isAddressValidated,
                    onTap: () => controller.login(),
                    paddingVertical: 15,
                    fontSize: 18,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
