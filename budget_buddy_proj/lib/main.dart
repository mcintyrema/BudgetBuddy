import 'package:budget_buddy_proj/view/log_expense_view.dart';
import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:budget_buddy_proj/view/profile_page_view.dart';
import 'package:budget_buddy_proj/view_model/profile_page_view_model.dart';
import 'package:budget_buddy_proj/view/budget_view.dart'; // Import the BudgetView
import 'package:budget_buddy_proj/view_model/budget_view_model.dart'; // Import the BudgetViewModel
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_buddy_proj/view/log_expense_modal_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LogExpenseViewModel()),
        ChangeNotifierProvider(create: (context) => ProfilePageViewModel()),
        ChangeNotifierProvider(create: (context) => BudgetViewModel()), // Add BudgetViewModel provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 20, 255, 4)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const LogExpenseView(), // View expenses page
    const LogExpenseView(), // Log expenses page
    const ProfilePageView(), // Profile page
    const BudgetView(), // Budget view page (added for your task)
  ];

  final List<String> _titles = [
    'BudgetBuddy',
    'Log Expense',
    'Profile',
    'Budget Overview', // Added title for the new Budget Overview page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_titles[_selectedIndex]),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Log Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), // Added icon for Budget Overview
            label: 'Budget Overview', // Added label for Budget Overview
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
