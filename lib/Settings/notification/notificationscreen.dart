import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool enableAllNotifications = true;
  bool pushNotification = true;
  bool automaticRenewal = true;
  bool monthlyExpenseAndIncomeAlerts = true;
  bool budgetLimitWarning = true;
  bool promotionalNotifications = true;

  @override
  Widget build(BuildContext context) {
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
          'Notification Settings',
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
              SizedBox(height: screenHeight * 0.02),

              // Enable All Notifications
              _buildNotificationItem(
                icon: Icons.notifications_outlined,
                title: 'Enable All Notifications',
                subtitle: 'Control all notification preferences',
                value: enableAllNotifications,
                onChanged: (value) {
                  setState(() {
                    enableAllNotifications = value;
                    if (!value) {
                      // Turn off all notifications
                      pushNotification = false;
                      automaticRenewal = false;
                      monthlyExpenseAndIncomeAlerts = false;
                      budgetLimitWarning = false;
                      promotionalNotifications = false;
                    }
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.02),

              // General Notifications Section
              Text(
                'General Notifications',
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              _buildNotificationItem(
                icon: Icons.notifications_active_outlined,
                title: 'Push notification',
                subtitle: 'Receive important alerts when you\'re not using the app.',
                value: pushNotification,
                onChanged: (value) {
                  setState(() {
                    pushNotification = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildNotificationItem(
                icon: Icons.autorenew_outlined,
                title: 'Automatic Renewal',
                subtitle: 'Keep your subscription active without interruption. Turn this off if you prefer to renew manually.',
                value: automaticRenewal,
                onChanged: (value) {
                  setState(() {
                    automaticRenewal = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Financial Alerts Section
              Text(
                'Financial Alerts',
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              _buildNotificationItem(
                icon: Icons.receipt_long_outlined,
                title: 'Monthly Expense and Income Alerts',
                subtitle: 'Get notified after month end about expense and income.',
                value: monthlyExpenseAndIncomeAlerts,
                onChanged: (value) {
                  setState(() {
                    monthlyExpenseAndIncomeAlerts = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildNotificationItem(
                icon: Icons.trending_up_outlined,
                title: 'Budget Limit Warning',
                subtitle: 'Receive a warning when you\'re nearing your monthly budget.',
                value: budgetLimitWarning,
                onChanged: (value) {
                  setState(() {
                    budgetLimitWarning = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Other Notifications Section
              Text(
                'Other Notifications',
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              _buildNotificationItem(
                icon: Icons.campaign_outlined,
                title: 'Promotional Notifications',
                subtitle: 'Get updates about new features or offers',
                value: promotionalNotifications,
                onChanged: (value) {
                  setState(() {
                    promotionalNotifications = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.03),

              // Auto Save Message
              Center(
                child: Text(
                  'Changes will save automatically',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
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

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Icon(
              icon,
              size: screenWidth * 0.06,
              color: const Color(0xFF6B7280),
            ),
          ),

          SizedBox(width: screenWidth * 0.04),

          // Content
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
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2196F3),
            activeTrackColor: const Color(0xFF2196F3).withOpacity(0.3),
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}