import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:your_expense/routes/app_routes.dart';
import 'package:your_expense/text_styles.dart';

import '../../colors/app_colors.dart';

class LoginScreen extends StatelessWidget {
  final RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Back',
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: 8),
              Text(
                'Login to your account',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.text500,
                ),
              ),
              const SizedBox(height: 40),

              // Email Field
              Text('Email', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: AppTextStyles.inputHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.text200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary500),
                  ),
                ),
                style: AppTextStyles.inputText,
              ),
              const SizedBox(height: 20),

              // Password Field
              Text('Password', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              Obx(() => TextField(
                obscureText: !isPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: AppTextStyles.inputHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.text200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary500),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.text400,
                    ),
                    onPressed: () => isPasswordVisible.toggle(),
                  ),
                ),
                style: AppTextStyles.inputText,
              )),
              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Login', style: AppTextStyles.buttonLarge),
                ),
              ),
              const SizedBox(height: 16),

              // Face Login
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.faceLogin);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppColors.text200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/face.png', width: 24, height: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Login with Face ID',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Register Link
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.text500,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}