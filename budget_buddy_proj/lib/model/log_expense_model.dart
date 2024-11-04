class log_expense_model {
  final String name;
  final double amount;

  log_expense_model({required this.name, required this.amount});

  // Factory constructor to create an Expense from JSON
  factory log_expense_model.fromJson(Map<String, dynamic> json) {
    return log_expense_model(
      name: json['name'],
      amount: json['amount'].toDouble(),
    );
  }

  // Method to convert an Expense to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }
}