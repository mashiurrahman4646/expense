import 'package:get/get.dart';

import 'package:your_expense/services/api_base_service.dart';
import 'package:your_expense/services/config_service.dart';

import '../model/budget.dart';

class BudgetService extends GetxService {
  final ApiBaseService _apiService = Get.find();
  final ConfigService _configService = Get.find();

  Future<BudgetService> init() async {
    print('BudgetService initialized');
    return this;
  }

  Future<Budget> fetchBudgetData() async {
    try {
      final response = await _apiService.request(
        'GET',
        _configService.budgetEndpoint,
        requiresAuth: true,
      );

      if (response['success'] == true) {
        return Budget.fromJson(response['data']);
      } else {
        throw Exception('Failed to fetch budget data: ${response['message']}');
      }
    } catch (e) {
      print('Error fetching budget data: $e');
      Get.snackbar('Error', 'Failed to fetch budget data: $e');
      rethrow;
    }
  }
}