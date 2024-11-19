import 'package:flutter/material.dart';

class BudgetViewModel extends ChangeNotifier {
  double plannedBudget = 0.0;
  double totalSpending = 0.0;
  Map<String, double> categorySpending = {};

  void updatePlannedBudget(double newBudget) {
    plannedBudget = newBudget;
    notifyListeners();
  }

  void addSpending(String category, double amount) {
    if (categorySpending.containsKey(category)) {
      categorySpending[category] = categorySpending[category]! + amount;
    } else {
      categorySpending[category] = amount;
    }
    totalSpending += amount;
    notifyListeners();
  }

  void resetBudget() {
    plannedBudget = 0.0;
    totalSpending = 0.0;
    categorySpending.clear();
    notifyListeners();
  }

  double get remainingBalance {
    return plannedBudget - totalSpending;
  }

  List<MapEntry<String, double>> get sortedCategorySpending {
    var sorted = categorySpending.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted;
  }
}
