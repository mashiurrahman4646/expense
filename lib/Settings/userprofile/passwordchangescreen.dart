import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../appearance/ThemeController.dart';
import '../../services/api_base_service.dart';
import '../../services/config_service.dart';
import 'package:your_expense/Settings/userprofile/profile_services.dart';

class PasswordChangeScreen extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();
  final ApiBaseService apiService = Get.find<ApiBaseService>();
  final ConfigService configService = Get.find<ConfigService>();
  final ProfileService profileService = Get.find<ProfileService>();
  final RxBool isLoading = false.obs;
  final RxBool isOtpSent = true.obs;

  PasswordChangeScreen({super.key}); // OTP is already sent before navigating

  Future<void> _resendOtp() async {
    try {
      isLoading.value = true;
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final success = await profileService.sendOtp();

      Get.back();
      isLoading.value = false;

      if (success) {
        Get.snackbar(
          'otp_resent'.tr,
          'otp_resent_message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: themeController.isDarkModeActive
              ? Color(0xFF2D2D2D)
              : Color(0xFF2196F3),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'error'.tr,
          'otp_resend_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back();
      isLoading.value = false;
      Get.snackbar(
        'error'.tr,
        'otp_resend_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('❌ OTP Resend Error: $e');
    }
  }

  Future<void> _changePassword() async {
    try {
      isLoading.value = true;
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
        Get.back();
        isLoading.value = false;
        Get.snackbar(
          'error'.tr,
          'fill_all_fields'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (newPasswordController.text != confirmPasswordController.text) {
        Get.back();
        isLoading.value = false;
        Get.snackbar(
          'error'.tr,
          'password_mismatch'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (otpController1.text.isEmpty || otpController2.text.isEmpty || otpController3.text.isEmpty || otpController4.text.isEmpty) {
        Get.back();
        isLoading.value = false;
        Get.snackbar(
          'error'.tr,
          'fill_all_otp_fields'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final otp = int.parse('${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}');

      final success = await profileService.updatePassword(newPasswordController.text, otp);

      Get.back();
      isLoading.value = false;

      if (success) {
        Get.snackbar(
          'password_changed'.tr,
          'password_changed_message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: themeController.isDarkModeActive
              ? Color(0xFF2D2D2D)
              : Color(0xFF2196F3),
          colorText: Colors.white,
        );

        Get.offAllNamed('/settings/personal-information');
      } else {
        Get.snackbar(
          'error'.tr,
          'password_change_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back();
      isLoading.value = false;
      Get.snackbar(
        'error'.tr,
        'password_change_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('❌ Password Change Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: themeController.isDarkModeActive ? Color(0xFF121212) : Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            size: screenWidth * 0.05,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'change_password'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
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

              // Password Icon
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  color: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : const Color(0xFF2196F3).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outlined,
                  size: screenWidth * 0.08,
                  color: const Color(0xFF2196F3),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Description Text
              Text(
                'password_change_description'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: themeController.isDarkModeActive ? Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),

              SizedBox(height: screenHeight * 0.06),

              // New Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'new_password'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'enter_new_password'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade400,
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: const Color(0xFF2196F3)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // Confirm Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'confirm_password'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'confirm_new_password'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade400,
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: const Color(0xFF2196F3)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // OTP Input Fields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'enter_otp'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOtpField(otpController1, screenWidth, screenHeight, themeController.isDarkModeActive),
                      _buildOtpField(otpController2, screenWidth, screenHeight, themeController.isDarkModeActive),
                      _buildOtpField(otpController3, screenWidth, screenHeight, themeController.isDarkModeActive),
                      _buildOtpField(otpController4, screenWidth, screenHeight, themeController.isDarkModeActive),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: _resendOtp,
                    child: Text(
                      'dont_get_code_resend'.tr,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF2196F3),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'submit'.tr,
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

  Widget _buildOtpField(
      TextEditingController controller,
      double screenWidth,
      double screenHeight,
      bool isDarkMode,
      ) {
    return SizedBox(
      width: screenWidth * 0.15,
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: screenWidth * 0.05,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            borderSide: BorderSide(color: isDarkMode ? Color(0xFF3A3A3A) : Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            borderSide: BorderSide(color: isDarkMode ? Color(0xFF3A3A3A) : Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            borderSide: BorderSide(color: const Color(0xFF2196F3)),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(Get.context!).nextFocus();
          }
        },
      ),
    );
  }
}