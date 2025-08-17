import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/Settings/userprofile/passwordchangescreen.dart';
import '../../routes/app_routes.dart';
import 'changeemail.dart';

class PersonalInformationScreen extends StatelessWidget {
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
          onPressed: () {
            bool routeFound = false;

            // Try to pop until we find the settings route
            Get.until((route) {
              if (route.settings.name == AppRoutes.settings) {
                routeFound = true;
              }
              return route.settings.name == AppRoutes.settings;
            });

            // If not found, navigate fresh to settings
            if (!routeFound) {
              Get.offAllNamed(AppRoutes.settings);
            }
          },
        ),
        title: Text(
          'Personal Information',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // Profile Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
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
                        borderRadius: BorderRadius.circular(screenWidth * 0.125),
                        child: Image.asset(
                          'assets/images/Ellipse 5.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Change Photo Button
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          'Photo',
                          'Change photo functionality will be implemented',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF2196F3),
                          colorText: Colors.white,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.06),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Change Photo',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Personal Information Section
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildInfoItem(
                'Full name',
                'Change profile image, name or password',
                    () => Get.toNamed(AppRoutes.editName),
                screenWidth,
                screenHeight,
              ),

              _buildInfoItem(
                'Email Address',
                'johndoe@example.com',
                    () => Get.to(() => ChangeEmailScreen()),
                screenWidth,
                screenHeight,
              ),

              _buildInfoItem(
                'Change Password',
                '',
                    () => Get.to(() => PasswordChangeScreen()),
                screenWidth,
                screenHeight,
              ),

              SizedBox(height: screenHeight * 0.06),

              // Delete Account Button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        content: const Text(
                          'Are you sure you want to delete your account? This action cannot be undone.',
                        ),
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
                              Get.snackbar(
                                'Account Deleted',
                                'Your account has been deleted successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Delete Account',
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

  Widget _buildInfoItem(
      String title,
      String subtitle,
      VoidCallback onTap,
      double screenWidth,
      double screenHeight,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.02,
            ),
            child: Row(
              children: [
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
                      if (subtitle.isNotEmpty) ...[
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
                    ],
                  ),
                ),
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
}
