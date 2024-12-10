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
    final initialBudget = expenseViewModel.initialBudget;

    double totalExpenses = expenses.fold(
      0.0,
      (sum, expense) => sum + expense.amount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Budget: '),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Show a dialog to set the initial budget
              showDialog(
                context: context,
                builder: (context) {
                  double? newBudget;
                  return AlertDialog(
                    title: const Text('Set Initial Budget'),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter budget amount',
                      ),
                      onChanged: (value) {
                        newBudget = double.tryParse(value);
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (newBudget != null) {
                            expenseViewModel.setInitialBudget(newBudget!);
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text('Set'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.green,
            child: Column(
              children: [
                Text(
                  '\$${(initialBudget - totalExpenses).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const Text(
                  'Remaining Budget',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Text(
                  'Total Budget: \$${initialBudget.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
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
