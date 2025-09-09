import 'package:get/get.dart';
import 'package:your_expense/services/api_base_service.dart';
import 'package:your_expense/services/config_service.dart';

class ReviewService extends GetxService {
  final ApiBaseService _apiService = Get.find();
  final ConfigService _configService = Get.find();

  Future<ReviewService> init() async {
    print('ReviewService initialized');
    return this;
  }

  Future<Map<String, dynamic>> submitReview(int rating, String comment) async {
    try {
      final response = await _apiService.request(
        'POST',
        '${_configService.baseUrl}/reviews',
        body: {
          'rating': rating,
          'comment': comment,
        },
        requiresAuth: true,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getReviews() async {
    try {
      final response = await _apiService.request(
        'GET',
        '${_configService.baseUrl}/reviews',
        requiresAuth: true,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}