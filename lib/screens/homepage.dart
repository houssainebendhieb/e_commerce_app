import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/screens/user/cartscreen.dart';
import 'package:e_commerce_app/screens/user/productinfo.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = new Store();

  @override
  void initState() {
    super.initState();
  }

  Widget ViewProduct(String category) {
    return StreamBuilder(
        stream: _store.loadProduct(category),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final document = snapshot.data!.docs[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) {
                        Product product = new Product(
                            pCategory: document['productcategory'],
                            pDescription: document['description'],
                            pLocation: document['location'],
                            pName: document['productname'],
                            pPrice: document['price']);
                        Navigator.pushNamed(context, ProductInfo.id,
                            arguments: product);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(document['location']),
                          )),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: 0.6,
                              child: Container(
                                  height: 60,
                                  width: MediaQuery.sizeOf(context).width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(document['productname']),
                                          Text('\$ ${document['price']} ')
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
        });
  }

  var _currentIndex = 0;
  var _buttonBarIndex = 0;
  Widget build(context) {
    return Stack(children: [
      DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _buttonBarIndex,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              fixedColor: Colors.black,
              onTap: (value) {
                setState(() {
                  _buttonBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Person'),
              ]),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
                indicatorColor: Colors.grey,
                onTap: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                tabs: [
                  Text('Jackets',
                      style: TextStyle(
                          color:
                              _currentIndex == 0 ? Colors.black : Colors.grey,
                          fontSize: _currentIndex == 0 ? 16 : null)),
                  Text('Trouser',
                      style: TextStyle(
                          color:
                              _currentIndex == 1 ? Colors.black : Colors.grey,
                          fontSize: _currentIndex == 1 ? 16 : null)),
                  Text('T -shirt',
                      style: TextStyle(
                          color:
                              _currentIndex == 2 ? Colors.black : Colors.grey,
                          fontSize: _currentIndex == 2 ? 16 : null)),
                  Text('Shoes',
                      style: TextStyle(
                          color:
                              _currentIndex == 3 ? Colors.black : Colors.grey,
                          fontSize: _currentIndex == 3 ? 16 : null)),
                ]),
          ),
          body: TabBarView(children: [
            ViewProduct('jackets'),
            ViewProduct('trouser'),
            ViewProduct('t-shirt'),
            ViewProduct('shoes'),
          ]),
        ),
      ),
      Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discover'.toUpperCase(),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                GestureDetector(
                    child: Icon(Icons.shopping_cart),
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    })
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
