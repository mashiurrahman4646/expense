import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaceConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image (adjusted to match your Figma layout)
            Image.asset(
              'assets/images/Fingerprint-confarm.png',
              width: 220,
              height: 220,
            ),
            const SizedBox(height: 40),

            // Title Text
            const Text(
              'FaceID Added Successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF535353),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // Sub Text
            const Text(
              'Your account is protected with FaceID authentication.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF6A6A6A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 48),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.back(), // You can navigate elsewhere
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3787F2), // Or match Figma blue
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded button
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
