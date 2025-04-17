import 'package:get/get.dart';

import 'modules/home/home_controller.dart';
import 'modules/home/home_page.dart';
import 'modules/location/location_page.dart';
import 'modules/login/login_controller.dart';
import 'modules/login/login_page.dart';
import 'modules/product_details/product_details_page.dart';
import 'modules/profile/profile_page.dart';
import 'modules/splash/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static List<GetPage> pages = [
    GetPage(name: SplashPage.route, page: () => const SplashPage()),
    GetPage(
      name: HomePage.route,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: ProductDetailsPage.route,
      page: () => const ProductDetailsPage(),
    ),
    GetPage(name: LocationPage.route, page: () => const LocationPage()),
    GetPage(
      name: LoginPage.route,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(name: ProfilePage.route, page: () => const ProfilePage()),
  ];
}
