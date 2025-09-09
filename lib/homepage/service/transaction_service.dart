import 'package:get/get.dart';

import 'package:your_expense/services/api_base_service.dart';
import 'package:your_expense/services/config_service.dart';

import '../model/transaction.dart';

class TransactionService extends GetxService {
  final ApiBaseService _apiService = Get.find();
  final ConfigService _configService = Get.find();

  Future<TransactionService> init() async {
    print('TransactionService initialized');
    return this;
  }

  Future<List<Transaction>> fetchRecentTransactions() async {
    try {
      final response = await _apiService.request(
        'GET',
        _configService.recentTransactionsEndpoint,
        requiresAuth: true,
      );

      if (response['success'] == true) {
        final transactions = (response['data']['transactions'] as List<dynamic>)
            .map((json) => Transaction.fromJson(json))
            .toList();
        return transactions;
      } else {
        throw Exception('Failed to fetch transactions: ${response['message']}');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      Get.snackbar('Error', 'Failed to fetch transactions: $e');
      rethrow;
    }
  }
}