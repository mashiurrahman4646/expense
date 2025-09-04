// main.dart
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:your_expense/tram_and_condition/trams_condition_controller.dart';
import 'package:your_expense/RegisterScreen/registration_api_service.dart';
import 'package:your_expense/RegisterScreen/verification_api_service.dart';
import 'package:your_expense/Settings/appearance/ThemeController.dart';
import 'package:your_expense/Settings/language/language_controller.dart';
import 'package:your_expense/add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import 'package:your_expense/config/app_config.dart';
import 'package:your_expense/homepage/main_home_page_controller.dart';

import 'package:your_expense/services/token_service.dart';
import 'package:your_expense/services/config_service.dart';
import 'package:your_expense/services/api_base_service.dart';

import 'login/login_controller/login_controller.dart';
import 'login/logservice/login_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services first
  await Get.putAsync(() => ConfigService().init());
  await Get.putAsync(() => TokenService().init());
  await Get.putAsync(() => ApiBaseService().init());
  await Get.putAsync(() => LoginService().init());
  await Get.putAsync(() => RegistrationApiService().init());
  await Get.putAsync(() => VerificationApiService().init());

  // Initialize controllers
  final themeController = Get.put(ThemeController(), permanent: true);
  final langController = Get.put(LanguageController(), permanent: true);
  Get.put(LoginController(), permanent: true);

  // Load settings before running app
  await themeController.loadTheme();
  await langController.loadLanguage();

  // Other controllers
  Get.put<HomeController>(HomeController(), permanent: true);
  Get.put<ProExpensesIncomeController>(ProExpensesIncomeController(), permanent: true);
  Get.put<TermsAndConditionsController>(TermsAndConditionsController(), permanent: true);

  runApp(AppConfig.app);
}