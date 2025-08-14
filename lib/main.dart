import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import 'config/app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register ProExpensesIncomeController globally
  Get.put(ProExpensesIncomeController());

  runApp(AppConfig.app);
}
