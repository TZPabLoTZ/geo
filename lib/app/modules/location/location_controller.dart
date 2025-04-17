import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_map/free_map.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final mapController = MapController();

  LatLng userLocation = const LatLng(-12.55043, -55.74707);

  double searchRadiusKm = 5.0;

  double currentZoomLevel = 14.0;

  List<Marker> locationMarkers = <Marker>[];

  static const double earthRadiusKm = 6371.0;
  static const double earthCircumferenceKm = 2 * pi * earthRadiusKm;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      final Map<String, dynamic>? args = Get.arguments;
      if (args != null) {
        if (args.containsKey('latitude') && args.containsKey('longitude')) {
          userLocation = LatLng(args['latitude'], args['longitude']);
        }

        if (args.containsKey('radius')) {
          searchRadiusKm = args['radius'];
        }
      }
    }

    updateLocationMarkers();
  }

  double calculateZoomLevelForRadius(double radiusKm) {
    return 16 - log(radiusKm) / log(2);
  }

  Future<void> getAddressFromCoordinates(LatLng position) async {
    final data = await FmService().getAddress(
      lat: position.latitude,
      lng: position.longitude,
    );
    if (kDebugMode) print(data?.address);
    if (data != null) {
      getCoordinatesFromAddress(data.address);
      userLocation = position;
      updateLocationMarkers();
      update();
    }
  }

  Future<void> getCoordinatesFromAddress(String address) async {
    final data = await FmService().getGeocode(address: address);
    if (data != null) {
      if (kDebugMode) print('${data.lat},${data.lng}');
      userLocation = LatLng(data.lat, data.lng);
      mapController.move(userLocation, currentZoomLevel);
      updateLocationMarkers();
      update();
    }
  }

  void updateLocationMarkers() {
    const double pinIconSize = 40;

    final double metersPerPixel =
        (earthCircumferenceKm * 1000) / (256 * pow(2, currentZoomLevel));
    final double radiusInPixels = (searchRadiusKm * 1000) / metersPerPixel;

    locationMarkers = [
      Marker(
        point: userLocation,
        width: radiusInPixels * 1.5,
        height: radiusInPixels * 1.5,
        rotate: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: radiusInPixels * 1.5,
              height: radiusInPixels * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.3),
                border: Border.all(color: Colors.blue, width: 2),
              ),
            ),
            const Icon(
              Icons.location_pin,
              size: pinIconSize,
              color: Colors.red,
            ),
          ],
        ),
      ),
    ];

    update();
  }

  void updateSearchRadius(double newRadius) {
    searchRadiusKm = newRadius;
    updateLocationMarkers();
  }

  void onMapPositionChanged(MapCamera position, bool hasGesture) {
    if (hasGesture) {
      currentZoomLevel = position.zoom;
      updateLocationMarkers();
      update();
    }
  }

  Map<String, dynamic> getLocationData() {
    return {
      'center': userLocation,
      'radius': searchRadiusKm,
      'latitude': userLocation.latitude,
      'longitude': userLocation.longitude,
    };
  }
}
