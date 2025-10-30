import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Import all screens
import '../Analytics/expenses_screen.dart';
import '../Analytics/income_screen.dart';
import '../Analytics/main_analytics_screen.dart';
import '../Analytics/uplod_drive.dart';
import '../Comparison/ComparisonGraphScreen/amazon_purchase_details.dart';
import '../Comparison/ComparisonGraphScreen/graph_ui.dart';
import '../Comparison/Comparison_screen.dart';
import '../Comparison/NonProSavingsPage/nonproservicepageui.dart';
import '../Comparison/prosavingpage/proserviceui.dart';
import '../Facelogin/face_login.dart';
import '../RegisterScreen/reg_screen.dart';
import '../RegisterScreen/verification.dart' as reg_verification;
import '../Settings/userprofile/EmailVerificationScreen.dart' as profile_verification;
// Updated import
import '../Settings/appearance/appearance.dart';
// 🔥 New import for Language Settings
import '../Settings/applock/AppUnlockScreen.dart';
import '../Settings/applock/confirampin.dart';
import '../Settings/applock/setup_pin.dart';
import '../Settings/applock/setupfaceid.dart';
import '../Settings/applock/yourfaceissave.dart';
import '../Settings/currencyexchange.dart';
import '../Settings/language/languageui.dart';
import '../Settings/main_setting_screen.dart';
import '../Settings/notification/notificationscreen.dart';
import '../Settings/premium/paymentsuccessscreen.dart';
import '../Settings/premium/paymenttypetui.dart';
import '../Settings/premium/paymentui.dart';
import '../Settings/userprofile/PersonalInformationScreen.dart';
import '../Settings/userprofile/EditNameScreen.dart';
import '../Settings/userprofile/changeemail.dart';

import '../add_exp/category/add_category_ui.dart';
import '../add_exp/category/category_demo_screen.dart';
import '../add_exp/normaluser/normal_income_and_exp_screen.dart';
import '../add_exp/pro_user/expenseincomepro/proexpincome.dart';
import '../add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import 'package:your_expense/Analytics/income_controller.dart';
import '../faceidverification/face_verification_screen.dart';
import '../faceidverification/faceverificatio_for_reg/SignupfaceVerificationScreen.dart';
import '../faceidverification/faceverificatio_for_reg/face_confirmation_screen.dart';
import '../forget_password/forget_password_code/forget_password_screen.dart';
import '../forget_password/forget_password_email/forget_password_otp_screen.dart';
import '../forget_password/set_new_password/set_new_password_screen.dart';
import '../forget_password/set_new_password/set_new_password_screen_controller.dart';
import '../home/home_ui.dart';
import '../homepage/edit/MonthlyBudgetNonPro/MonthlyBudgetNonPro.dart';
import '../homepage/edit/edit_ui.dart';

import '../homepage/notification/notification_ui.dart';
import '../homepage/share_exp/share_exp_screen.dart';
import '../homepage/view all/view_ui.dart';

import '../login/login_ui.dart';
import '../make it pro/AdvertisementPage/Totalsaving_add.dart';
import '../make it pro/AdvertisementPage/add_ui.dart';
import '../onbaording/onboarding_ui/onboarding_screen.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';
// Added: MonthlyBudgetController for binding when navigating via route
import '../homepage/model_and _controller_of_monthlybudgetpage/monthly_budget_controller.dart';
// Added: MarketplaceService to ensure registration in comparison route
import '../Comparison/MarketplaceService.dart';

class AppRoutes {
  static const String initial = '/initial';
  static const String login = '/login';
  static const String faceLogin = '/faceLogin';
  static const String register = '/register';
  static const String emailVerification = '/emailVerification';
  static const String signupVerification = '/signupVerification';
  static const String faceVerification = '/faceVerification';
  static const String faceConfirmation = '/faceConfirmation';
  static const String termsConditions = '/termsConditions';
  static const String forgetPassword = '/forgetPassword';
  static const String otpVerification = '/otpVerification';
  static const String setNewPassword = '/setNewPassword';

  // Main App Routes
  static const String mainHome = '/mainHome';
  static const String analytics = '/analytics';
  static const String settings = '/settings';
  static const String personalInformation = '/personalInformation';
  static const String editName = '/editName';
  static const String changeEmail = '/changeEmail';
  static const String emailChangeVerification = '/emailChangeVerification';
  static const String premiumPlans = '/premiumPlans';
  static const String notificationSettings = '/notificationSettings';
  static const String appUnlock = '/appUnlock';
  static const String setPin = '/setPin';
  static const String confirmPin = '/confirmPin';
  static const String setupFaceID = '/setupFaceID';
  static const String faceAuthentication = '/faceAuthentication';
  static const String appearance = '/appearance';
  static const String languageSettings = '/languageSettings'; // 🔥 New route constant

  // Transaction Related Routes
  static const String addTransaction = '/addTransaction';
  static const String proExpensesIncome = '/proExpensesIncome';
  static const String addCategory = '/addCategory';
  static const String categoryDemo = '/categoryDemo';
  static const String advertisement = '/advertisement';
  static const String totalSavingAdvertisement = '/totalSavingAdvertisement';

  // Homepage Routes
  static const String notification = '/notification';
  static const String editBudget = '/editBudget';
  static const String monthlyBudget = '/monthlyBudget';
  static const String monthlyBudgetNonPro = '/monthlyBudgetNonPro';
  static const String shareExperience = '/shareExperience';
  static const String allTransactions = '/allTransactions';

