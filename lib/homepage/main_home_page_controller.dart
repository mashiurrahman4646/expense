import 'package:get/get.dart';
import 'package:your_expense/homepage/service/budget_service.dart';
import 'package:your_expense/homepage/service/transaction_service.dart';
import 'package:intl/intl.dart';

import '../routes/app_routes.dart';
import '../services/token_service.dart';
import 'model/transaction.dart';

class HomeController extends GetxController {
  final TransactionService _transactionService = Get.find();
  final BudgetService _budgetService = Get.find();

  var selectedNavIndex = 0.obs;
  var starRating = 0.obs;

  var availableBalance = 0.0.obs;
  var income = 0.0.obs;
  var expense = 0.0.obs;
  var savings = 0.0.obs;

  var monthlyBudget = 0.0.obs;
  var spentAmount = 0.0.obs;
  var spentPercentage = 0.0.obs;
  var leftAmount = 0.0.obs;
  var leftPercentage = 0.0.obs;

  var recentTransactions = <Transaction>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    selectedNavIndex.value = 0;
    await fetchBudgetData();
    await fetchRecentTransactions();
  }

  String getCurrentMonth() {
    final now = DateTime.now();
    final months = [
      'january'.tr,
      'february'.tr,
      'march'.tr,
      'april'.tr,
      'may'.tr,
      'june'.tr,
      'july'.tr,
      'august'.tr,
      'september'.tr,
      'october'.tr,
      'november'.tr,
      'december'.tr,
    ];
    return months[now.month - 1];
  }

  // Helper method to get current month in API format (YYYY-MM)
  String getCurrentMonthForApi() {
    return DateFormat('yyyy-MM').format(DateTime.now());
  }

  Future<void> fetchRecentTransactions() async {
    try {
      isLoading.value = true;
      final transactions = await _transactionService.fetchRecentTransactions();
      recentTransactions.assignAll(transactions);

      // Calculate total income and expense from transactions
      double totalIncome = 0;
      double totalExpense = 0;

      for (var transaction in transactions) {
        if (transaction.isIncome) {
          totalIncome += transaction.numericAmount;
        } else {
          totalExpense += transaction.numericAmount;
        }
      }

      income.value = totalIncome;
      expense.value = totalExpense;
      availableBalance.value = totalIncome - totalExpense;

    } catch (e) {
      print('Error in fetchRecentTransactions: $e');
      // Error is already handled in TransactionService with Get.snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBudgetData() async {
    try {
      isLoading.value = true;

      // Get current month in API format (YYYY-MM)
      final currentMonth = getCurrentMonthForApi();

      // Fetch budget data using the new endpoint with month parameter
      final budget = await _budgetService.fetchMonthlyBudgetData(month: currentMonth);
      print(budget);

      // Update budget-related values
      monthlyBudget.value = budget.totalBudget;
      spentAmount.value = budget.totalExpense;
      spentPercentage.value = budget.totalPercentageUsed;
      leftAmount.value = budget.totalRemaining;
      leftPercentage.value = budget.totalPercentageLeft;

      // Update income and expense from budget data
      income.value = budget.totalIncome;
      expense.value = budget.totalExpense;
      availableBalance.value = budget.totalIncome - budget.totalExpense;

    } catch (e) {
      print('Error in fetchBudgetData: $e');
      // Error is already handled in BudgetService with Get.snackbar
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation methods
  void navigateToNotification() {
    Get.toNamed(AppRoutes.notification);
  }

  void navigateToMonthlyBudgetnonpro() {
    Get.toNamed(AppRoutes.monthlyBudgetNonPro);
  }

  void navigateToAddTransaction({required bool isExpense}) {
    Get.toNamed(AppRoutes.addTransaction!);
  }

  void navigateToAddProExpense() {
    // Implementation
  }

  void navigateToAddProIncome() {
    // Implementation
  }

  void shareExperience() {
    Get.toNamed(AppRoutes.shareExperience);
  }

  void viewAllTransactions() {
    Get.toNamed(AppRoutes.allTransactions, arguments: recentTransactions.toList());
  }

  void setStarRating(int rating) {
    starRating.value = rating == starRating.value ? 0 : rating;
  }

  void changeNavIndex(int index) {
    if (selectedNavIndex.value == index) return;

    selectedNavIndex.value = index;

    switch (index) {
      case 0: // Home
        if (Get.currentRoute != AppRoutes.mainHome) {
          Get.offAllNamed(AppRoutes.mainHome);
        }
        break;
      case 1: // Analytics
        Get.toNamed(AppRoutes.analytics);
        break;
      case 2: // Comparison
        Get.toNamed(AppRoutes.comparison);
        break;
      case 3: // Settings
        Get.toNamed(AppRoutes.settings);
        break;
    }
  }

  void logout() {
    selectedNavIndex.value = 0;
    Get.find<TokenService>().clearToken();
    Get.offAllNamed(AppRoutes.login);
  }

  void setNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void addTransaction(String title, String amount, bool isIncome) {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'pm'.tr : 'am'.tr;

    recentTransactions.insert(0, Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      type: isIncome ? 'income' : 'expense',
      amount: amount,
      time: 'today_time'.trParams({
        'hour': hour,
        'minute': minute,
        'period': period
      }),
    ));

    if (recentTransactions.length > 4) {
      recentTransactions.removeLast();
    }
  }
}