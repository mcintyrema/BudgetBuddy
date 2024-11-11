import 'package:budget_buddy_proj/view/log_expense_view.dart';
import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';
import 'package:budget_buddy_proj/view/profile_page_view.dart';
import 'package:budget_buddy_proj/view_model/profile_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_buddy_proj/view/log_expense_modal_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LogExpenseViewModel(),
      create: (context) => ProfilePageViewModel(),
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
    const HomePage(), // View expenses page
    const LogExpenseView(), // Log expenses page
    const ProfilePageView(),
    // Add Profile Page here
  ];

  final List<String> _titles = [
    'BudgetBuddy',  // Change to be Month dropdown
    'Log Expense',  // Title for Log Expense Page
    'Profile', // Title for Profile page
    // Add Title for Profile Page here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_titles[_selectedIndex]),  // Update title based on selected index
      ),
      body: _pages[_selectedIndex],  // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Log Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Profile Page',
          ),
          // Add Profile Page Item here
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Use Stack to position the content and the FAB
        children: [
          Center(
            child: Text('Your main content here'), // Placeholder for main content
          ),
          // FAB positioned at the top
          Positioned(
            top: 56, // Adjust to be closer to the AppBar
            right: 16, // Distance from the right
            child: FloatingActionButton(
              onPressed: () {
                _showAddExpenseModal(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExpenseModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20), // Padding for dialog
          child: SingleChildScrollView( // Enable scrolling if content is too long
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: QuickAddExpenseView(), // Display the QuickAddExpenseView modal
            ),
          ),
        );
      },
    );
  }
}
