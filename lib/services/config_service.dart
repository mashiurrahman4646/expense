
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:intl/intl.dart';

class ConfigService extends GetxService {
  static ConfigService get to => Get.find();

  // Base URL configuration - can be made configurable via environment or parameter
  final String baseUrl;

  ConfigService({this.baseUrl = 'http://10.10.7.106:5000/api/v1'});

  // Auth endpoints
  String get loginEndpoint => '$baseUrl/auth/login';
  String get registerEndpoint => '$baseUrl/user';
  String get verifyEmailEndpoint => '$baseUrl/auth/verify-email';
  String get resendOtpEndpoint => '$baseUrl/auth/resend-otp';
  String get forgotPasswordEndpoint => '$baseUrl/auth/forgot-password';
  String get resetPasswordEndpoint => '$baseUrl/auth/reset-password';

  // Expense endpoints
  String get expenseEndpoint => '$baseUrl/expense';

  // Income endpoints
  String get incomeEndpoint => '$baseUrl/income';

  // Review endpoints
  String get reviewEndpoint => '$baseUrl/review';

  // Transaction and Budget endpoints
  String get recentTransactionsEndpoint => '$baseUrl/recent-transactions';
  String get budgetEndpoint {
    final now = DateTime.now();
    final monthYear = DateFormat('yyyy-MM').format(now);
    return '$baseUrl/budget/$monthYear';
  }
  String get monthlyBudgetEndpoint => '$baseUrl/budget/simple-monthly-budget';
  // Base endpoint without query params

  // Terms and Conditions endpoint
  String get termsAndConditionsEndpoint => '$baseUrl/terms-conditions';

  Future<ConfigService> init() async {
    try {
      print('=== API Configuration ===');
      print('API Base URL: $baseUrl');
      print('Login Endpoint: $loginEndpoint');
      print('Registration Endpoint: $registerEndpoint');
      print('Verify Email Endpoint: $verifyEmailEndpoint');
      print('Resend OTP Endpoint: $resendOtpEndpoint');
      print('Forgot Password Endpoint: $forgotPasswordEndpoint');
      print('Reset Password Endpoint: $resetPasswordEndpoint');
      print('Expense Endpoint: $expenseEndpoint');
      print('Income Endpoint: $incomeEndpoint');
      print('Review Endpoint: $reviewEndpoint');
      print('Recent Transactions Endpoint: $recentTransactionsEndpoint');
      print('Budget Endpoint: $budgetEndpoint');
      print('Monthly Budget Endpoint: $monthlyBudgetEndpoint');
      print('Terms & Conditions Endpoint: $termsAndConditionsEndpoint');
      print('=========================');
      return this;
    } catch (e) {
      print('❌ ConfigService initialization error: $e');
      rethrow;
    }
  }
}