import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyBudgetScreen extends StatelessWidget {
  const MonthlyBudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Monthly Budget",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Current Monthly Budget Section
             Text(
              'Current Monthly Budget',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF6A6A6A),
              ),
            ),
            const SizedBox(height: 8),
            Container(

              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF0F0F0)),
              ),
              child: const Text(

                '\$25000',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Edit Budget Section
            const Text(
              'Edit Your Budget',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '\$ Enter amount',
                  hintStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Color(0xFF9E9E9E),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: const Text(
                    'Changing your budget will update your available balance on the home page.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Select Category Section
            const Text(
              'Select Category',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryItem('Food', 'assets/icons/soft-drink-01.png'),
                  const SizedBox(width: 16),
                  _buildCategoryItem('Transport', 'assets/icons/car.png'),
                  const SizedBox(width: 16),
                  _buildCategoryItem('Groceries', 'assets/icons/Groceries.png'),
                  const SizedBox(width: 16),
                  _buildCategoryItem('Eating Out', 'assets/icons/eating_out.png'),
                  const SizedBox(width: 16),
                  _buildCategoryItem('Home', 'assets/icons/home_icon.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildAddCategoryButton(),
            const SizedBox(height: 28),

            // Budget Distribution Section
            const Text(
              'Budget Distribution',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildBudgetListItem('Food', '\$120', '15%', 'assets/icons/soft-drink-01.png'),
                const SizedBox(height: 12),
                _buildBudgetListItem('Transport', '\$100', '7%', 'assets/icons/car.png'),
                const SizedBox(height: 12),
                _buildBudgetListItem('Groceries', '\$50', '5%', 'assets/icons/Groceries.png'),
                const SizedBox(height: 12),
                _buildBudgetListItem('Eating Out', '\$300', '25%', 'assets/icons/eating_out.png'),
                const SizedBox(height: 12),
                _buildBudgetListItem('Home', '\$200', '20%', 'assets/icons/home_icon.png'),
                const SizedBox(height: 12),
                _buildBudgetListItem('Gift', '\$100', '7%', 'assets/icons/gift.png'),
                const SizedBox(height: 12),
                _buildBudgetListItem('Shopping', '\$20', '2%', 'assets/icons/shoping.png'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, String iconPath) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFF0F0F0)),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 28,
              height: 28,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.category,
                  size: 28,
                  color: Colors.grey[400],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF6A6A6A),
          ),
        ),
      ],
    );
  }

  Widget _buildAddCategoryButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Add Custom Category',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetListItem(
      String category, String amount, String percentage, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.category,
                    size: 20,
                    color: Colors.grey[400],
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                percentage,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF6A6A6A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}