import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/colors/app_colors.dart';
import 'package:your_expense/routes/app_routes.dart';
import 'package:your_expense/text_styles.dart';

class ForgotPasswordScreen extends StatelessWidget {

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
              const SizedBox(height: 16),
              // App bar with back button and title
              Row(
                children: [
                  IconButton(
                    icon: Image.asset('assets/icons/arrow-left.png'),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 55),
                  Text(
                    'Forget password',  // First occurrence - in app bar
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: AppColors.text800,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Centered Lock Icon with title below it
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/lock_.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Forget password',  // Second occurrence - below lock
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.text800,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Email/Phone Input Field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email or phone number',
                  hintStyle: AppTextStyles.inputHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.text200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary500),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: AppTextStyles.inputText,
              ),

              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Image.asset(
                      'assets/icons/warning.png',
                      width: 16,
                      height: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You may receive notifications via SMS or email from us for security and login purposes.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.text500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.otpVerification),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.2,
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