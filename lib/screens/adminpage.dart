import 'package:e_commerce_app/screens/addproduct.dart';
import 'package:e_commerce_app/screens/editscreen.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static String id = "AdminPage";
  AdminPage({super.key});

  Widget build(context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text('Add Product')),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, EditScreen.id);
              },
              child: Text('Edit Product')),
          ElevatedButton(onPressed: () {}, child: Text('View Product')),
        ],
      ),
    );
  }
}
