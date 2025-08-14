import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Import all screens
import '../Analytics/expenses_screen.dart';
import '../Analytics/income_screen.dart';
import '../Analytics/main_analytics_screen.dart';
import '../Analytics/uplod_drive.dart';

import '../Comparison/Comparison_screen.dart';
import '../Facelogin/face_login.dart';
import '../RegisterScreen/reg_screen.dart';
import '../RegisterScreen/verification.dart';
import '../Settings/main_setting_screen.dart';
import '../add_exp/normaluser/normal_income_and_exp_screen.dart';
import '../add_exp/pro_user/expenseincomepro/proexpincome.dart';
import '../add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import '../faceidverification/face_verification_screen.dart';
import '../faceidverification/faceverificatio_for_reg/SignupfaceVerificationScreen.dart';
import '../faceidverification/faceverificatio_for_reg/face_confirmation_screen.dart';
import '../forget_password/forget_password_code/forget_password_screen.dart';
import '../forget_password/forget_password_email/forget_password_otp_screen.dart';
import '../forget_password/set_new_password/set_new_password_screen.dart';
import '../forget_password/set_new_password/set_new_password_screen_controller.dart';
import '../homepage/edit/edit_ui.dart';
import '../homepage/main_home_page.dart';
import '../homepage/notification/notification_ui.dart';
import '../homepage/share_exp/share_exp_screen.dart';
import '../homepage/view all/view_ui.dart';
import '../login/login_ui/login_screen.dart';
import '../make it pro/AdvertisementPage/add_ui.dart';
import '../onbaording/onboarding_ui/onboarding_screen.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';

class AppRoutes {
  // Route constants
  static const String analytics = '/analytics';
  static const String advertisement = '/advertisement';
  static const String settings = '/settings';
  static const String addTransaction = '/addTransaction';
  static const String proExpensesIncome = '/proExpensesIncome';
  static const String notification = '/notification';
  static const String editBudget = '/editBudget';
  static const String monthlyBudget = '/monthlyBudget';
  static const String shareExperience = '/shareExperience';
  static const String allTransactions = '/allTransactions';
  static const String expensesScreen = '/expensesScreen';
  static const String incomeScreen = '/incomeScreen';
  static const String uploadToDrive = '/uploadToDrive';
  static const String initial = '/onboarding';
  static const String login = '/login';
  static const String faceLogin = '/faceLogin';
  static const String signupVerification = '/signupVerification';
  static const String faceVerification = '/faceVerification';
  static const String register = '/register';
  static const String termsConditions = '/termsConditions';
  static const String faceConfirmation = '/faceConfirmation';
  static const String forgetPassword = '/forgetPassword';
  static const String otpVerification = '/otpVerification';
  static const String setNewPassword = '/setNewPassword';
  static const String mainHome = '/mainHome';
  static const String verification = '/verification';
  static const String emailVerification = '/emailVerification';
  static const String comparison = '/comparison';

  static final routes = [
    GetPage(name: initial, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: faceLogin, page: () => FaceLoginScreen()),
    GetPage(name: signupVerification, page: () => SignupVerificationScreen()),
    GetPage(name: faceVerification, page: () => FaceVerificationScreen()),
    GetPage(name: register, page: () => RegistrationScreen()),
    GetPage(name: termsConditions, page: () => const TermsAndConditionsScreen()),
    GetPage(name: faceConfirmation, page: () => FaceConfirmationScreen()),
    GetPage(name: forgetPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: otpVerification, page: () => OtpVerificationScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPasswordScreen()),
    GetPage(name: mainHome, page: () => MainHomeScreen()),
    GetPage(name: analytics, page: () => AnalyticsScreen()),
    GetPage(
      name: proExpensesIncome,
      page: () => const ProExpensesIncomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProExpensesIncomeController>(() => ProExpensesIncomeController());
      }),
    ),
    GetPage(
      name: advertisement,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final bool isFromExpense = args?['isFromExpense'] ?? true;
        return AdvertisementPage(isFromExpense: isFromExpense);
      },
    ),
    GetPage(name: settings, page: () => SettingsScreen()),
    GetPage(name: addTransaction, page: () => AddTransactionScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(name: monthlyBudget, page: () => MonthlyBudgetScreen()),
    GetPage(name: shareExperience, page: () => const RateAndImproveScreen()),
    GetPage(name: allTransactions, page: () => const AllTransactionsScreen()),
    GetPage(name: expensesScreen, page: () => ExpenseListScreen()),
    GetPage(name: incomeScreen, page: () => IncomeListScreen()),
    GetPage(name: uploadToDrive, page: () => UploadToDriveScreen()),
    GetPage(name: emailVerification, page: () => EmailVerificationScreen()),
    GetPage(
      name: comparison,
      page: () => const ComparisonPageScreen(isFromExpense: true),
    ),
  ];
}