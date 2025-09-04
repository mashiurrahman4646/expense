// services/token_service.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService extends GetxService {
  final RxString token = ''.obs;
  final RxBool hasToken = false.obs;

  Future<TokenService> init() async {
    await loadToken();
    return this;
  }

  Future<void> loadToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('auth_token');

      if (storedToken != null && storedToken.isNotEmpty) {
        token.value = storedToken;
        hasToken.value = true;
      }
    } catch (e) {
      print('Error loading token: $e');
    }
  }

  Future<void> setToken(String newToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', newToken);
      token.value = newToken;
      hasToken.value = true;
    } catch (e) {
      print('Error saving token: $e');
      rethrow;
    }
  }

  Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      token.value = '';
      hasToken.value = false;
    } catch (e) {
      print('Error clearing token: $e');
      rethrow;
    }
  }

  String getToken() {
    return token.value;
  }

  bool isTokenValid() {
    return hasToken.value && token.value.isNotEmpty;
  }
}