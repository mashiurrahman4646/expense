import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Facelogin/face_login.dart';

import '../RegisterScreen/reg_screen.dart';
import '../faceidverification/face_verification_screen.dart';
import '../faceidverification/faceverificatio_for_reg/SignupfaceVerificationScreen.dart';
import '../faceidverification/faceverificatio_for_reg/face_confirmation_screen.dart';
import '../login/login_ui/login_screen.dart';
import '../onbaording/onboarding_ui/onboarding_screen.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';

class AppRoutes {
  static const initial = '/onboarding';
  static const login = '/login';
  static const faceLogin = '/faceLogin';
  static const signupVerification = '/signupVerification';
  static const faceVerification = '/faceVerification';
  static const register = '/register';
  static const termsConditions = '/termsConditions';
  static const faceConfirmation = '/faceConfirmation';

  static final routes = [
    GetPage(name: initial, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: faceLogin, page: () => FaceLoginScreen()),
    GetPage(name: signupVerification, page: () => SignupVerificationScreen()),
    GetPage(name: faceVerification, page: () => FaceVerificationScreen()),
    GetPage(name: register, page: () => RegistrationScreen()),
    GetPage(name: termsConditions, page: () => const TermsAndConditionsScreen()),
    GetPage(name: faceConfirmation, page: () => FaceConfirmationScreen()),
  ];
}