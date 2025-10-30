import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:your_expense/Settings/appearance/ThemeController.dart';

import 'expense_controller.dart';
import 'expense_model.dart';


class ExpenseListScreen extends StatelessWidget {
  final ExpenseController _expenseController = Get.find();
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define colors based on theme
    final backgroundColor = _themeController.isDarkModeActive ? Color(0xFF121212) : Colors.white;
    final cardColor = _themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white;
    final textColor = _themeController.isDarkModeActive ? Colors.white : Colors.black;
    final secondaryTextColor = _themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600;
    final iconColor = _themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor = _themeController.isDarkModeActive ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(screenWidth, textColor, backgroundColor),
      body: Obx(() {
        if (_expenseController.isLoading.value && _expenseController.expenses.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (_expenseController.errorMessage.value.isNotEmpty) {
          return _buildErrorWidget(_expenseController.errorMessage.value, textColor, secondaryTextColor);
        }

        if (_expenseController.expenses.isEmpty) {
          return _buildEmptyState(iconColor, textColor, secondaryTextColor);
        }

        return RefreshIndicator(
          onRefresh: () => _expenseController.loadExpenses(),
          child: ListView.builder(
            padding: EdgeInsets.all(screenWidth * 0.04),
            itemCount: _expenseController.expenses.length,
            itemBuilder: (context, index) {
              final expense = _expenseController.expenses[index];
              return _buildExpenseItem(
                expense,
                screenWidth,
                screenHeight,
                cardColor,
                textColor,
                secondaryTextColor,
                iconColor,
                shadowColor,
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add expense screen
          // Get.to(() => AddExpenseScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth, Color textColor, Color backgroundColor) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: textColor, size: screenWidth * 0.05),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'expense_list'.tr,
        style: TextStyle(
          color: textColor,
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.refresh, color: textColor),
          onPressed: () => _expenseController.loadExpenses(),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(
      ExpenseItem expense,
      double screenWidth,
      double screenHeight,
      Color cardColor,
      Color textColor,
      Color secondaryTextColor,
      Color iconColor,
      Color shadowColor,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
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
              color: _themeController.isDarkModeActive ? Color(0xFF2D2D2D) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Center(
              child: Icon(
                Icons.receipt,
                size: screenWidth * 0.06,
                color: iconColor,
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
                  expense.category.isNotEmpty ? expense.category : 'expense'.tr,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  expense.note.isNotEmpty ? expense.note : (expense.category.isNotEmpty ? expense.category : 'no_description'.tr),
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: secondaryTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.008),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: screenWidth * 0.035,
                      color: secondaryTextColor,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      expense.formattedDate,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Amount and edit button
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    expense.formattedAmount,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                IconButton(
                  icon: Icon(Icons.edit, size: screenWidth * 0.05, color: iconColor),
                  onPressed: () {
                    // Handle edit action
                    print('Edit expense: ${expense.id}');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error, Color textColor, Color secondaryTextColor) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 50, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'failed_to_load_expenses'.tr,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(color: secondaryTextColor, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _expenseController.loadExpenses(),
              child: Text('retry'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color iconColor, Color textColor, Color secondaryTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 50, color: iconColor),
          SizedBox(height: 16),
          Text(
            'no_expenses_found'.tr,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
          Text(
            'start_adding_expenses_to_see_them'.tr,
            style: TextStyle(color: secondaryTextColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}