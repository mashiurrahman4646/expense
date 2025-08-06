import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedNavIndex = 0.obs; // Default to Home
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
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'];
    return months[now.month - 1];
  }

  void navigateToNotification() {
    Get.toNamed('/notification');
  }

  void navigateToEditBudget() {
    Get.toNamed('/editBudget');
  }

  void navigateToAddTransaction() {
    Get.toNamed('/addTransaction');
  }

  void shareExperience() {
    Get.toNamed('/shareExperience');
  }

  void viewAllTransactions() {
    Get.toNamed('/allTransactions');
  }

  void setStarRating(int rating) {
    starRating.value = rating == starRating.value ? 0 : rating; // Toggle to 0 if same star, otherwise set new rating
  }

  // FIXED: Proper navigation index handling
  void changeNavIndex(int index) {
    selectedNavIndex.value = index;

    switch (index) {
      case 0:
      // Stay on home, just update index
        break;
      case 1:
        Get.toNamed('/analytics')?.then((_) {
          // Reset to home index when returning from analytics
          selectedNavIndex.value = 0;
        });
        break;
      case 2:
        Get.toNamed('/comparison')?.then((_) {
          // Reset to home index when returning from comparison
          selectedNavIndex.value = 0;
        });
        break;
      case 3:
        Get.toNamed('/settings')?.then((_) {
          // Reset to home index when returning from settings
          selectedNavIndex.value = 0;
        });
        break;
    }
  }

  // FIXED: Method to set nav index from external pages
  void setNavIndex(int index) {
    selectedNavIndex.value = index;
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
    selectedNavIndex.value = 0; // Default to Home on init
  }

  @override
  void onReady() {
    super.onReady();
    // Ensure we're on the home tab when this controller is ready
    selectedNavIndex.value = 0;
  }

  // FIXED: Add method to handle back navigation
  @override
  void onClose() {
    super.onClose();
  }

  // Method to be called when returning to home from other pages
  void returnToHome() {
    selectedNavIndex.value = 0;
  }
}