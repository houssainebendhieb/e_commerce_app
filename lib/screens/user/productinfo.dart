import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/provider/cartItem.dart';
import 'package:e_commerce_app/screens/user/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  @override
  static String id = "ProductInfo";
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  var _quantity = 0;

  void _addToCart(BuildContext context, Product document) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    document.pQuantity = _quantity;
    var listProduct = cartItem.products;
    bool find = false;
    for (var item in listProduct) {
      if (item.pName == document.pName) {
        find = true;
        break;
      }
    }
    if (find == false) {
      cartItem.AddProduct(document);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Product add to cart'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Product already exist in Cart'),
      ));
    }
  }

  Widget build(context) {
    Product document = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Image(image: AssetImage(document.pLocation))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  GestureDetector(
                      child: Icon(Icons.shopping_cart),
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      })
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Column(children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: MediaQuery.sizeOf(context).width * 1.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.pName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            document.pDescription,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${document.pPrice}\$",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Material(
                                    color: Colors.orange,
                                    child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _quantity++;
                                              });
                                            },
                                            child: Icon(Icons.add)))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('${_quantity}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                              const SizedBox(
                                width: 10,
                              ),
                              ClipOval(
                                child: Material(
                                    color: Colors.orange,
                                    child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_quantity > 0) _quantity--;
                                              });
                                            },
                                            child: Icon(Icons.remove)))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      minimumSize: Size(
                        MediaQuery.sizeOf(context).height * 1.1,
                        MediaQuery.sizeOf(context).width * 0.1,
                      )),
                  onPressed: () {
                    _addToCart(context, document);
                  },
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black), // Adjust text size and style
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}
