import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_exp_controller.dart';

class AddTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTransactionController());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Add Expense',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionTypeToggle(controller),

            SizedBox(height: 30),

            _buildReceiptUploadSection(),

            SizedBox(height: 40),

            Text(
              'Select Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryItem(controller, 'Food', 'assets/icons/food_icon.png.png'),
                _buildCategoryItem(controller, 'Transport', 'assets/icons/transport_icon.png.png'),
                _buildCategoryItem(controller, 'Groceries', 'assets/icons/groceries_ison.png.png'),
                _buildCategoryItem(controller, 'Eating Out', 'assets/icons/eating_out_icon.png.png'),
                _buildCategoryItem(controller, 'Home', 'assets/icons/home_icon.png.png'),
              ],
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () => Get.snackbar(
                'Pro Feature',
                'You need to be pro to use this feature',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange.shade100,
                colorText: Colors.orange.shade800,
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.grey.shade600),
                    SizedBox(width: 8),
                    Text('Add Custom Category', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/what_icon.png',
                    width: 16,
                    height: 16,
                    color: Colors.orange.shade600,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.info_outline, color: Colors.orange.shade600, size: 16);
                    },
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This feature is only available for pro user only',
                      style: TextStyle(color: Colors.orange.shade700, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Text(
              'Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '\$ Enter amount',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF2196F3)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),

            SizedBox(height: 30),

            Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPaymentItem(controller, 'Cash', 'assets/icons/cash_icon.png'),
                _buildPaymentItem(controller, 'Mobile', 'assets/icons/mobile_icon.png'),
                _buildPaymentItem(controller, 'Bank', 'assets/icons/bank.png'),
                _buildPaymentItem(controller, 'Card', 'assets/icons/bank.png'),
              ],
            ),

            SizedBox(height: 30),

            // Updated Date Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Default',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Feb 15, 2024 - 14:30',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set Date & Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          child: Text(
                            'Feb 15, 2024',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            // Watch Video Section with icon on right
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFF2196F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Watch a short video to add for free',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/you_tube.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.play_circle_filled, color: Colors.white, size: 24);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Upgrade to Pro Section with icon on right
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upgrade to Pro to remove ads',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/remove_ad.png',
                    width: 24,
                    height: 24,
                    color: Colors.grey.shade600,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.star, color: Colors.grey.shade600, size: 24);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTypeToggle(AddTransactionController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.toggleTransactionType(true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.isExpenseSelected.value
                      ? Color(0xFF2196F3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Expense',
                    style: TextStyle(
                      color: controller.isExpenseSelected.value
                          ? Colors.white
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.toggleTransactionType(false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !controller.isExpenseSelected.value
                      ? Color(0xFF2196F3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Income',
                    style: TextStyle(
                      color: !controller.isExpenseSelected.value
                          ? Colors.white
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptUploadSection() {
    return Column(
      children: [
        Text(
          'Scan or upload receipt',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconCircle('assets/icons/camera-ai.png', Icons.camera_alt),
            SizedBox(width: 20),
            _buildIconCircle('assets/icons/Barcode.png', Icons.qr_code_scanner),
            SizedBox(width: 20),
            _buildIconCircle('assets/icons/Group 74.png.png', Icons.photo_library),
          ],
        ),
      ],
    );
  }

  Widget _buildIconCircle(String assetPath, IconData fallbackIcon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.orange.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 30,
          height: 30,
          color: Colors.white,
          errorBuilder: (context, error, stackTrace) {
            return Icon(fallbackIcon, color: Colors.white, size: 30);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(AddTransactionController controller, String name, String iconPath) {
    return Obx(() => GestureDetector(
      onTap: () => controller.selectCategory(name),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: controller.selectedCategory.value == name
                  ? Color(0xFF2196F3).withOpacity(0.2)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: controller.selectedCategory.value == name
                  ? Border.all(color: Color(0xFF2196F3), width: 2)
                  : null,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 30,
                height: 30,
                color: controller.selectedCategory.value == name
                    ? Color(0xFF2196F3)
                    : Colors.grey.shade600,
                errorBuilder: (context, error, stackTrace) {
                  IconData fallbackIcon;
                  switch (name) {
                    case 'Food': fallbackIcon = Icons.restaurant; break;
                    case 'Transport': fallbackIcon = Icons.directions_car; break;
                    case 'Groceries': fallbackIcon = Icons.shopping_cart; break;
                    case 'Eating Out': fallbackIcon = Icons.fastfood; break;
                    case 'Home': fallbackIcon = Icons.home; break;
                    default: fallbackIcon = Icons.category;
                  }
                  return Icon(
                    fallbackIcon,
                    color: controller.selectedCategory.value == name
                        ? Color(0xFF2196F3)
                        : Colors.grey.shade600,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: controller.selectedCategory.value == name
                  ? Color(0xFF2196F3)
                  : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildPaymentItem(AddTransactionController controller, String name, String iconPath) {
    return Obx(() => GestureDetector(
      onTap: () => controller.selectPaymentMethod(name),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: controller.selectedPaymentMethod.value == name
                  ? Color(0xFF2196F3).withOpacity(0.2)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: controller.selectedPaymentMethod.value == name
                  ? Border.all(color: Color(0xFF2196F3), width: 2)
                  : null,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 30,
                height: 30,
                color: controller.selectedPaymentMethod.value == name
                    ? Color(0xFF2196F3)
                    : Colors.grey.shade600,
                errorBuilder: (context, error, stackTrace) {
                  IconData fallbackIcon;
                  switch (name) {
                    case 'Cash': fallbackIcon = Icons.money; break;
                    case 'Mobile': fallbackIcon = Icons.phone_android; break;
                    case 'Bank': fallbackIcon = Icons.account_balance; break;
                    case 'Card': fallbackIcon = Icons.credit_card; break;
                    default: fallbackIcon = Icons.payment;
                  }
                  return Icon(
                    fallbackIcon,
                    color: controller.selectedPaymentMethod.value == name
                        ? Color(0xFF2196F3)
                        : Colors.grey.shade600,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: controller.selectedPaymentMethod.value == name
                  ? Color(0xFF2196F3)
                  : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ));
  }
}