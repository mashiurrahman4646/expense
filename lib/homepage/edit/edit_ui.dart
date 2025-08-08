import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyBudgetScreen extends StatelessWidget {
  const MonthlyBudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          "Monthly Budget",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Color(0xFF404040),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF404040)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Monthly Budget Section
            const Text(
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '\$25000',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color(0xFF404040),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Edit Budget Section
            const Text(
              'Edit Your Budget',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF404040),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter amount',
                hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 20,
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
            const SizedBox(height: 24),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 50,
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
            const SizedBox(height: 32),

            // Select Category Section
            const Text(
              'Select Category',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF404040),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryItem(
                      'Food', 'assets/icons/soft-drink-01.png'),
                  const SizedBox(width: 12),
                  _buildCategoryItem('Transport', 'assets/icons/car.png'),
                  const SizedBox(width: 12),
                  _buildCategoryItem('Groceries', 'assets/icons/Groceries.png'),
                  const SizedBox(width: 12),
                  _buildCategoryItem('Eating Out', 'assets/icons/eating_out.png'),
                  const SizedBox(width: 12),
                  _buildCategoryItem('Home', 'assets/icons/home_icon.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildAddCategoryButton(),
            const SizedBox(height: 32),

            // Budget Distribution Section
            const Text(
              'Budget Distribution',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF404040),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildBudgetListItem('Food', '\$120', '15%', 'assets/icons/soft-drink-01.png'),
                const SizedBox(height: 10),
                _buildBudgetListItem('Transport', '\$100', '7%', 'assets/icons/car.png'),
                const SizedBox(height: 10),
                _buildBudgetListItem('Groceries', '\$50', '5%', 'assets/icons/Groceries.png'),
                const SizedBox(height: 10),
                _buildBudgetListItem('Eating Out', '\$300', '25%', 'assets/icons/eating_out.png'),
                const SizedBox(height: 10),
                _buildBudgetListItem('Home', '\$200', '20%', 'assets/icons/home_icon.png'),
                const SizedBox(height: 10),
                _buildBudgetListItem('Gift', '\$100', '7%', 'assets/icons/gift.png'),
                const SizedBox(height: 10),
                _buildBudgetListItem('Shopping', '\$20', '2%', 'assets/icons/shoping.png'),
              ],
            ),
            const SizedBox(height: 32),

            // Price Comparison Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Color(0xFF8D6E63)),
                      const SizedBox(width: 8),
                      // Use Expanded to prevent text overflow
                      const Expanded(
                        child: Text(
                          'Save Money with Price Comparison',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF404040)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Text(
                      'Discover how to save and stay within your budget with our price comparison tool.',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF6A6A6A)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Compare Prices Now',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, String iconPath) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(iconPath, width: 24, height: 24),
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/black_add.png', width: 24, height: 24),
          const SizedBox(width: 8),
          const Text(
            'Add Custom Category',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF404040),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF404040),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF404040),
                ),
              ),
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
