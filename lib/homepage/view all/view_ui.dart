import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller for the All Transactions Screen.
// This is a minimal controller to manage transactions,
// but it can be expanded to fetch real data from a service.
class AllTransactionsController extends GetxController {
  final List<Map<String, dynamic>> allTransactions = [
    {'title': 'Salary Deposit', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': true},
    {'title': 'Salary Deposit', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': true},
    {'title': 'Salary Deposit', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': true},
    {'title': 'Salary Deposit', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': true},
    {'title': 'Food', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': false},
    {'title': 'Shopping', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': false},
    {'title': 'Transport', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': false},
    {'title': 'Transport', 'time': 'Today, 13:45 PM', 'amount': '3,500.00', 'isIncome': false},
  ].obs;
}

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllTransactionsController controller = Get.put(AllTransactionsController());
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenWidth * 0.04),
              // Transaction list heading
              Text(
                'Recent Transections',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              // Transaction list using individual Card widgets
              Obx(() => Column(
                children: controller.allTransactions.asMap().entries.map((entry) {
                  var transaction = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.03), // Add space between cards
                    child: _buildTransactionItem(
                      transaction['title'] as String,
                      transaction['time'] as String,
                      transaction['amount'] as String,
                      transaction['isIncome'] as bool,
                      screenWidth,
                    ),
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String time, String amount, bool isIncome, double screenWidth) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      margin: EdgeInsets.zero, // No margin on the card itself, padding is applied on the parent widget
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: BoxDecoration(
                color: isIncome ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0), // Use light background color
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: Center(
                child: Icon(
                  isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                  size: screenWidth * 0.05,
                  color: isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF57C00), // Use contrasting icon color
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.005),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isIncome ? '+' : '-'}\$$amount',
              style: TextStyle(
                color: isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF57C00),
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
