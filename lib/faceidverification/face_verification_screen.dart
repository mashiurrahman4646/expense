import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaceVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          'Set Your Face ID',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Progress Indicator
            Container(
              height: 60, // Increased height to accommodate text below circles
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                  ),
                  // Step 1 Circle
                  Positioned(
                    left: (screenWidth * 0.2) - 12,
                    top: 4,
                    child: _buildStepCircle(1, true),
                  ),
                  // Step 1 Text
                  Positioned(
                    left: (screenWidth * 0.2) - 30,
                    top: 32,
                    child: Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey, // Changed to gray
                      ),
                    ),
                  ),
                  // Step 2 Circle
                  Positioned(
                    left: (screenWidth * 0.7) - 12,
                    top: 4,
                    child: _buildStepCircle(2, true),
                  ),
                  // Step 2 Text
                  Positioned(
                    left: (screenWidth * 0.7) - 25,
                    top: 32,
                    child: Text(
                      'FaceID',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey, // Changed to gray
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Secure your account with Face ID authentication. Quickly log in without typing your password every time.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 32),
            // Clickable Face ID Image
            GestureDetector(
              onTap: () {
                Get.toNamed('/signupVerification');
              },
              child: Image.asset(
                'assets/images/face-id.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 32),
            // Cancel Button
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[400],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Center(
        child: Text(
          stepNumber.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}