import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService extends GetxService {
  static TokenService get to => Get.find();
  SharedPreferences? _prefs;
  final RxBool isInitialized = false.obs;

  Future<TokenService> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      isInitialized.value = true;
      print('✅ TokenService initialized');
      print('📋 Token exists: ${getToken() != null}');
      print('📋  Token valid: ${isTokenValid()}');
      if (getToken() != null) {
        print('📋 User ID: ${getUserId()}');
      }
      return this;
    } catch (e) {
      print('❌ TokenService initialization failed: $e');
      rethrow;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await _prefs?.setString('auth_token', token);
      print("✅ Token saved successfully");
      print("📋 Token length: ${token.length}");
      print("📋 Token preview: ${token.substring(0, 20)}...");

      // Debug the token immediately after saving
      debugToken();
    } catch (e) {
      print('❌ Error saving token: $e');
      rethrow;
    }
  }

  String? getToken() {
    try {
      final token = _prefs?.getString('auth_token');
      if (token == null || token.isEmpty) {
        print('📋 No token found in storage');
        return null;
      }
      return token;
    } catch (e) {
      print('❌ Error retrieving token: $e');
      return null;
    }
  }

  bool isTokenValid() {
    try {
      final token = getToken();
      if (token == null || token.isEmpty) {
        print('❌ Token is null or empty');
        return false;
      }

      // Basic JWT format check
      final parts = token.split('.');
      if (parts.length != 3) {
        print('❌ Invalid JWT format: ${parts.length} parts instead of 3');
        return false;
      }

      // Decode payload
      final payload = _decodePayload(parts[1]);
      if (payload.isEmpty) {
        print('❌ Failed to decode payload');
        return false;
      }

      // Check expiration
      final exp = payload['exp'];
      if (exp == null) {
        print('❌ No expiration time in token');
        return true; // If no exp, assume valid
      }

      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final isValid = exp > currentTime;

      print('📋 Token expiration: ${DateTime.fromMillisecondsSinceEpoch(exp * 1000)}');
      print('📋 Current time: ${DateTime.now()}');
      print('📋 Token valid: $isValid');

      return isValid;
    } catch (e) {
      print('❌ Token validation error: $e');
      return false;
    }
  }

  Map<String, dynamic> _decodePayload(String payload) {
    try {
      // Handle URL-safe base64 decoding
      String normalizedPayload = payload.replaceAll('-', '+').replaceAll('_', '/');

      // Add padding if needed
      switch (normalizedPayload.length % 4) {
        case 2:
          normalizedPayload += '==';
          break;
        case 3:
          normalizedPayload += '=';
          break;
      }

      final decoded = base64Url.decode(normalizedPayload);
      final String decodedString = utf8.decode(decoded);

      print('📋 Decoded payload: $decodedString');

      return json.decode(decodedString);
    } catch (e) {
      print('❌ Payload decoding error: $e');
      return {};
    }
  }

  Map<String, dynamic>? getTokenPayload() {
    try {
      final token = getToken();
      if (token == null) return null;

      final parts = token.split('.');
      if (parts.length != 3) return null;

      return _decodePayload(parts[1]);
    } catch (e) {
      print('❌ Token payload decoding error: $e');
      return null;
    }
  }

  String? getUserId() {
    try {
      final payload = getTokenPayload();
      if (payload == null) return null;

      // Try different possible user ID fields
      return payload['id']?.toString() ??
          payload['userId']?.toString() ??
          payload['sub']?.toString() ??
          payload['user_id']?.toString();
    } catch (e) {
      print('❌ Error getting user ID: $e');
      return null;
    }
  }

  Future<void> clearToken() async {
    try {
      await _prefs?.remove('auth_token');
      print("✅ Token cleared successfully");
    } catch (e) {
      print('❌ Error clearing token: $e');
    }
  }

  // Additional debug method
  void debugToken() {
    final token = getToken();
    print('=== 🔍 TOKEN DEBUG ===');
    print('Token exists: ${token != null}');
    print('Token length: ${token?.length}');
    print('Token valid: ${isTokenValid()}');
    print('User ID: ${getUserId()}');

    final payload = getTokenPayload();
    if (payload != null) {
      print('Payload keys: ${payload.keys}');
      print('Full payload: $payload');
    }
    print('=====================');
  }

  // Check if user is authenticated
  bool get isAuthenticated {
    return isTokenValid();
  }

  // Get token expiration date
  DateTime? getTokenExpiration() {
    try {
      final payload = getTokenPayload();
      final exp = payload?['exp'];
      if (exp != null && exp is int) {
        return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      }
      return null;
    } catch (e) {
      print('❌ Error getting token expiration: $e');
      return null;
    }
  }

  // Get token issued at date
  DateTime? getTokenIssuedAt() {
    try {
      final payload = getTokenPayload();
      final iat = payload?['iat'];
      if (iat != null && iat is int) {
        return DateTime.fromMillisecondsSinceEpoch(iat * 1000);
      }
      return null;
    } catch (e) {
      print('❌ Error getting token issued at: $e');
      return null;
    }
  }

  // Check if token will expire soon (within 5 minutes)
  bool isTokenExpiringSoon() {
    try {
      final expiration = getTokenExpiration();
      if (expiration == null) return false;

      final now = DateTime.now();
      final fiveMinutesFromNow = now.add(Duration(minutes: 5));

      return expiration.isBefore(fiveMinutesFromNow);
    } catch (e) {
      print('❌ Error checking token expiration: $e');
      return false;
    }
  }
}