  // Analytics Routes
  static const String expensesScreen = '/expensesScreen';
  static const String incomeScreen = '/incomeScreen';
  static const String uploadToDrive = '/uploadToDrive';

  // Comparison Routes
  static const String comparison = '/comparison';
  static const String comparisonGraph = '/comparisonGraph';
  static const String amazonPurchaseDetails = '/amazonPurchaseDetails';
  static const String nonProSavings = '/nonProSavings';
  static const String proSavings = '/proSavings';
  static const String paymentScreen = '/paymentScreen';
  static const String paymentSuccess = '/paymentSuccess';
  static const String currencyChange = '/currencyChange';

  static final routes = [
    // Authentication Routes
    GetPage(name: initial, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: faceLogin, page: () => FaceLoginScreen()),
    GetPage(name: register, page: () => RegistrationScreen()),
    GetPage(name: emailVerification, page: () => reg_verification.EmailVerificationScreen()),
    GetPage(name: signupVerification, page: () => SignupVerificationScreen()),
    GetPage(name: faceVerification, page: () => FaceVerificationScreen()),
    GetPage(name: faceConfirmation, page: () => FaceConfirmationScreen()),
    GetPage(name: termsConditions, page: () => const TermsAndConditionsScreen()),
    GetPage(name: forgetPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: otpVerification, page: () => OtpVerificationScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPasswordScreen()),

    // Main App Routes
    GetPage(name: mainHome, page: () => MainHomeScreen(), transition: Transition.noTransition),
    GetPage(name: analytics, page: () => AnalyticsScreen(), transition: Transition.noTransition),
    GetPage(name: settings, page: () => SettingsScreen(), transition: Transition.noTransition),
    GetPage(name: personalInformation, page: () => PersonalInformationScreen()),
    GetPage(name: editName, page: () => EditNameScreen()),
    GetPage(name: changeEmail, page: () => ChangeEmailScreen()),
    GetPage(name: emailChangeVerification, page: () => profile_verification.EmailVerificationScreen()),
    GetPage(name: premiumPlans, page: () => PremiumPlansScreen()),
    GetPage(name: notificationSettings, page: () => NotificationSettingsScreen()),
    GetPage(name: appUnlock, page: () => AppUnlockScreen()),
    GetPage(name: setPin, page: () => SetPinScreen()),
    GetPage(name: confirmPin, page: () => ConfirmPinScreen()),
    GetPage(name: setupFaceID, page: () => SetupFaceIDScreen()),
    GetPage(name: faceAuthentication, page: () => FaceAuthenticationScreen()),
    GetPage(name: appearance, page: () => const AppearanceScreen()),
    GetPage(name: languageSettings, page: () => const LanguageSettingsScreen()), // 🔥 New route

    // Transaction Routes
    GetPage(
      name: proExpensesIncome,
      page: () => const ProExpensesIncomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProExpensesIncomeController>(() => ProExpensesIncomeController());
      }),
    ),
    GetPage(
      name: addCategory,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final bool isExpense = args?['isExpense'] ?? true;
        return AddCategoryScreen(isExpense: isExpense);
      },
    ),
    GetPage(name: categoryDemo, page: () => CategoryDemoScreen()),
    GetPage(
      name: advertisement,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final bool isFromExpense = args?['isFromExpense'] ?? true;
        return AdvertisementPage(isFromExpense: isFromExpense);
      },
    ),
    GetPage(
      name: totalSavingAdvertisement,
      page: () => const TotalSavingAdvertisement(),
    ),

    // Homepage Routes
    GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(
      name: monthlyBudget,
      page: () => MonthlyBudgetScreen(),
      binding: BindingsBuilder(() {
        // Ensure MonthlyBudgetController is available when navigating via this route
        if (!Get.isRegistered<MonthlyBudgetController>()) {
          Get.lazyPut<MonthlyBudgetController>(() => MonthlyBudgetController());
        }
      }),
    ),
    GetPage(name: monthlyBudgetNonPro, page: () => const MonthlyBudgetNonPro()),
    GetPage(name: shareExperience, page: () =>  RateAndImproveScreen()),
    GetPage(name: allTransactions, page: () => const AllTransactionsScreen()),

    // Analytics Routes
    GetPage(name: expensesScreen, page: () => ExpenseListScreen()),
    GetPage(name: incomeScreen, page: () => IncomeListScreen(), binding: BindingsBuilder(() { Get.lazyPut<IncomeController>(() => IncomeController()); })),
    GetPage(name: uploadToDrive, page: () => UploadToDriveScreen()),

    // Comparison Routes
    GetPage(
      name: comparison,
      page: () => const ComparisonPageScreen(isFromExpense: true),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        // Ensure MarketplaceService is available for ComparisonPageController
        if (!Get.isRegistered<MarketplaceService>()) {
          Get.lazyPut<MarketplaceService>(() => MarketplaceService());
        }
      }),
    ),
    GetPage(
      name: comparisonGraph,
      page: () => const ComparisonGraphScreen(),
    ),
    GetPage(
      name: amazonPurchaseDetails,
      page: () => const AmazonPurchaseDetailsScreen(),
    ),
    GetPage(name: nonProSavings, page: () => NonProSavingsPage()),
    GetPage(name: proSavings, page: () => ProSavingsPage()),
    GetPage(name: paymentScreen, page: () => PaymentScreen()),
    GetPage(name: paymentSuccess, page: () => PaymentSuccessScreen()),
    GetPage(name: currencyChange, page: () => CurrencyExchangeScreen()),
    GetPage(name: addTransaction, page: () => AddTransactionScreen()),
  ];
}