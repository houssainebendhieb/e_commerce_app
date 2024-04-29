import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Models/product.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void AddProduct(Product produt) async {
    await _firestore.collection("product").add({
      "productname": produt.pName,
      "price": produt.pPrice,
      "description": produt.pDescription,
      "location": produt.pLocation,
      "productcategory": produt.pCategory
    });
  }

  Stream<QuerySnapshot<Object?>> loadProduct() {
    return _firestore.collection("product").snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection("product").doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore.collection("product").doc(documentId).update(data);
  }
}
