import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: screenWidth * 0.05,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildDateSection('Today', screenWidth),
                  _buildNotificationItem(screenWidth, screenHeight),
                  _buildNotificationItem(screenWidth, screenHeight),
                  _buildNotificationItem(screenWidth, screenHeight),

                  SizedBox(height: screenHeight * 0.025),

                  _buildDateSection('Yesterday', screenWidth),
                  _buildNotificationItem(screenWidth, screenHeight),
                  _buildNotificationItem(screenWidth, screenHeight),
                  _buildNotificationItem(screenWidth, screenHeight),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(String date, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.02,
        bottom: screenWidth * 0.03,
        top: screenWidth * 0.01,
      ),
      child: Text(
        date,
        style: TextStyle(
          fontSize: screenWidth * 0.038,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: screenWidth * 0.03, top: screenHeight * 0.002),
            child: Icon(
              Icons.mail_outline,
              size: screenWidth * 0.055,
              color: Color(0xFF666666),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exciting news! There\'s a fresh freelance opportunity waiting for you.......',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                    height: 1.3,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  '1h ago',
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}