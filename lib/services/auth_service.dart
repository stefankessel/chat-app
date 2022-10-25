import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final String _user = "Stefan";

  String get user => _user;

  void loginUser() {}

  void logoutUser() {}
}
