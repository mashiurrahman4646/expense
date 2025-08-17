import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:your_expense/tram_and_condition/trams_condition_controller.dart';

import 'Settings/appearance/ThemeController.dart';

import 'Settings/language/language_controller.dart';

import 'add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import 'config/app_config.dart';
import 'homepage/main_home_page_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Register controllers globally
  Get.put<HomeController>(HomeController(), permanent: true);
  Get.put<ProExpensesIncomeController>(ProExpensesIncomeController(), permanent: true);

  // ✅ Theme Controller
  final themeController = Get.put(ThemeController(), permanent: true);
  await themeController.loadTheme();

  // ✅ Language Controller
  final langController = Get.put(LanguageController(), permanent: true);
  await langController.loadLanguage();

  // ✅ Terms & Conditions Controller
  Get.put<TermsAndConditionsController>(TermsAndConditionsController(), permanent: true);

  runApp(AppConfig.app);
}
