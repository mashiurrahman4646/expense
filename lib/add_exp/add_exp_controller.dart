import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  var isExpenseSelected = true.obs;
  var selectedCategory = ''.obs;
  var selectedPaymentMethod = ''.obs;
  var amountController = TextEditingController();

  void toggleTransactionType(bool isExpense) {
    isExpenseSelected.value = isExpense;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void addTransaction() {
    if (amountController.text.isEmpty ||
        selectedCategory.value.isEmpty ||
        selectedPaymentMethod.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Transaction added successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
    );
    Get.back();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
