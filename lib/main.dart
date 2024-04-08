import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp((MaterialApp(
    initialRoute: LoginScreen.id,
    routes: {
      LoginScreen.id: (context) => LoginScreen(),
      SignUpScreen.id: (context) => SignUpScreen(),
    },
  )));
}
