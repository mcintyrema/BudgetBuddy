import 'package:budget_buddy_proj/view_model/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetViewModel>(
      builder: (context, budgetViewModel, child) {
        double totalBudget = budgetViewModel.totalBudget;
        double totalSpending = budgetViewModel.totalSpending;
        double remainingBalance = totalBudget - totalSpending;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Budget Overview',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
              _buildBudgetCard(
                context,
                'Total Budget',
                '\$${totalBudget.toStringAsFixed(2)}',
                Icons.account_balance_wallet,
              ),
              _buildBudgetCard(
                context,
                'Total Spending',
                '\$${totalSpending.toStringAsFixed(2)}',
                Icons.money_off,
              ),
              _buildBudgetCard(
                context,
                'Remaining Balance',
                '\$${remainingBalance.toStringAsFixed(2)}',
                Icons.account_balance,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: budgetViewModel.categoryBreakdown.length,
                  itemBuilder: (context, index) {
                    var category = budgetViewModel.categoryBreakdown.keys.elementAt(index);
                    var amount = budgetViewModel.categoryBreakdown[category];
                    return ListTile(
                      title: Text(category),
                      trailing: Text('\$${amount.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBudgetCard(BuildContext context, String title, String amount, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
