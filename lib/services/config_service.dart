import 'package:get/get.dart';

class ConfigService extends GetxService {
  static ConfigService get to => Get.find();

  // Base URL configuration
  final String baseUrl = 'http://10.10.7.106:5000/api/v1';

  // Auth endpoints
  String get loginEndpoint => '$baseUrl/auth/login';
  String get registerEndpoint => '$baseUrl/user';
  String get verifyEmailEndpoint => '$baseUrl/auth/verify-email';
  String get resendOtpEndpoint => '$baseUrl/auth/resend-otp';
  String get forgotPasswordEndpoint => '$baseUrl/auth/forgot-password';
  String get resetPasswordEndpoint => '$baseUrl/auth/reset-password';

  // Transaction and Budget endpoints
  String get recentTransactionsEndpoint => '$baseUrl/recent-transactions';
  String get budgetEndpoint => '$baseUrl/budget/2025-09'; // Your budget endpoint

  // Terms and Conditions endpoint
  String get termsAndConditionsEndpoint => '$baseUrl/terms-conditions';

  Future<ConfigService> init() async {
    print('=== API Configuration ===');
    print('API Base URL: $baseUrl');
    print('Login Endpoint: $loginEndpoint');
    print('Registration Endpoint: $registerEndpoint');
    print('Verify Email Endpoint: $verifyEmailEndpoint');
    print('Resend OTP Endpoint: $resendOtpEndpoint');
    print('Forgot Password Endpoint: $forgotPasswordEndpoint');
    print('Reset Password Endpoint: $resetPasswordEndpoint');
    print('Recent Transactions Endpoint: $recentTransactionsEndpoint');
    print('Budget Endpoint: $budgetEndpoint'); // Added budget endpoint log
    print('Terms & Conditions Endpoint: $termsAndConditionsEndpoint');
    print('=========================');
    return this;
  }
}