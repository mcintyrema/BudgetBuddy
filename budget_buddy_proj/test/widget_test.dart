// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:budget_buddy_proj/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:budget_buddy_proj/model/log_expense_model.dart';

void main() {
  testWidgets('loadExpenses should retrieve saved expenses', (WidgetTester tester) async {
    // Initialize the mock for SharedPreferences
    SharedPreferences.setMockInitialValues({});

    final viewModel = LogExpenseViewModel();

    // Create a sample expense and save it
    final testExpense = log_expense_model(category: 'Rent', amount: 50.0, frequency: 'Never');
    viewModel.setTestExpenses([testExpense]); // Adding directly to test
    await viewModel.saveExpenses(); // Save to SharedPreferences

    // Clear the expenses to simulate a fresh load
    viewModel.setTestExpenses([]);

    // Load the expenses and verify
    await viewModel.loadExpenses();
    await tester.pumpAndSettle();

    expect(viewModel.expenses.length, 1); // Check there's one expense loaded
    expect(viewModel.expenses.first.category, 'Rent');
    expect(viewModel.expenses.first.amount, 50.0);
    expect(viewModel.expenses.first.frequency, 'Never');
  });
}
