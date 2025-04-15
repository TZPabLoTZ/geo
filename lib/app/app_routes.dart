import 'package:get/get.dart';

import 'modules/home/home_page.dart';
import 'modules/location/location_page.dart';
import 'modules/product_details/product_details_page.dart';
import 'modules/splash/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static List<GetPage> pages = [
    GetPage(name: SplashPage.route, page: () => const SplashPage()),
    GetPage(name: HomePage.route, page: () => const HomePage()),
    GetPage(
      name: ProductDetailsPage.route,
      page: () => const ProductDetailsPage(),
    ),
    GetPage(name: LocationPage.route, page: () => const LocationPage()),
  ];
}
