import 'package:budget_buddy_proj/model/log_expense_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogExpenseViewModel extends ChangeNotifier{

  final List<log_expense_model> _expenses = [];

  List<log_expense_model> get expenses => _expenses;

  // Load expenses from JSON stored in SharedPreferences
  Future<void> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('expenses');

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _expenses.clear();
      _expenses.addAll(jsonList.map((json) => log_expense_model.fromJson(json)).toList());
      notifyListeners();
    }
  }

  // Save expenses as JSON to SharedPreferences
  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(_expenses.map((e) => e.toJson()).toList());
    await prefs.setString('expenses', jsonString);
  }

  // Add an expense and save the updated list
  void addExpense(String name, double amount) {
    _expenses.add(log_expense_model(name: name, amount: amount));
    saveExpenses();
    notifyListeners();
  }
}