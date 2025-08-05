// lib/RegisterScreen/reg_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/RegisterScreen/reg_controller.dart';
import '../colors/app_colors.dart';
import '../login/login_ui/login_screen.dart';
import '../text_styles.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

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
          'Registration',
          style: AppTextStyles.heading2.copyWith(color: const Color(0xFF000000)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProgressIndicator(context),
            const SizedBox(height: 32),
            _buildTextField(
              label: 'Full Name',
              hintText: 'Enter your full name',
              controller: controller.fullNameController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email Address',
              hintText: 'example@gmail.com',
              controller: controller.emailController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Password',
              hintText: 'Create a password',
              isPassword: true,
              controller: controller.passwordController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Confirm Password',
              hintText: 'Re-enter your password',
              isPassword: true,
              controller: controller.confirmPasswordController,
            ),
            const SizedBox(height: 24),
            Obx(() => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.isTermsAccepted.value,
              onChanged: controller.toggleTermsAccepted,
              activeColor: AppColors.primary500,
              title: Text(
                'I accept the Terms and Conditions',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.text700),
              ),
            )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (!controller.isTermsAccepted.value) {
                    Get.snackbar(
                      'Terms Required',
                      'You need to accept the terms and conditions to create an account.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red[100],
                      colorText: Colors.red[900],
                      margin: const EdgeInsets.all(12),
                    );
                    return;
                  }

                  print("Continue button pressed and terms accepted");
                  Get.toNamed('/faceVerification');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Get.to(() => LoginScreen()),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Get.to(() => const TermsAndConditionsScreen());
              },
              child: Text.rich(
                TextSpan(
                  text: 'By creating an account or signing you agree to our ',
                  style: AppTextStyles.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
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
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
              Positioned(
                top: 15,
                left: 0,
                child: Container(
                  width: screenWidth * 0.5,
                  height: 2,
                  color: AppColors.primary500,
                ),
              ),
              Positioned(
                left: (screenWidth * 0.2) - 12,
                top: 4,
                child: _buildStepCircle(1, true),
              ),
              Positioned(
                left: (screenWidth * 0.7) - 12,
                top: 4,
                child: _buildStepCircle(2, false),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: screenWidth * 0.4,
              child: const Text(
                'Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              width: screenWidth * 0.3,
              child: Text(
                'FaceID',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: AppColors.text700,
            height: 1.0,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: AppColors.text000,
              height: 1.0,
              letterSpacing: 0.0,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
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
}