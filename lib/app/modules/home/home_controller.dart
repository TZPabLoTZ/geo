import 'dart:math';

import 'package:get/get.dart';

import '../../infra/models/location_model.dart';
import '../../infra/models/product_model.dart';

class HomeController extends GetxController {
  List<ProductModel> allProducts = [];
  List<ProductModel> productList = [];
  double raioKm = 5;

  double minhaLat = -12.55043;
  double minhaLong = -55.74707;

  @override
  void onInit() {
    super.onInit();
    carregarProdutosComLocalizacao();
  }

  Future<void> carregarProdutosComLocalizacao() async {
    allProducts = [
      ProductModel(
        name: 'Loja A',
        price: 20,
        image: 'assets/images/lojas.png',
        description: '1 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: minhaLat + 0.009,
          longitude: minhaLong + 0.009,
        ),
      ),
      ProductModel(
        name: 'Loja B',
        price: 30,
        image: 'assets/images/lojas.png',
        description: '3 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: minhaLat + 0.017,
          longitude: minhaLong + 0.017,
        ),
      ),
      ProductModel(
        name: 'Loja C',
        price: 25,
        image: 'assets/images/lojas.png',
        description: '5 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: minhaLat + 0.035,
          longitude: minhaLong + 0.035,
        ),
      ),
      ProductModel(
        name: 'Loja D',
        price: 15,
        image: 'assets/images/lojas.png',
        description: '7 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: minhaLat + 0.048,
          longitude: minhaLong + 0.048,
        ),
      ),
      ProductModel(
        name: 'Loja E',
        price: 50,
        image: 'assets/images/lojas.png',
        description: '9 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: minhaLat + 0.064,
          longitude: minhaLong + 0.064,
        ),
      ),
    ];

    filtrarProdutosPeloRaio();
  }

  void filtrarProdutosPeloRaio() {
    productList =
        allProducts.where((produto) {
          final lat = produto.location?.latitude;
          final long = produto.location?.longitude;

          if (lat == null || long == null) return false;

          final distancia = calcularDistanciaKm(minhaLat, minhaLong, lat, long);
          return distancia <= raioKm;
        }).toList();

    update();
  }

  void updateRaio(double value) {
    raioKm = value;
    filtrarProdutosPeloRaio();
    update();
  }

  double calcularDistanciaKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double R = 6371;
    final double dLat = _degToRad(lat2 - lat1);
    final double dLon = _degToRad(lon2 - lon1);
    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distancia = R * c;
    return distancia;
  }

  double _degToRad(double grau) {
    return grau * (pi / 180);
  }
}
