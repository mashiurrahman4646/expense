// lib/RegisterScreen/reg_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isTermsAccepted = false.obs;

  void toggleTermsAccepted(bool? value) {
    if (value != null) {
      isTermsAccepted.value = value;
    }
  }

  bool validateForm() {
    // Validate full name
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your full name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    // Validate email
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please create a password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    // Validate password length
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Validation Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    // Validate confirm password
    if (confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please confirm your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    // Validate password match
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Validation Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}