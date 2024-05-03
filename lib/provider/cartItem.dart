import 'package:e_commerce_app/Models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];

  AddProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
