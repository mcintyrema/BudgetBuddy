import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';

class QuickAddExpenseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LogExpenseViewModel>(context);
    final TextEditingController amountController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('*Category:'),
        DropdownButton<String>(
          value: viewModel.selectedCategory,
          hint: const Text('Select a category'),
          isExpanded: true,
          items: viewModel.expenseCategories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newValue) {
            viewModel.selectedCategory = newValue;
          },
        ),
        const SizedBox(height: 16),
        const Text('*Amount:'),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter expense amount',
          ),
        ),
        const SizedBox(height: 16),
        const Text('*Frequency:'),
        DropdownButton<String>(
          value: viewModel.selectedFrequency,
          hint: const Text('Select frequency'),
          isExpanded: true,
          items: viewModel.frequencies.map((String frequency) {
            return DropdownMenuItem<String>(
              value: frequency,
              child: Text(frequency),
            );
          }).toList(),
          onChanged: (String? newValue) {
            viewModel.selectedFrequency = newValue;
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Implement logic to add expense
          },
          child: const Text('Add Expense'),
        ),
      ],
    );
  }
}
