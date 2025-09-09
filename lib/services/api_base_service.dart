import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:your_expense/services/token_service.dart';
import 'package:your_expense/services/config_service.dart';

class ApiBaseService extends GetxService {
  final ConfigService _config = Get.find();
  final TokenService _tokenService = Get.find();
  final http.Client _client = http.Client();

  Future<ApiBaseService> init() async {
    print('ApiBaseService initialized');
    return this;
  }

  Future<Map<String, dynamic>> request(
      String method,
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        Map<String, dynamic>? queryParams,
        bool requiresAuth = true,
      }) async {
    try {
      // Add query parameters to URL
      Uri uri = Uri.parse(endpoint);
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams.map((key, value) =>
            MapEntry(key, value.toString())));
      }

      // Prepare headers
      final requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      };

      // Add authorization header if required and token is available
      if (requiresAuth && _tokenService.isTokenValid()) {
        requestHeaders['Authorization'] = 'Bearer ${_tokenService.getToken()}';
      }

      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(uri, headers: requestHeaders);
          break;
        case 'POST':
          response = await _client.post(
            uri,
            headers: requestHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'PUT':
          response = await _client.put(
            uri,
            headers: requestHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'DELETE':
          response = await _client.delete(uri, headers: requestHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      _logRequest(method, endpoint, body, response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty ? json.decode(response.body) : {};
      } else {
        throw HttpException(response.statusCode, response.body);
      }
    } catch (e) {
      _logError(method, endpoint, e);
      rethrow;
    }
  }

  void _logRequest(String method, String endpoint, dynamic body, http.Response response) {
    print('''
=== API Request ===
Service: ${runtimeType}
Method: $method
URL: $endpoint
Body: ${body != null ? json.encode(body) : 'None'}
Status: ${response.statusCode}
Response: ${response.body}
=== End Request ===
''');
  }

  void _logError(String method, String endpoint, dynamic error) {
    print('''
!!! API Error !!!
Service: ${runtimeType}
Method: $method
URL: $endpoint
Error: $error
!!! End Error !!!
''');
  }

  @override
  void onClose() {
    _client.close();
    super.onClose();
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() => 'HTTP $statusCode: $message';
}