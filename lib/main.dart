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
import 'package:your_expense/login/login_controller/login_controller.dart';
import 'package:your_expense/login/logservice/login_api_service.dart';

import 'homepage/service/budget_service.dart';
import 'homepage/service/review_service.dart';
import 'homepage/service/transaction_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await Get.putAsync(() => ConfigService().init());
  await Get.putAsync(() => TokenService().init());
  await Get.putAsync(() => ApiBaseService().init());
  await Get.putAsync(() => LoginService().init());
  await Get.putAsync(() => RegistrationApiService().init());
  await Get.putAsync(() => VerificationApiService().init());
  await Get.putAsync(() => TransactionService().init());
  await Get.putAsync(() => BudgetService().init());
  await Get.putAsync(() => ReviewService().init());

  // Initialize controllers
  final themeController = Get.put(ThemeController(), permanent: true);
  final langController = Get.put(LanguageController(), permanent: true);
  Get.put(LoginController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(ProExpensesIncomeController(), permanent: true);
  Get.put(TermsAndConditionsController(), permanent: true);

  // Load settings
  await themeController.loadTheme();
  await langController.loadLanguage();

  runApp(AppConfig.app);
}