import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_buddy_proj/view_model/profile_page_view_model.dart';
import 'package:intl/intl.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _selectedDate;

  // Date picker for selecting birthday
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to save profile
  void _saveProfile(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Provider.of<ProfilePageViewModel>(context, listen: false).updateProfile(
        newName: _nameController.text,
        newPassword: _passwordController.text,
        newBirthday: _selectedDate,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile saved successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Birthday: Not set'
                        : 'Birthday: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () => _saveProfile(context),
                  child: Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
