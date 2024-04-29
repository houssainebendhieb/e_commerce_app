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
                      crossAxisCount: 2),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    print(document['location']);
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                            image: AssetImage(document['location']),
                          ))
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
