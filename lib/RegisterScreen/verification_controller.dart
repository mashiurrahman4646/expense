import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'verification_api_service.dart';

class VerificationController extends GetxController {
  final VerificationApiService verificationApiService = Get.find();
  final String? email = Get.arguments?['email'];

  List<TextEditingController> otpControllers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  var isVerifyEnabled = false.obs;
  var canResend = true.obs;
  var resendCountdown = 60.obs; // 60 seconds countdown

  @override
  void onInit() {
    super.onInit();

    if (email == null || email!.isEmpty) {
      Get.snackbar(
        'Error',
        'No email provided. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      Future.delayed(Duration(seconds: 1), () => Get.back());
    }

    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() {
        checkVerifyButtonState();
      });
    }

    // Start resend countdown
    startResendCountdown();
  }

  void startResendCountdown() {
    canResend.value = false;
    resendCountdown.value = 60;

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(Get.context!).nextFocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(Get.context!).previousFocus();
      }
    }
    checkVerifyButtonState();
  }

  void checkVerifyButtonState() {
    bool allFilled = otpControllers.every((controller) => controller.text.isNotEmpty);
    isVerifyEnabled.value = allFilled;
  }

  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOtp() async {
    if (email == null || email!.isEmpty) {
      Get.snackbar(
        'Error',
        'No email provided. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    String otpCode = getOtpCode();
    print('🔐 Verifying OTP: $otpCode for email: $email');

    if (otpCode.length == 4) {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: const Color(0xFF4A90E2),
          ),
        ),
        barrierDismissible: false,
      );

      try {
        int otpNumber;
        try {
          otpNumber = int.parse(otpCode);
          print('🔄 Converted OTP to number: $otpNumber');
        } catch (e) {
          Get.back();
          Get.snackbar(
            'Invalid Code',
            'Please enter a valid numeric code.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[100],
            colorText: Colors.red[900],
            margin: const EdgeInsets.all(12),
          );
          return;
        }

        final response = await verificationApiService.verifyEmail(email!, otpNumber);

        print('📨 API Response: ${response.success} - ${response.message}');

        Get.back();

        if (response.success) {
          print('✅ Verification successful, navigating to face verification');
          Get.snackbar(
            'Success',
            'Email verified successfully!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green[100],
            colorText: Colors.green[900],
            margin: const EdgeInsets.all(12),
          );

          await Future.delayed(Duration(milliseconds: 500));
          Get.offNamed('/faceVerification');
        } else {
          String errorMessage = response.message;
          if (response.errorMessages != null && response.errorMessages!.isNotEmpty) {
            errorMessage = response.errorMessages!.first.message;
          }

          Get.snackbar(
            'Error',
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[100],
            colorText: Colors.red[900],
            margin: const EdgeInsets.all(12),
          );
        }
      } catch (e) {
        Get.back();
        print('❌ Verification error: $e');

        String errorMessage = 'Failed to verify OTP';
        if (e.toString().contains('Expected number')) {
          errorMessage = 'Server expects numeric OTP code';
        }

        Get.snackbar(
          'Error',
          '$errorMessage: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          margin: const EdgeInsets.all(12),
        );
      }
    } else {
      Get.snackbar(
        'Invalid Code',
        'Please enter a valid 4-digit verification code.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
    }
  }

  Future<void> resendCode() async {
    if (!canResend.value) return;

    if (email == null || email!.isEmpty) {
      Get.snackbar(
        'Error',
        'No email provided. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: const Color(0xFF4A90E2),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final response = await verificationApiService.resendOtp(email!);

      Get.back();

      if (response.success) {
        for (var controller in otpControllers) {
          controller.clear();
        }

        Get.snackbar(
          'Code Sent',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue[100],
          colorText: Colors.blue[900],
          margin: const EdgeInsets.all(12),
        );

        checkVerifyButtonState();
        startResendCountdown(); // Restart countdown
      } else {
        String errorMessage = response.message;
        if (response.errorMessages != null && response.errorMessages!.isNotEmpty) {
          errorMessage = response.errorMessages!.first.message;
        }

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          margin: const EdgeInsets.all(12),
        );

        canResend.value = true; // Allow resend on error
      }
    } catch (e) {
      Get.back();
      print('❌ Resend OTP error: $e');

      String errorMessage = 'Failed to resend OTP';
      if (e.toString().contains('Expected number')) {
        errorMessage = 'Server configuration error';
      }

      Get.snackbar(
        'Error',
        '$errorMessage: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );

      canResend.value = true; // Allow resend on error
    }
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}