import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:flutter/material.dart';

class LogExpenseView extends StatefulWidget {
  const LogExpenseView({Key? key}) : super(key: key);

  @override
  State<LogExpenseView> createState() => _LogExpensePageState();
}

class _LogExpensePageState extends State<LogExpenseView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Expense"),
      ),
      body: Center(
        child: const Text(
          "This is the Log Expense page!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
