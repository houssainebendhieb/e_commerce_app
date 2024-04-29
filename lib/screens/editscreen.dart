import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/store.dart';

class EditScreen extends StatefulWidget {
  static String id = "EditScreen";

  createState() {
    return _EditScreenState();
  }
}

class _EditScreenState extends State<EditScreen> {
  final store = new Store();
  Widget build(context) {
    return Scaffold(
      body: StreamBuilder(
          stream: store.loadProduct(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTapUp: (details) {
                          var dx = details.globalPosition.dx;
                          var dy = details.globalPosition.dy;
                          var dx2 = MediaQuery.sizeOf(context).width - dx;
                          var dy2 = MediaQuery.sizeOf(context).width - dy;
                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                              items: [
                                PopupMenuItem(
                                    child: Text('Edit'),
                                    onTap: () {
                                      print(" hello world");
                                    }),
                                PopupMenuItem(
                                  child: Text('Delete'),
                                  onTap: () {
                                    store.deleteProduct(document.id);
                                  },
                                ),
                              ]);
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
            }
          }),
    );
  }
}
