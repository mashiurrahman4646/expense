import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/app_colors.dart';
import '../routes/app_routes.dart';

class AppConfig {
  static final app = GetMaterialApp(
    title: 'Your Expense',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.interTextTheme(),
      scaffoldBackgroundColor: AppColors.text900,
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.text50,
        backgroundColor: AppColors.text900,
      ),
    ),
    initialRoute: AppRoutes.initial,
    getPages: AppRoutes.routes,
  );
}
