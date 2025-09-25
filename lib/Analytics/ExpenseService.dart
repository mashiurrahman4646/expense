import 'package:get/get.dart';
import 'package:your_expense/services/api_base_service.dart';
import 'package:your_expense/services/config_service.dart';

import 'expense_model.dart';

class ExpenseService extends GetxService {
  final ApiBaseService _apiService = Get.find();
  final ConfigService _configService = Get.find();

  Future<ExpenseService> init() async {
    print('ExpenseService initialized');
    return this;
  }

  Future<List<ExpenseItem>> getExpenses() async {
    try {
      print('🔍 Fetching expenses from: ${_configService.expenseEndpoint}');

      final response = await _apiService.request(
        'GET',
        _configService.expenseEndpoint,
        requiresAuth: true,
      );

      // Debug the response
      print('📋 API Response type: ${response.runtimeType}');
      print('📋 API Response: $response');

      // Check if response is null or empty
      if (response == null) {
        print('❌ Response is null');
        throw Exception('No response received from server');
      }

      // Based on your JSON example, the API returns the array directly
      if (response is List) {
        print('✅ Successfully received list of ${response.length} expenses');

        List<ExpenseItem> expensesList = [];

        for (int i = 0; i < response.length; i++) {
          try {
            final item = response[i];
            print('🔄 Processing item $i: $item');

            if (item is Map<String, dynamic>) {
              final expense = ExpenseItem.fromJson(item);
              expensesList.add(expense);
              print('✅ Successfully parsed expense: ${expense.id}');
            } else {
              print('⚠️ Invalid item format at index $i: ${item.runtimeType}');
            }
          } catch (e) {
            print('❌ Error parsing expense at index $i: $e');
            // Continue processing other items instead of failing completely
          }
        }

        print('📊 Total successfully parsed expenses: ${expensesList.length}');
        return expensesList;
      }
      // If it's a map, check if it contains the array under common keys
      else if (response is Map<String, dynamic>) {
        print('🗂️ Response is a map, checking for expense data...');
        print('🔑 Available keys: ${response.keys.toList()}');

        List<dynamic>? expensesData;

        if (response.containsKey('data') && response['data'] is List) {
          print('✅ Found expenses in "data" key');
          expensesData = response['data'] as List<dynamic>;
        } else if (response.containsKey('expenses') && response['expenses'] is List) {
          print('✅ Found expenses in "expenses" key');
          expensesData = response['expenses'] as List<dynamic>;
        } else if (response.containsKey('items') && response['items'] is List) {
          print('✅ Found expenses in "items" key');
          expensesData = response['items'] as List<dynamic>;
        } else {
          print('❌ Could not find expense list in response map. Keys: ${response.keys}');
          throw Exception('No expense data found in response. Response keys: ${response.keys}');
        }

        if (expensesData != null) {
          List<ExpenseItem> expensesList = [];

          for (int i = 0; i < expensesData.length; i++) {
            try {
              final item = expensesData[i];
              if (item is Map<String, dynamic>) {
                final expense = ExpenseItem.fromJson(item);
                expensesList.add(expense);
              }
            } catch (e) {
              print('❌ Error parsing expense at index $i: $e');
            }
          }

          return expensesList;
        }
      }
      else {
        print('❌ Unexpected response type: ${response.runtimeType}');
        print('❌ Response content: $response');
        throw Exception('Invalid response format from expense API. Expected List or Map, got ${response.runtimeType}');
      }

      return [];
    } catch (e) {
      print('💥 Error fetching expenses: $e');
      print('💥 Error type: ${e.runtimeType}');
      print('💥 Stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  Future<ExpenseItem> createExpense({
    required double amount,
    required String category,
    String note = '',
  }) async {
    try {
      print('➕ Creating new expense: amount=$amount, category=$category, note=$note');

      final response = await _apiService.request(
        'POST',
        _configService.expenseEndpoint,
        body: {
          'amount': amount,
          'category': category,
          'note': note,
        },
        requiresAuth: true,
      );

      print('✅ Create expense response: $response');

      if (response is Map<String, dynamic>) {
        return ExpenseItem.fromJson(response);
      } else {
        throw Exception('Invalid response format when creating expense');
      }
    } catch (e) {
      print('❌ Error creating expense: $e');
      rethrow;
    }
  }

  Future<ExpenseItem> updateExpense({
    required String id,
    double? amount,
    String? category,
    String? note,
  }) async {
    try {
      final Map<String, dynamic> body = {};
      if (amount != null) body['amount'] = amount;
      if (category != null) body['category'] = category;
      if (note != null) body['note'] = note;

      final response = await _apiService.request(
        'PUT',
        '${_configService.expenseEndpoint}/$id',
        body: body,
        requiresAuth: true,
      );

      if (response is Map<String, dynamic>) {
        return ExpenseItem.fromJson(response);
      } else {
        throw Exception('Invalid response format when updating expense');
      }
    } catch (e) {
      print('❌ Error updating expense: $e');
      rethrow;
    }
  }

  Future<bool> deleteExpense(String id) async {
    try {
      await _apiService.request(
        'DELETE',
        '${_configService.expenseEndpoint}/$id',
        requiresAuth: true,
      );
      return true;
    } catch (e) {
      print('❌ Error deleting expense: $e');
      return false;
    }
  }
}