import 'package:get/get.dart';
import '../routes/app_routes.dart';

class HomeController extends GetxController {
  var selectedNavIndex = 0.obs;
  var starRating = 0.obs;

  var availableBalance = 15000.obs;
  var income = 700.obs;
  var expense = 500.obs;
  var savings = 100.obs;

  var monthlyBudget = 15000.obs;
  var spentAmount = 1400.obs;
  var spentPercentage = 75.obs;
  var leftAmount = 1000.obs;
  var leftPercentage = 15.obs;

  var recentTransactions = <Map<String, dynamic>>[
    {'title': 'Salary Deposit', 'time': 'Today, 04:12 AM', 'amount': '3,500.00', 'isIncome': true},
    {'title': 'Food', 'time': 'Today, 04:12 AM', 'amount': '150.00', 'isIncome': false},
    {'title': 'Shopping', 'time': 'Today, 04:12 AM', 'amount': '200.00', 'isIncome': false},
    {'title': 'Transport', 'time': 'Today, 04:12 AM', 'amount': '50.00', 'isIncome': false},
  ].obs;

  String getCurrentMonth() {
    final now = DateTime.now();
    const months = ['January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'];
    return months[now.month - 1];
  }

  // Navigation methods
  void navigateToNotification() {
    Get.toNamed(AppRoutes.notification);
  }

  void navigateToMonthlyBudget() {
    Get.toNamed(AppRoutes.monthlyBudget);
  }

  void navigateToAddTransaction() {
    Get.toNamed(AppRoutes.addTransaction);
  }

  // This is the updated method that navigates to the new screen.
  void shareExperience() {
    Get.toNamed(AppRoutes.shareExperience);
  }

  void viewAllTransactions() {
    Get.toNamed(AppRoutes.allTransactions);
  }

  void setStarRating(int rating) {
    starRating.value = rating == starRating.value ? 0 : rating;
  }

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
    switch (index) {
      case 0: // Home
        break;
      case 1: // Analytics
        Get.toNamed(AppRoutes.analytics)?.then((_) => selectedNavIndex.value = 0);
        break;
      case 2: // Comparison
        Get.toNamed(AppRoutes.comparison)?.then((_) => selectedNavIndex.value = 0);
        break;
      case 3: // Settings
        Get.toNamed(AppRoutes.settings)?.then((_) => selectedNavIndex.value = 0);
        break;
    }
  }

  void addTransaction(String title, String amount, bool isIncome) {
    recentTransactions.insert(0, {
      'title': title,
      'time': 'Today, ${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}',
      'amount': amount,
      'isIncome': isIncome,
    });
    if (recentTransactions.length > 4) {
      recentTransactions.removeLast();
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedNavIndex.value = 0;
  }
}
