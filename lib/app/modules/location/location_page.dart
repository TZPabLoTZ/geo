import 'package:flutter/material.dart';
import 'package:free_map/free_map.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_button_default.dart';
import 'location_controller.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  static const route = '/location_page';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar localização'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: 'Pesquisar endereço',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.getCoordinatesFromAddress(value);
                }
              },
            ),
          ),
          Expanded(
            child: GetBuilder<LocationController>(
              builder:
                  (controller) => FmMap(
                    mapController: controller.mapController,
                    mapOptions: MapOptions(
                      minZoom: 1,
                      maxZoom: 18,
                      initialZoom: controller.currentZoomLevel,
                      initialCenter: controller.userLocation,
                      onTap:
                          (pos, point) =>
                              controller.getAddressFromCoordinates(point),
                      onPositionChanged: controller.onMapPositionChanged,
                    ),
                    markers: controller.locationMarkers,
                  ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    GetBuilder<LocationController>(
                      builder:
                          (controller) =>
                              Text('Raio: ${controller.searchRadiusKm} km'),
                    ),
                    GetBuilder<LocationController>(
                      builder:
                          (controller) => Slider(
                            min: 1,
                            max: 10,
                            value: controller.searchRadiusKm,
                            divisions: 9,
                            activeColor: AppColors.secondary,
                            label:
                                '${controller.searchRadiusKm.toStringAsFixed(1)} km',
                            onChanged: controller.updateSearchRadius,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: AppButtonDefault(
                  onTap: () {
                    Get.back(
                      result: {
                        'center': controller.userLocation,
                        'radius': controller.searchRadiusKm,
                        'latitude': controller.userLocation.latitude,
                        'longitude': controller.userLocation.longitude,
                      },
                    );
                  },
                  text: "Aplicar localização",
                  fontSize: 18,
                  paddingVertical: 18,
                  isValid: true,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
