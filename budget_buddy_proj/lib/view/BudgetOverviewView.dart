import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:budget_buddy_proj/model/log_expense_model.dart';

class BudgetOverviewView extends StatelessWidget {
  const BudgetOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<LogExpenseViewModel>(context);
    final expenses = expenseViewModel.expenses;

    double totalExpenses = expenses.fold(
      0.0,
      (sum, expense) => sum + expense.amount,
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.green,
            child: Column(
              children: [
                Text(
                  '-\$${totalExpenses.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const Text(
                  'Net Budget Spent',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final logExpense = expenses[index];
                return ListTile(
                  title: Text(logExpense.category),
                  subtitle: Text(logExpense.frequency),
                  trailing: Text('\$${logExpense.amount.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
