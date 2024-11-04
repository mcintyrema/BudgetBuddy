import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogExpenseView extends StatefulWidget { 
  const LogExpenseView({Key? key}) : super(key: key);

  @override
  State<LogExpenseView> createState() => _LogExpenseViewState();
}

class _LogExpenseViewState extends State<LogExpenseView> {
  final TextEditingController amountController = TextEditingController();

  // List of expense categories
  final List<String> expenseCategories = [
    'Food',
    'Transportation',
    'Entertainment',
    'Utilities',
    'Health',
    'Shopping',
    'Other'
  ];

  // Selected category for the dropdown
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LogExpenseViewModel>(context);

    // controllers for inputs
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Category:'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          hint: const Text('Select a category'),
                          isExpanded: true,
                          items: expenseCategories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Amount:'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            prefixText: '\$',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter expense amount',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Retrieve text field values and add the expense
                final String category = categoryController.text;
                final double? amount = double.tryParse(amountController.text);
                
                if (selectedCategory != null && amount != null) {
                  viewModel.addExpense(category, amount);
                  // Clear text fields after adding the expense
                  categoryController.clear();
                  amountController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Expense added!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid data.')),
                  );
                }
              },
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
