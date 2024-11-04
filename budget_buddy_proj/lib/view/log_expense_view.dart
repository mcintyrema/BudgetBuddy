import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogExpenseView extends StatelessWidget { 
  const LogExpenseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LogExpenseViewModel>(context); // Access ViewModel

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Expense'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Example of adding an expense
            viewModel.addExpense('Sample Expense', 50.0);
          },
          child: const Text('Add Expense'),
        ),
      ),
    );
  }
}
