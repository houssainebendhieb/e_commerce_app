import 'package:flutter/material.dart';

class AdminHome extends ChangeNotifier {
  bool isAdmin = false;

  changeIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
