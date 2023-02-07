import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  User? get user {
    return _user;
  }
}