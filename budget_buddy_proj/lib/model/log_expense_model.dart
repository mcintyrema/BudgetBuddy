import 'dart:typed_data';

class log_expense_model {
  final String category;
  final double amount;
  final String frequency;
  final Uint8List? imageData;
  final String? comment;

  log_expense_model({
    required this.category, 
    required this.amount, 
    required this.frequency, 
    this.imageData,
    this.comment,
    });

  // Factory constructor to create an Expense from JSON
  factory log_expense_model.fromJson(Map<String, dynamic> json) {
    return log_expense_model(
      category: json['category'],
      amount: json['amount'].toDouble(),
      frequency: json['frequency'],
      imageData: json['imageData'],
      comment: json['comment'],
    );
  }

  // Method to convert an Expense to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'frequency': frequency,
      'imageData': imageData,
      'comment': comment,
    };
  }
}