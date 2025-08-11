// lib/faceidverification/face_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import '../text_styles.dart';

class FaceVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow-left.png',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Set Your Face ID',
          style: AppTextStyles.heading2.copyWith(color: const Color(0xFF000000)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Updated Progress Indicator for 3 steps
            _buildProgressIndicator(context),
            SizedBox(height: 32),
            Text(
              'Secure your account with Face ID authentication. Quickly log in without typing your password every time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 32),
            // Clickable Face ID Image
            GestureDetector(
              onTap: () {
                // Navigate to main home after face verification setup
                _handleFaceVerification();
              },
              child: Image.asset(
                'assets/images/face-id.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 32),
            // Setup Face ID Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _handleFaceVerification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Setup Face ID',
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Skip face verification and go to main home
                  Get.offAllNamed('/mainHome');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: 32,
          child: Stack(
            children: [
              // Background line
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
              // Progress line (completed steps)
              Positioned(
                top: 15,
                left: 0,
                child: Container(
                  width: screenWidth * 0.75, // Show progress to step 3
                  height: 2,
                  color: AppColors.primary500,
                ),
              ),
              // Step 1 Circle (Registration - Completed)
              Positioned(
                left: (screenWidth * 0.15) - 12,
                top: 4,
                child: _buildStepCircle(1, true),
              ),
              // Step 2 Circle (Email Verification - Completed)
              Positioned(
                left: (screenWidth * 0.5) - 12,
                top: 4,
                child: _buildStepCircle(2, true),
              ),
              // Step 3 Circle (Face Verification - Active)
              Positioned(
                left: (screenWidth * 0.85) - 12,
                top: 4,
                child: _buildStepCircle(3, true),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth * 0.25,
              child: const Text(
                'Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              child: const Text(
                'Verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'Face ID',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primary500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary500 : Colors.grey[400],
        shape: BoxShape.circle,
        border: Border.all(
            color: AppColors.primary500,
            width: 2
        ),
      ),
      child: Center(
        child: Text(
          stepNumber.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _handleFaceVerification() {
    // Show loading dialog
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: AppColors.primary500,
        ),
      ),
      barrierDismissible: false,
    );

    // Simulate face verification setup
    Future.delayed(Duration(seconds: 2), () {
      Get.back(); // Close loading dialog

      // Show success message
      Get.snackbar(
        'Success',
        'Face ID has been set up successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
        margin: const EdgeInsets.all(12),
      );

      // Navigate to main home screen
      Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed('/signupVerification');
      });
    });
  }
}