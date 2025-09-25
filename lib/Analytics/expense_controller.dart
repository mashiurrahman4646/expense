import 'package:get/get.dart';

import 'ExpenseService.dart';
import 'expense_model.dart';



class ExpenseController extends GetxController {
  final ExpenseService _expenseService = Get.find();

  final RxList<ExpenseItem> expenses = <ExpenseItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<ExpenseItem> fetchedExpenses = await _expenseService.getExpenses();
      expenses.assignAll(fetchedExpenses);

      // Sort by date (newest first)
      expenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      errorMessage.value = 'Failed to load expenses: ${e.toString()}';
      print('Error loading expenses: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addExpense({
    required double amount,
    required String category,
    String note = '',
  }) async {
    try {
      isLoading.value = true;
      final newExpense = await _expenseService.createExpense(
        amount: amount,
        category: category,
        note: note,
      );

      expenses.insert(0, newExpense);
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to add expense: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateExpenseItem({
    required String id,
    double? amount,
    String? category,
    String? note,
  }) async {
    try {
      isLoading.value = true;
      final updatedExpense = await _expenseService.updateExpense(
        id: id,
        amount: amount,
        category: category,
        note: note,
      );

      final index = expenses.indexWhere((expense) => expense.id == id);
      if (index != -1) {
        expenses[index] = updatedExpense;
      }
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to update expense: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteExpenseItem(String id) async {
    try {
      isLoading.value = true;
      final success = await _expenseService.deleteExpense(id);
      if (success) {
        expenses.removeWhere((expense) => expense.id == id);
      }
      return success;
    } catch (e) {
      errorMessage.value = 'Failed to delete expense: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  double get totalAmount {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  List<ExpenseItem> getExpensesByCategory(String category) {
    return expenses.where((expense) => expense.category == category).toList();
  }

  void clearError() {
    errorMessage.value = '';
  }
}