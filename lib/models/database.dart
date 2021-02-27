import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  Future<void> addData(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance.collection("users").snapshots();
  }

  Future<void> addProductData(Map productData, String productId) async {
    await Firestore.instance
        .collection("Info")
        .document(productId)
        .setData(productData)
        .catchError((e) {
      print(e);
    });
  }

  getProductData() async {
    return await Firestore.instance.collection("Info").snapshots();
  }

  deleteProduct(String productId) async {
    return await Firestore.instance
        .collection("Info")
        .document(productId)
        .delete();
  }
}
