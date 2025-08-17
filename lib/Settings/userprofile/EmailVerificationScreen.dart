import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'PersonalInformationScreen.dart';

class EmailVerificationScreen extends StatelessWidget {
  final List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: screenWidth * 0.05,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Verification',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.08),

              // Lock Icon
              Container(
                width: screenWidth * 0.18,
                height: screenWidth * 0.18,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: screenWidth * 0.09,
                  color: const Color(0xFF2196F3),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Title
              Text(
                'Verification code',
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Description
              Text(
                'We\'ve sent a verification code',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Enter six digit code label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter six digit code',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Timer
              Text(
                'Code expires in: 02:59',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t get any code? ',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      for (var controller in otpControllers) {
                        controller.clear();
                      }
                      Get.snackbar(
                        'Code Resent',
                        'A new verification code has been sent',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFF2196F3),
                        colorText: Colors.white,
                      );
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF2196F3),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.08),

              // Submit Button
              Container(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    // Get the entered OTP
                    String enteredOTP = otpControllers.map((controller) => controller.text).join();

                    // Check if all fields are filled
                    if (enteredOTP.length == 6) {
                      // Navigate to Personal Information Screen
                      Get.off(() => PersonalInformationScreen());
                    } else {
                      // Show error message
                      Get.snackbar(
                        'Incomplete Code',
                        'Please enter the complete 6-digit verification code',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}