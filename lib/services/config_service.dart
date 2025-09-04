import 'package:get/get.dart';

class ConfigService extends GetxService {
  static ConfigService get to => Get.find();

  // Base URL configuration
  final String baseUrl = 'http://10.10.7.106:5000/api/v1';

  // Registration endpoint
  String get registerEndpoint => '$baseUrl/user';

  // Email verification endpoint
  String get verifyEmailEndpoint => '$baseUrl/auth/verify-email';

  // Resend OTP endpoint
  String get resendOtpEndpoint => '$baseUrl/auth/resend-otp';

  Future<ConfigService> init() async {
    print('API Base URL: $baseUrl');
    print('Registration Endpoint: $registerEndpoint');
    print('Verify Email Endpoint: $verifyEmailEndpoint');
    print('Resend OTP Endpoint: $resendOtpEndpoint');
    return this;
  }
}