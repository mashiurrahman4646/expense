import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:your_expense/colors/app_colors.dart';
import 'package:your_expense/routes/app_routes.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onSubmit() {
    String otpCode = _controllers.map((c) => c.text).join();
    if (otpCode.length == 6) {
      print('Entered OTP: $otpCode');
      // Simulate OTP validation (replace with actual validation logic)
      Get.offNamed(AppRoutes.setNewPassword); // Navigate to Set New Password screen
    } else {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Lock Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary500.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 40,
                  color: AppColors.primary500,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Verification code',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: AppColors.text800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We\'ve sent a verification code',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.text500,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter six digit code',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.text700,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 48,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _focusNodes[index].hasFocus
                            ? AppColors.primary500
                            : AppColors.text200,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.text800,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          } else {
                            _focusNodes[index].unfocus(); // Unfocus last field
                          }
                        } else {
                          if (index > 0) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index - 1]);
                          }
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              Text(
                'Code expires in: 02:59',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.text600,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t get any code? ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.text600,
                      height: 1.4,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement resend logic here
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.primary500,
                        height: 1.4,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit',
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

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Get.offNamed(AppRoutes.register);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.text300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Back to sign in',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.text700,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}