import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp((MaterialApp(
    initialRoute: LoginScreen.id,
    routes: {
      LoginScreen.id: (context) => LoginScreen(),
      SignUpScreen.id: (context) => SignUpScreen(),
    },
  )));
}
