import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Sample expense data
    final List<ExpenseItem> expenses = [
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      ExpenseItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(screenWidth),
      body: ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return _buildExpenseItem(expenses[index], screenWidth, screenHeight);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: screenWidth * 0.05,
        ),
      ),
      title: Text(
        'Expense List',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildExpenseItem(ExpenseItem expense, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Center(
              child: Image.asset(
                expense.icon,
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
                color: Colors.grey.shade600,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.fastfood,
                    size: screenWidth * 0.06,
                    color: Colors.grey.shade600,
                  );
                },
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.04),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  expense.description,
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: screenWidth * 0.035,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      expense.date,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Amount and edit button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                expense.amount,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                onTap: () {
                  // Handle edit action
                  print('Edit expense: ${expense.title}');
                },
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Image.asset(
                    'assets/icons/edit-00.png',
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                    color: Colors.grey.shade600,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.edit,
                        size: screenWidth * 0.05,
                        color: Colors.grey.shade600,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExpenseItem {
  final String title;
  final String description;
  final String amount;
  final String date;
  final String icon;

  ExpenseItem({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.icon,
  });
}