import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../homepage/main_home_page_controller.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          'Setting',
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
              SizedBox(height: screenHeight * 0.03),
              // Profile Section
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.22,
                    height: screenWidth * 0.22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.11),
                      child: Image.asset(
                        'assets/images/Ellipse 5.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),

              // Settings Options
              _buildSettingsItem(
                'User Profile',
                'Change profile image, name or password',
                'assets/icons/user.png',
                    () => Get.toNamed(AppRoutes.personalInformation),
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'Premium Plans',
                'Upgrade to unlock premium features',
                'assets/icons/PremiumPlans.png',
                    () => Get.toNamed(AppRoutes.premiumPlans),
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'Notification Setting',
                'Manage push notifications and alerts',
                'assets/icons/NotificationSetting.png',
                    () => Get.toNamed(AppRoutes.notificationSettings),
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'Language',
                'Change your preferred language',
                'assets/icons/Language.png',
                    () => Get.toNamed(AppRoutes.languageSettings), // 🔥 Updated: Navigate to Language Settings
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'App Unlock',
                '6 digits pin, faceid or none',
                'assets/icons/AppUnlock.png',
                    () => Get.toNamed(AppRoutes.appUnlock),
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'Appearance',
                'Change white & dark theme',
                'assets/icons/Appearance.png',
                    () => Get.toNamed(AppRoutes.appearance),
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'Currency Change',
                'Change your currency',
                'assets/icons/Currency.png',
                    () => Get.toNamed(AppRoutes.currencyChange),
                screenWidth,
                screenHeight,
              ),
              _buildSettingsItem(
                'Terms & Conditions',
                'Read terms & conditions before use',
                'assets/icons/Terms & Conditions.png',
                    () => Get.toNamed(AppRoutes.termsConditions),
                screenWidth,
                screenHeight,
              ),

              SizedBox(height: screenHeight * 0.05),

              // Logout Button
              Container(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: OutlinedButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          'Logout',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              Get.offAllNamed(AppRoutes.login);
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color(0xFF2196F3), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: const Color(0xFF2196F3),
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
      bottomNavigationBar: Obx(() => Container(
        height: screenHeight * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, 'assets/icons/home (2).png', 'Home', screenWidth, homeController),
            _buildNavItem(1, 'assets/icons/analysis.png', 'Analytics', screenWidth, homeController),
            GestureDetector(
              onTap: () => homeController.navigateToAddTransaction(isExpense: true),
              child: Container(
                width: screenWidth * 0.14,
                height: screenWidth * 0.14,
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/plus.png',
                    width: screenWidth * 0.06,
                    height: screenWidth * 0.06,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            _buildNavItem(2, 'assets/icons/compare.png', 'Comparison', screenWidth, homeController),
            _buildNavItem(3, 'assets/icons/setting.png', 'Settings', screenWidth, homeController),
          ],
        ),
      )),
    );
  }

  Widget _buildSettingsItem(
      String title,
      String subtitle,
      String iconPath,
      VoidCallback onTap,
      double screenWidth,
      double screenHeight,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.02,
            ),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                  child: Center(
                    child: Image.asset(
                      iconPath,
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: const Color(0xFF6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: screenWidth * 0.04,
                  color: const Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index,
      String iconPath,
      String label,
      double screenWidth,
      HomeController homeController,
      ) {
    bool isActive = homeController.selectedNavIndex.value == index;
    return GestureDetector(
      onTap: () => homeController.changeNavIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: screenWidth * 0.06,
            height: screenWidth * 0.06,
            color: isActive ? const Color(0xFF2196F3) : Colors.grey.shade600,
          ),
          SizedBox(height: screenWidth * 0.015),
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: isActive ? const Color(0xFF2196F3) : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          if (isActive) ...[
            SizedBox(height: screenWidth * 0.005),
            Container(
              width: screenWidth * 0.05,
              height: 2,
              color: const Color(0xFF2196F3),
            ),
          ]
        ],
      ),
    );
  }
}