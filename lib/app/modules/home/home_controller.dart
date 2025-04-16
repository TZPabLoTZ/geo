import 'dart:math';

import 'package:get/get.dart';

import '../../infra/models/location_model.dart';
import '../../infra/models/product_model.dart';
import '../location/location_page.dart';

class HomeController extends GetxController {
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  double searchRadiusKm = 5;

  double userLatitude = -12.55043;
  double userLongitude = -55.74707;

  @override
  void onInit() {
    super.onInit();
    loadProductsAndApplyFilter();
  }

  Future<void> loadProductsAndApplyFilter() async {
    allProducts = [
      ProductModel(
        name: 'Loja A',
        price: 20,
        image: 'assets/images/lojas.png',
        description: '1 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: userLatitude + 0.009,
          longitude: userLongitude + 0.009,
        ),
      ),
      ProductModel(
        name: 'Loja B',
        price: 30,
        image: 'assets/images/lojas.png',
        description: '3 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: userLatitude + 0.017,
          longitude: userLongitude + 0.017,
        ),
      ),
      ProductModel(
        name: 'Loja C',
        price: 25,
        image: 'assets/images/lojas.png',
        description: '5 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: userLatitude + 0.035,
          longitude: userLongitude + 0.035,
        ),
      ),
      ProductModel(
        name: 'Loja D',
        price: 15,
        image: 'assets/images/lojas.png',
        description: '7 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: userLatitude + 0.048,
          longitude: userLongitude + 0.048,
        ),
      ),
      ProductModel(
        name: 'Loja E',
        price: 50,
        image: 'assets/images/lojas.png',
        description: '9 km de distância',
        listImages: ['assets/images/lojas.png'],
        location: LocationModel(
          latitude: userLatitude + 0.064,
          longitude: userLongitude + 0.064,
        ),
      ),
    ];

    filterProductsByRadius();
  }

  void filterProductsByRadius() {
    filteredProducts =
        allProducts.where((product) {
          final productLat = product.location?.latitude;
          final productLong = product.location?.longitude;

          if (productLat == null || productLong == null) return false;

          final distanceKm = calculateDistanceBetweenPointsKm(
            userLatitude,
            userLongitude,
            productLat,
            productLong,
          );

          return distanceKm <= searchRadiusKm;
        }).toList();

    update();
  }

  void updateSearchRadius(double newRadius) {
    searchRadiusKm = newRadius;
    filterProductsByRadius();
    update();
  }

  double calculateDistanceBetweenPointsKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadiusKm = 6371;
    final double deltaLatRad = degreesToRadians(lat2 - lat1);
    final double deltaLonRad = degreesToRadians(lon2 - lon1);

    final double haversineFormulaA =
        sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(degreesToRadians(lat1)) *
            cos(degreesToRadians(lat2)) *
            sin(deltaLonRad / 2) *
            sin(deltaLonRad / 2);

    final double haversineFormulaC =
        2 * atan2(sqrt(haversineFormulaA), sqrt(1 - haversineFormulaA));
    final double distanceKm = earthRadiusKm * haversineFormulaC;

    return distanceKm;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  Future<void> navigateToLocationSelection() async {
    final result = await Get.toNamed(
      LocationPage.route,
      arguments: {
        'latitude': userLatitude,
        'longitude': userLongitude,
        'radius': searchRadiusKm,
      },
    );

    if (result != null && result is Map<String, dynamic>) {
      if (result.containsKey('latitude') && result.containsKey('longitude')) {
        userLatitude = result['latitude'];
        userLongitude = result['longitude'];
      }

      if (result.containsKey('radius')) {
        searchRadiusKm = result['radius'];
      }

      filterProductsByRadius();
    }
  }
}
