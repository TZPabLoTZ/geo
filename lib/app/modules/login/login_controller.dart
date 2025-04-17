import 'package:flutter/material.dart';
import 'package:free_map/free_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';

class LoginController extends GetxController {
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  String userAddress = '';
  bool isAddressValidated = false;
  bool isLoading = false;
  LatLng? userLocation;

  @override
  void onInit() {
    super.onInit();
    // Tentar obter a localização automaticamente ao iniciar
    Future.delayed(Duration(milliseconds: 500), () {
      getLocationAndAddress();
    });
  }

  void login() {
    if (nameController.text.isNotEmpty && isAddressValidated) {
      Get.offAllNamed(HomePage.route);
    } else {
      Get.snackbar(
        'Erro de Login',
        'Por favor, preencha todos os campos e valide seu endereço',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getLocationAndAddress() async {
    isLoading = true;
    update();

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permissão de localização negada");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permissão Negada',
          'Para usar esta função, você precisa permitir o acesso à sua localização nas configurações do dispositivo',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          mainButton: TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: Text(
              'Abrir Configurações',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        isLoading = false;
        update();
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      final data = await FmService().getAddress(
        lat: position.latitude,
        lng: position.longitude,
      );

      if (data != null && data.address.isNotEmpty) {
        addressController.text = data.address;

        _setAddressAsValid(data.address, position.latitude, position.longitude);

        Get.snackbar(
          'Localização Encontrada',
          'Seu endereço foi preenchido automaticamente',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Endereço não encontrado',
          'Não foi possível identificar seu endereço. Por favor, digite manualmente.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro ao obter localização',
        'Não foi possível obter sua localização. Por favor, digite seu endereço manualmente.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> validateAddress(String address) async {
    if (address.isEmpty) return;

    isLoading = true;
    update();

    try {
      final data = await FmService().getGeocode(address: address);

      isLoading = false;
      update();

      if (data != null) {
        _setAddressAsValid(address, data.lat, data.lng);
      } else {
        _setAddressAsValid(address, -12.55043, -55.74707);
      }
    } catch (e) {
      isLoading = false;
      update();

      _setAddressAsValid(address, -12.55043, -55.74707);
      Get.snackbar(
        'Validação alternativa',
        'Não foi possível verificar o endereço, mas foi aceito com localização aproximada',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  void _setAddressAsValid(String address, double lat, double lng) {
    userAddress = address;
    userLocation = LatLng(lat, lng);
    isAddressValidated = true;
    update();
  }
}
