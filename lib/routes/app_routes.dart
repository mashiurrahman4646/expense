import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Import all the screens you need to route to
import '../Analytics/main_analytics_screen.dart';
import '../Comparison/main_Comparison_screen.dart';
import '../Facelogin/face_login.dart';
import '../RegisterScreen/reg_screen.dart';
import '../Settings/main_setting_screen.dart';
import '../add_exp/main_add_exp_screen.dart';
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
import '../onbaording/onboarding_ui/onboarding_screen.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';
// Import the new screen

class AppRoutes {
  // Route constants
  static const String analytics = '/analytics';
  static const String comparison = '/comparison';
  static const String settings = '/settings';
  static const String addTransaction = '/addTransaction';
  static const String notification = '/notification';
  static const String editBudget = '/editBudget';
  static const String monthlyBudget = '/monthlyBudget';
  static const String shareExperience = '/shareExperience';
  static const String allTransactions = '/allTransactions'; // New route for all transactions
  static const initial = '/onboarding';
  static const login = '/login';
  static const faceLogin = '/faceLogin';
  static const signupVerification = '/signupVerification';
  static const faceVerification = '/faceVerification';
  static const register = '/register';
  static const termsConditions = '/termsConditions';
  static const faceConfirmation = '/faceConfirmation';
  static const forgetPassword = '/forgetPassword';
  static const otpVerification = '/otpVerification';
  static const setNewPassword = '/setNewPassword';
  static const mainHome = '/mainHome';

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
    GetPage(name: comparison, page: () => ComparisonScreen()),
    GetPage(name: settings, page: () => SettingsScreen()),
    GetPage(name: addTransaction, page: () => AddTransactionScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(name: monthlyBudget, page: () => MonthlyBudgetScreen()),
    GetPage(name: shareExperience, page: () => const RateAndImproveScreen()),
    GetPage(name: allTransactions, page: () => const AllTransactionsScreen()), // Register the new route
  ];
}
