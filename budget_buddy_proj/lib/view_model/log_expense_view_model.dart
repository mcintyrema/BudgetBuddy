import 'package:budget_buddy_proj/model/log_expense_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data'; // For Uint8List
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:html' as html;

class LogExpenseViewModel extends ChangeNotifier{

  List<String> _expenseCategories = [
    'Rent',
    'Utilities',
    'Grocery',
    'Gym'
  ];

  List<String> _frequencies = [
    'Never',
    'Daily',
    'Weekly',
    'Monthly'
  ];

  final List<log_expense_model> _expenses = [];

  String? selectedFrequency;
  String? selectedCategory; 
  Uint8List? imageData;
  String? imagePath;
  String? uploadStatus;
  String? comment = '';

  List<String> get expenseCategories => List.unmodifiable(_expenseCategories);
  List<String> get frequencies => List.unmodifiable(_frequencies);
  List<log_expense_model> get expenses => List.unmodifiable(_expenses);

  Future<void> pickImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      // Get the selected file
      final file = result.files.first;

      // Check if the bytes are available
      if (file.bytes != null) {
        // Store the image bytes in your view model
        imageData = file.bytes; // Assuming imageData is a Uint8List variable in your ViewModel

        // Notify the UI to update
        notifyListeners();

        // Show a SnackBar to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo uploaded successfully!')),
        );
      }
    } else {
      // Handle the case where no image was selected
      imageData = null; // Reset imageData if no image is selected
    }
  }

  void setSelectedCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void addNewCategory(String category) {
    _expenseCategories.insert(_expenseCategories.length - 1, category);
    setSelectedCategory(category);
    notifyListeners();
  }

  // Function to delete a category
  void deleteCategory(String category) {
    if (_expenseCategories.contains(category)) {
      _expenseCategories.remove(category);
      if (selectedCategory == category) {
        selectedCategory = null;
      }
      notifyListeners();
    }
  }

  // Load categories from shared preferences (if needed)
  Future<void> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesString = prefs.getString('categories');
    if (categoriesString != null) {
      _expenseCategories = List<String>.from(json.decode(categoriesString));
      notifyListeners();
    }
  }

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

    // Debug: Print the loaded expenses to verify
    for (var expense in _expenses) {
      print(expense.toJson());
    }
  }

  // Save categories to shared preferences
  Future<void> saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('categories', json.encode(_expenseCategories));
  }

  // Save expenses as JSON to SharedPreferences
  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(_expenses.map((e) => e.toJson()).toList());
    await prefs.setString('expenses', jsonString);
  }

  void addExpense(String category, double amount, String frequency, {Uint8List? imageData, String? comment}) {
    // Create a new expense entry
    final newExpense = log_expense_model(
      category: category,
      amount: amount,
      frequency: frequency,  
      imageData: imageData != null ? imageData : null,
      comment: comment != null ? comment : null,
    );
    
    // Add to the _expenses list
    _expenses.add(newExpense);

    // Save the updated list to SharedPreferences
    saveExpenses();

    // Clear selected category after adding
    selectedCategory = null;
    selectedFrequency = null;
    this.imageData = null;
    this.comment = '';
    notifyListeners(); // Notify listeners to update the UI
  }

  bool validateExpense(String? category, String amountText) {
    final amount = double.tryParse(amountText);
    return category != null && amount != null;
  }

  @visibleForTesting
  void setTestExpenses(List<log_expense_model> expenses) {
    _expenses.clear();
    _expenses.addAll(expenses);
    notifyListeners();
  }
}