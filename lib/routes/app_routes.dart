import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:your_expense/colors/app_colors.dart';
import '../Facelogin/face_login.dart';
import '../RegisterScreen/reg_screen.dart';
import '../faceidverification/face_verification_screen.dart';
import '../faceidverification/faceverificatio_for_reg/SignupfaceVerificationScreen.dart';
import '../faceidverification/faceverificatio_for_reg/face_confirmation_screen.dart';
import '../forget_password/forget_password_code/forget_password_screen.dart';
import '../forget_password/forget_password_email/forget_password_otp_screen.dart';
import '../forget_password/set_new_password/set_new_password_screen_controller.dart';
import '../login/login_ui/login_screen.dart';
import '../onbaording/onboarding_ui/onboarding_screen.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';
 // Ensure this import matches your file structure

class AppRoutes {
  static const initial = '/onboarding';
  static const login = '/login';
  static const faceLogin = '/faceLogin';
  static const signupVerification = '/signupVerification';
  static const faceVerification = '/faceVerification';
  static const register = '/register';
  static const termsConditions = '/termsConditions';
  static const faceConfirmation = '/faceConfirmation';
  static const forgetPassword = '/forgetPassword';
  static const otpVerification = '/otpVerification';
  static const setNewPassword = '/setNewPassword';

  static final routes = [
    GetPage(name: initial, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: faceLogin, page: () => FaceLoginScreen()),
    GetPage(name: signupVerification, page: () => SignupVerificationScreen()),
    GetPage(name: faceVerification, page: () => FaceVerificationScreen()),
    GetPage(name: register, page: () => RegistrationScreen()),
    GetPage(name: termsConditions, page: () => const TermsAndConditionsScreen()),
    GetPage(name: faceConfirmation, page: () => FaceConfirmationScreen()),
    GetPage(name: forgetPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: otpVerification, page: () => OtpVerificationScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPasswordScreen()),
  ];
}