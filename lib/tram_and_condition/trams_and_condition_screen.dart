import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import '../text_styles.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the consistent text style for body content
    const TextStyle bodyTextStyle = TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.3, // 130% line-height
      color: Colors.black,
    );

    // Define the style for section headings
    const TextStyle headingTextStyle = TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.2, // 120% line-height
      color: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow-left.png',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Terms & Conditions',
          style: AppTextStyles.heading2.copyWith(color: const Color(0xFF000000)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction text
            Text(
              'Please read these Terms and Conditions carefully before using our mobile application. By accessing or using our app, you agree to be bound by these terms.',
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Section 1
            Text(
              '1. Acceptance of Terms',
              style: headingTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement. This includes all policies and guidelines incorporated by reference in these Terms.',
              style: bodyTextStyle,
            ),
            const SizedBox(height: 16),

            // Section 2
            Text(
              '2. User Accounts',
              style: headingTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'When you create an account with us, you must provide accurate, complete, and current information. You are responsible for safeguarding the password and for all activities that occur under your account. We reserve the right to suspend or terminate accounts that violate our terms.',
              style: bodyTextStyle,
            ),
            const SizedBox(height: 16),

            // Section 3
            Text(
              '3. Privacy Policy',
              style: headingTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Your use of our application is also governed by our Privacy Policy. Please review our Privacy Policy, which also governs the application and informs users of our data collection practices. We are committed to protecting your personal information.',
              style: bodyTextStyle,
            ),
            const SizedBox(height: 16),

            // Section 4
            Text(
              '4. User Content',
              style: headingTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Our application allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material. You retain ownership of any intellectual property rights that you hold in that content, but grant us a license to use it for service operation.',
              style: bodyTextStyle,
            ),
            const SizedBox(height: 16),

            // Section 5
            Text(
              '5. Prohibited Activities',
              style: headingTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'You agree not to engage in any of the following prohibited activities: violating laws, infringing intellectual property, distributing malware, spamming, or interfering with the service. We may investigate violations and cooperate with authorities.',
              style: bodyTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}