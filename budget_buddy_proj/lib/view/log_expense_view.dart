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

  String? selectedCategory;

  Future<void> _showAddCategoryDialog(LogExpenseViewModel viewModel) async {
    String newCategory = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextField(
            onChanged: (value) {
              newCategory = value;
            },
            decoration: const InputDecoration(hintText: 'Enter category name'),
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
                Navigator.of(context).pop();
                if (newCategory.isNotEmpty) {
                  viewModel.addNewCategory(newCategory);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _showDeleteCategoryDialog(LogExpenseViewModel viewModel, String category) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text('Are you sure you want to delete "$category"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteCategory(category);
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LogExpenseViewModel>(context);

    return Scaffold(
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
                          value: viewModel.selectedCategory,
                          hint: const Text('Select a category'),
                          isExpanded: true,
                          items: viewModel.expenseCategories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(category),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _showDeleteCategoryDialog(viewModel, category);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList() +
                            [
                              const DropdownMenuItem<String>(
                              value: 'Add New Category',
                              child: Text('Add New Category'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            if (newValue == 'Add New Category') {
                              _showAddCategoryDialog(viewModel);
                            } else {
                              setState(() {
                                viewModel.selectedCategory = newValue;
                              });
                            }
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
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Repeat:'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<String>(
                          value: viewModel.selectedFrequency,
                          hint: const Text('Select how often to repeat.'),
                          isExpanded: true,
                          items: viewModel.frequencies.map((String frequency) {
                            return DropdownMenuItem<String>(
                              value: frequency,
                              child: Text(frequency),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {  // Move the onChanged function here and add braces
                            setState(() {
                              viewModel.selectedFrequency = newValue;
                            });
                          },
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
                if (viewModel.validateExpense(viewModel.selectedCategory, amountController.text)) {
                  // Call the viewModel to add the expense
                  viewModel.addExpense(viewModel.selectedCategory!, double.parse(amountController.text), viewModel.selectedFrequency!);

                  // Clear the input fields and reset the selected category
                  amountController.clear();
                  viewModel.setSelectedCategory(null); // Reset the selected category

                  // Notify the user that the expense was added
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