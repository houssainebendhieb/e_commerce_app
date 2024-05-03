import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/provider/cartItem.dart';
import 'package:e_commerce_app/screens/user/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id = "CartScreen";
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget build(context) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    List<Product> products = cartItem.products;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenweight = MediaQuery.sizeOf(context).width;
    final appBarHeight = AppBar().preferredSize.height;
    final height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (products.isEmpty) {
              return Container(
                height: screenHeight -
                    (screenHeight * 0.08) -
                    appBarHeight -
                    height,
                child: Center(child: Text('Cart is Empty')),
              );
            } else {
              return Container(
                height: screenHeight -
                    height -
                    appBarHeight -
                    (screenHeight * 0.08),
                width: screenweight,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapUp: (details) {
                        var dx = details.globalPosition.dx;
                        var dy = details.globalPosition.dy;
                        var dx2 = MediaQuery.sizeOf(context).width - dx;
                        var dy2 = MediaQuery.sizeOf(context).width - dy;
                        showMenu(
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            context: context,
                            //   position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              PopupMenuItem(
                                  child: Text('Edit'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    cartItem.deleteProduct(products[index]);
                                    Navigator.pushNamed(context, ProductInfo.id,
                                        arguments: products[index]);
                                  }),
                              PopupMenuItem(
                                child: Text('Delete'),
                                onTap: () {
                                  setState(() {
                                    cartItem.deleteProduct(products[index]);
                                  });
                                },
                              ),
                            ]);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          color: Colors.orange,
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: MediaQuery.sizeOf(context).height *
                                      0.15 /
                                      2,
                                  backgroundImage:
                                      AssetImage(products[index].pLocation)),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('\$ ${products[index].pPrice}',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                          ' ${products[index].pQuantity}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
          ElevatedButton(
              onPressed: () {
                print('order');
              },
              child: Text('Order Now'))
        ],
      ),
    );
  }
}
