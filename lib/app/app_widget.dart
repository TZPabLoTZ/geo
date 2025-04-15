import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';
import 'modules/splash/splash_page.dart';
import 'theme/app_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: AppColors.backgroundLight,
      debugShowCheckedModeBanner: false,
      title: 'Prontuario AI - Painel',
      getPages: AppRoutes.pages,
      themeMode: ThemeMode.light,
      initialRoute: SplashPage.route,
      // defaultTransition: Transition.noTransition,
      // transitionDuration: const Duration(seconds: 0),
      // locale: const Locale('pt', 'BR'),
      // supportedLocales: const [Locale('pt', 'BR')],
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // builder: (context, child) {
      //   if (kDebugMode) return child!;
      //   return AppBuilderWidget(child: child ?? const SizedBox());
      // },
    );
  }
}
