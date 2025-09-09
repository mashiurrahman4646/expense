import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/tram_and_condition/trams_condition_controller.dart';
import '../Settings/appearance/ThemeController.dart';
import '../colors/app_colors.dart';
import '../text_styles.dart';
import 'model/tram_and_condition_model.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final termsController = Get.put(TermsAndConditionsController());

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      final bodyTextStyle = TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.6,
        color: isDark ? AppColors.darkText : AppColors.text900,
      );

      final headingTextStyle = TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.3,
        color: isDark ? AppColors.darkText : AppColors.text900,
      );

      final sectionHeadingStyle = TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        height: 1.2,
        color: isDark ? AppColors.darkText : AppColors.text900,
      );

      return Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/arrow-left.png',
              width: 24,
              height: 24,
              color: isDark ? AppColors.darkText : AppColors.text900,
            ),
            onPressed: () => Get.back(),
          ),
          backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Terms & Conditions',
            style: AppTextStyles.heading2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.text900,
            ),
          ),
        ),
        body: Obx(() {
          if (termsController.isLoading.value) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading terms and conditions...'),
                ],
              ),
            );
          }

          if (termsController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: isDark ? AppColors.darkPrimary500 : AppColors.primary500,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading terms',
                    style: headingTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      termsController.errorMessage.value,
                      style: bodyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: termsController.refreshTerms,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Get the latest terms content
          final latestTerms = termsController.latestTerms.value;
          final termsContent = latestTerms?.content ??
              (termsController.termsList.isNotEmpty
                  ? termsController.termsList.first.content
                  : '');

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main title
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    height: 1.2,
                    color: isDark ? AppColors.darkText : AppColors.text900,
                  ),
                ),
                const SizedBox(height: 16),

                // Fixed introductory text
                Text(
                  'Please read these Terms and Conditions carefully before using our mobile application. By accessing or using our app, you agree to be bound by these terms.',
                  style: bodyTextStyle,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 32),

                // Display the terms content as plain text
                if (termsContent.isNotEmpty) ...[
                  Text(
                    termsContent,
                    style: bodyTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ] else ...[
                  Text(
                    'No terms and conditions available.',
                    style: bodyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],

                // Version info at the bottom (subtle)
                if (latestTerms != null) ...[
                  const SizedBox(height: 32),
                  Divider(
                    color: isDark ? AppColors.darkText300 : AppColors.text300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Version: ${latestTerms.version}',
                    style: bodyTextStyle.copyWith(
                      fontSize: 12,
                      color: isDark ? AppColors.darkText600 : AppColors.text600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Effective Date: ${_formatDate(latestTerms.effectiveDate)}',
                    style: bodyTextStyle.copyWith(
                      fontSize: 12,
                      color: isDark ? AppColors.darkText600 : AppColors.text600,
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      );
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}