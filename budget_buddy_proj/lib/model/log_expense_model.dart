class log_expense_model {
  final String category;
  final double amount;
  final String frequency;

  log_expense_model({required this.category, required this.amount, required this.frequency});

  // Factory constructor to create an Expense from JSON
  factory log_expense_model.fromJson(Map<String, dynamic> json) {
    return log_expense_model(
      category: json['category'],
      amount: json['amount'].toDouble(),
      frequency: json['frequency'],
    );
  }

  // Method to convert an Expense to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'frequency': frequency
    };
  }
}