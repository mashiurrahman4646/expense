import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/Settings/premium/paymentsuccessscreen.dart';


class PaymentScreen extends StatelessWidget {
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
            Get.back();
          },
        ),
        title: Text(
          'Complete Payment',
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

              // Header Section
              Text(
                "You're just one step away from unlocking premium features",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Payment Methods Section
              Text(
                'Choose Payment Method',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Card Payment Option
              _buildPaymentMethodCard(
                context: context,
                title: 'Card Payment',
                description: 'Visa, Mastercard, Amex',
                iconPath: 'assets/icons/CardPayment.png',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isSelected: true,
              ),

              SizedBox(height: screenHeight * 0.015),

              // Mobile Wallet Option
              _buildPaymentMethodCard(
                context: context,
                title: 'Mobile Wallet',
                description: 'Mcash, Pocket',
                iconPath: 'assets/icons/MobileWallet.png',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isSelected: false,
              ),

              SizedBox(height: screenHeight * 0.015),

              // Bank Transfer Option
              _buildPaymentMethodCard(
                context: context,
                title: 'Bank Transfer',
                description: 'Manual payment verification',
                iconPath: 'assets/icons/BankTransfer.png',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isSelected: false,
              ),

              SizedBox(height: screenHeight * 0.04),

              // Card Details Form
              Text(
                'Card Number',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              TextField(
                decoration: InputDecoration(
                  hintText: '0000 0000 0000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: screenHeight * 0.02),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.02,
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextField(
                          decoration: InputDecoration(
                            hintText: '123',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.02,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              Text(
                'Name on Card',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              TextField(
                decoration: InputDecoration(
                  hintText: 'John Doe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.06),

              // Pay Now Button - Updated to navigate to success screen
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate form first if needed
                    // Then navigate to success screen
                    Get.to(() => PaymentSuccessScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Pay Now',
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

  Widget _buildPaymentMethodCard({
    required BuildContext context,
    required String title,
    required String description,
    required String iconPath,
    required double screenWidth,
    required double screenHeight,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle payment method selection
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(
            color: isSelected ? const Color(0xFF2196F3) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF2196F3),
                  size: screenWidth * 0.06,
                ),
            ],
          ),
        ),
      ),
    );
  }
}