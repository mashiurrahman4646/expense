import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'language_controller.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());

    return Obx(() => Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 16),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Language Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Choose your preferred language for the app interface',
              style: const TextStyle(fontSize: 14, color: Color(0xFF8E8E93), height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < languageController.languages.length; i++) ...[
                    _buildLanguageOption(
                      languageController.languages[i],
                      languageController.selectedLanguage.value ==
                          languageController.languages[i],
                          () {
                        languageController.changeLanguage(languageController.languages[i]);
                      },
                    ),
                    if (i < languageController.languages.length - 1)
                      Container(
                        height: 0.5,
                        color: const Color(0xFFE5E5EA),
                        margin: const EdgeInsets.only(left: 16),
                      ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2CC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber, color: Color(0xFFFF9500), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Some changes may require restarting the app to fully apply',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8E6914), height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Apply Changes',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 34),
        ],
      ),
    ));
  }

  Widget _buildLanguageOption(String language, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              language,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            const Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF007AFF) : const Color(0xFFD1D1D6),
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
