import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:your_expense/RegisterScreen/registration_api_service.dart';
import 'dart:convert';
import 'package:your_expense/services/api_base_service.dart';

class RegistrationController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  SharedPreferences? _prefs;


  var isTermsAccepted = false.obs;
  var isLoading = false.obs;
  final RegistrationApiService _registrationApiService = Get.find();

  void toggleTermsAccepted(bool? value) {
    if (value != null) {
      isTermsAccepted.value = value;
    }
  }

  Future<bool> registerUser() async {
    if (!validateForm()) return false;

    isLoading.value = true;

    try {
      final response = await _registrationApiService.registerUser({
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "preferredLanguage": "English",
        "contact": "",
        "role": "USER"
      });

      isLoading.value = false;

      if (response['success'] == true) {
        showSuccessSnackbar('Success'.tr, 'Registration successful'.tr);
        print(response['data']);

        // in Data variable we store token as named data
        String data= response['data'];
        await _prefs?.setString('auth_token', data);


        return true;
      } else {
        handleApiError(response);
        return false;
      }
    } on HttpException catch (e) {
      isLoading.value = false;
      if (e.statusCode == 400 || e.statusCode == 409) {
        try {
          final errorData = json.decode(e.message);
          handleApiError(errorData);
        } catch (parseError) {
          showErrorSnackbar('Registration Error'.tr, 'Failed to register. Please try again.'.tr);
        }
      } else {
        showErrorSnackbar('Registration Error'.tr, 'Failed to register. Please try again.'.tr);
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      showErrorSnackbar('Network Error'.tr, 'Please check your internet connection'.tr);
      return false;
    }
  }

  void handleApiError(Map<String, dynamic> response) {
    final errorMessage = response['message'] ?? 'Unknown error occurred';

    if (errorMessage.toString().toLowerCase().contains('email already exist')) {
      showErrorSnackbar('Registration Error'.tr, 'email_already_exists'.tr);
    } else if (response['errorMessages'] != null) {
      // Handle multiple validation errors
      final errors = response['errorMessages'] as List;
      if (errors.isNotEmpty) {
        final firstError = errors[0];
        final errorText = firstError['message'] ?? errorMessage;
        showErrorSnackbar('Validation Error'.tr, errorText.toString());
      } else {
        showErrorSnackbar('Registration Error'.tr, errorMessage.toString());
      }
    } else {
      showErrorSnackbar('Registration Error'.tr, errorMessage.toString());
    }
  }

  bool validateForm() {
    // Validate full name
    if (fullNameController.text.trim().isEmpty) {
      showErrorSnackbar('Validation Error'.tr, 'Please enter your full name'.tr);
      return false;
    }

    // Validate email
    if (emailController.text.trim().isEmpty) {
      showErrorSnackbar('Validation Error'.tr, 'Please enter your email address'.tr);
      return false;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text.trim())) {
      showErrorSnackbar('Validation Error'.tr, 'Please enter a valid email address'.tr);
      return false;
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      showErrorSnackbar('Validation Error'.tr, 'Please create a password'.tr);
      return false;
    }

    // Validate password length
    if (passwordController.text.length < 6) {
      showErrorSnackbar('Validation Error'.tr, 'Password must be at least 6 characters long'.tr);
      return false;
    }

    // Validate confirm password
    if (confirmPasswordController.text.isEmpty) {
      showErrorSnackbar('Validation Error'.tr, 'Please confirm your password'.tr);
      return false;
    }

    // Validate password match
    if (passwordController.text != confirmPasswordController.text) {
      showErrorSnackbar('Validation Error'.tr, 'Passwords do not match'.tr);
      return false;
    }

    return true;
  }

  void showErrorSnackbar(String title, String message) {
    final isDarkMode = Get.isDarkMode;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDarkMode ? Colors.red[800] : Colors.red[100],
      colorText: isDarkMode ? Colors.white : Colors.red[900],
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  void showSuccessSnackbar(String title, String message) {
    final isDarkMode = Get.isDarkMode;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDarkMode ? Colors.green[800] : Colors.green[100],
      colorText: isDarkMode ? Colors.white : Colors.green[900],
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isTermsAccepted.value = false;
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