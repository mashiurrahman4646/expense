class Transaction {
  final String id;
  final String title;
  final String type;
  final String amount;
  final String time;
  bool get isIncome => type == 'income';

  Transaction({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.time,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Unknown',
      type: json['type'] ?? '',
      amount: json['amount'] ?? '0',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': time,
      'amount': amount,
      'isIncome': isIncome,
    };
  }

  // Helper method to get numeric amount (remove +, - signs and parse)
  double get numericAmount {
    final cleanAmount = amount.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanAmount) ?? 0.0;
  }
}