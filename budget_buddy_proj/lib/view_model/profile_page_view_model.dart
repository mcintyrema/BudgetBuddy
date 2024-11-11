import 'package:flutter/material.dart';

class ProfilePageViewModel extends ChangeNotifier {
  String name = '';
  String password = '';
  DateTime? birthday;

  // Method to update the profile information
  void updateProfile({required String newName, required String newPassword, DateTime? newBirthday}) {
    name = newName;
    password = newPassword;
    birthday = newBirthday;
    notifyListeners();
  }
}
