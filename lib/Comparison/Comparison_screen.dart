import 'package:flutter/material.dart';

class ComparisonPageScreen extends StatelessWidget {
  final bool isFromExpense;

  const ComparisonPageScreen({super.key, required this.isFromExpense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparison Page"),
      ),
      body: const Center(
        child: Text(
          "This is comparison page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
