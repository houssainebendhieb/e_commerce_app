import 'package:e_commerce_app/provider/adminhome.dart';
import 'package:e_commerce_app/provider/cartItem.dart';
import 'package:e_commerce_app/provider/modelhud.dart';
import 'package:e_commerce_app/screens/admin/addproduct.dart';
import 'package:e_commerce_app/screens/admin/adminpage.dart';
import 'package:e_commerce_app/screens/admin/editproduct.dart';
import 'package:e_commerce_app/screens/admin/editscreen.dart';
import 'package:e_commerce_app/screens/homepage.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:e_commerce_app/screens/user/cartscreen.dart';
import 'package:e_commerce_app/screens/user/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(create: (conext) => ModelHud()),
        ChangeNotifierProvider<CartItem>(create: (conext) => CartItem()),
        ChangeNotifierProvider<AdminHome>(create: (context) => AdminHome()),
      ],
      child: (MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          CartScreen.id: (context) => CartScreen(),
          ProductInfo.id: (context) => ProductInfo(),
          EditScreen.id: (context) => EditScreen(),
          EditProduct.id: (context) => EditProduct(),
          AddProduct.id: (context) => AddProduct(),
          AdminPage.id: (context) => AdminPage(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
        },
      )),
    ),
  );
}
