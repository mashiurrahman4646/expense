import 'package:get/get.dart';
import '../services/api_base_service.dart';
import '../services/config_service.dart';


class RegistrationApiService extends ApiBaseService {
  final ConfigService _config = Get.find();

  // User Registration - ONLY registration endpoint
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    return await request('POST', _config.registerEndpoint, body: userData);
  }

  Future<RegistrationApiService> init() async {
    print('RegistrationApiService initialized');
    return this;
  }
}