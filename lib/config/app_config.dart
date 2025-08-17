import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Settings/appearance/ThemeController.dart';
import '../Settings/language/language_controller.dart';
import '../routes/app_routes.dart';

class AppColors {
  static const Color primary = Color(0xFF4CAF50);
  static const Color text900 = Color(0xFF212121);
  static const Color text50 = Color(0xFFFAFAFA);
}

class AppConfig {
  static final app = Obx(() {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();

    return GetMaterialApp(
      title: 'Your Expense',
      debugShowCheckedModeBanner: false,

      // Multi-language support
      locale: langController.locale.value,
      fallbackLocale: const Locale('en', 'US'),

      // Theme configuration
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppColors.text900,
        appBarTheme: const AppBarTheme(
          foregroundColor: AppColors.text50,
          backgroundColor: AppColors.text900,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: themeController.themeMode,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      navigatorObservers: [GetObserver()],
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
    );
  });
}