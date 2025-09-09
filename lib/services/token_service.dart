import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService extends GetxService {
  static TokenService get to => Get.find();
  SharedPreferences? _prefs;

  Future<TokenService> init() async {
    _prefs = await SharedPreferences.getInstance();
    // Store the provided token
    await saveToken(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4Nzk4NzQ2Njc2YmUxZTU3ZjYzZTBlOSIsInJvbGUiOiJVU0VSIiwiZW1haWwiOiJzcmFib25zaGFraGF3YXRAZ21haWwuY29tIiwiaWF0IjoxNzU2ODQ5NDU4LCJleHAiOjE3NTgxNDU0NTh9.fmoY2PVVbK4E2geT3E_IE4W5KdcVSbQB1QQeeYz6xuU');
    print('TokenService initialized');
    return this;
  }

  Future<void> saveToken(String token) async {
    await _prefs?.setString('auth_token', token);
  }

  String? getToken() {
    return _prefs?.getString('auth_token');
  }

  bool isTokenValid() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearToken() async {
    await _prefs?.remove('auth_token');
  }
}