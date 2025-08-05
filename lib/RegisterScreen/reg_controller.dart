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

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
