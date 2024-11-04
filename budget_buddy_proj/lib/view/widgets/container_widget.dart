import 'package:flutter/material.dart';
import 'package:budget_buddy_proj/view_model/log_expense_view_model.dart';

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  _ContainerWidgetState createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Container example"),
        ),
        body: Container(
          height: 200,
          width: double.infinity,
          color: Colors.purple,
          child: const Center(
            child: Text(
              "Hello! I am inside a container!",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
