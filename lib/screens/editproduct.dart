import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:e_commerce_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String id = "EditProduct";
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String _name = "",
      _price = "",
      _description = "",
      _category = "",
      _location = "";

  final globalKey = new GlobalKey<FormState>();

  Widget build(context) {
    final _id = ModalRoute.of(context)!.settings.arguments;
    print(_id);
    return Scaffold(
      body: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hint: 'Product Name',
              icon: Icon(Icons.add),
              onClick: (value) {
                _name = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: ' Product Price',
              icon: Icon(Icons.add),
              onClick: (value) {
                _price = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: 'Product Description',
              icon: Icon(Icons.add),
              onClick: (value) {
                _description = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: 'Product Category',
              icon: Icon(Icons.add),
              onClick: (value) {
                _category = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: 'Product Image',
              icon: Icon(Icons.add),
              onClick: (value) {
                _location = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    final store = new Store();
                    print(_id);
                    print(_category);
                    store.editProduct({
                      'productcategory': _category,
                      'description': _description,
                      'location': _location,
                      'productname': _name,
                      'price': _price
                    }, _id);
                    print(" i am here");
                  }
                  // globalKey.currentState!.reset();
                },
                child: Text('Modify Product'))
          ],
        ),
      ),
    );
  }
}
