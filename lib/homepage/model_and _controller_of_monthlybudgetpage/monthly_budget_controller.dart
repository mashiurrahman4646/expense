import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../services/api_base_service.dart';
import '../../services/config_service.dart';

class MonthlyBudgetController extends GetxService {
  final ApiBaseService _apiBaseService = Get.find();
  final ConfigService _configService = Get.find();

  // Observable variables for state management
  final isLoading = false.obs;
  final isSettingBudget = false.obs;
  final errorMessage = ''.obs;
  final currentBudget = Rx<Map<String, dynamic>>({"totalBudget": 0.0});

  @override
  void onInit() {
    super.onInit();
    fetchMonthlyBudget();
  }

  // Get current month in required format
  String getCurrentMonth() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  // Format currency for display
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return formatter.format(amount);
  }

  // Fetch current monthly budget
  Future<void> fetchMonthlyBudget() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final queryParams = {'month': getCurrentMonth()}; // Use lowercase 'month'

      print('🔍 Fetching budget with params: $queryParams');

      final response = await _apiBaseService.request(
        'GET',
        _configService.monthlyBudgetEndpoint,
        queryParams: queryParams,
        requiresAuth: true,
      );

      print('📥 Fetch Response: $response');

      if (response['success'] == true) {
        // Fix: Access the correct data structure
        if (response['data'] != null) {
          currentBudget.value = {
            'totalBudget': (response['data']['totalBudget'] as num).toDouble(), // Use 'totalBudget' not 'amount'
            'month': response['data']['month'],
          };
          print('✅ Budget fetched successfully: ${currentBudget.value}');
        } else {
          // If no budget exists for this month, set default
          currentBudget.value = {
            'totalBudget': 0.0,
            'month': getCurrentMonth(),
          };
        }
      } else {
        errorMessage.value = response['message'] ?? 'Failed to fetch monthly budget';
        print('❌ Fetch failed: ${errorMessage.value}');
      }
    } catch (e) {
      errorMessage.value = 'Error fetching budget: ${e.toString()}';
      print('❌ Fetch budget error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Set monthly budget and refresh
  Future<bool> setMonthlyBudget(double budgetAmount) async {
    try {
      isSettingBudget.value = true;
      errorMessage.value = '';

      // Debug the request
      final month = getCurrentMonth();
      final requestBody = {
        'totalBudget': budgetAmount, // Use 'totalBudget' not 'amount'
        'month': month,
      };

      print('📤 Setting budget with body: $requestBody');

      final postResponse = await _apiBaseService.request(
        'POST',
        _configService.monthlyBudgetEndpoint,
        body: requestBody,
        requiresAuth: true,
      );

      print('📨 POST Response: $postResponse');

      if (postResponse['success'] == true) {
        // Update local state immediately
        currentBudget.value = {
          'totalBudget': budgetAmount,
          'month': month,
        };

        // Also fetch to confirm (optional)
        await fetchMonthlyBudget();

        print('✅ Budget set successfully');
        return true;
      } else {
        errorMessage.value = postResponse['message'] ?? 'Failed to set monthly budget';
        print('❌ Set budget failed: ${errorMessage.value}');
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Server error occurred. Please try again later.';
      print('❌ Set budget error: $e');
      return false;
    } finally {
      isSettingBudget.value = false;
    }
  }
}