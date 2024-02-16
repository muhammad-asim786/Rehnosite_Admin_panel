import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class ProductViewModel extends ChangeNotifier {
  final databaseService = DatabaseService();
  String? searchProduct = '';

//add products
  void addProduct() async {
    await databaseService.productsDB.add({
      "image":
          "https://firebasestorage.googleapis.com/v0/b/rhsite-web.appspot.com/o/images%2F1684415293873000?alt=media&token=e316192e-70f2-4aaa-aeb0-412c52a7e80e",
      "price": "10",
      "item name": "Tomato Burger",
      "description": "Tomato Burger with cheese and tomato sauce",
    });

    notifyListeners();
    log("product added");
  }

  //update products

  void updateTheProductStatus(String id) async {
    await databaseService.placeOrderDB.doc(id).update({"status": "delivered"});
  }

  //search products

  void searchProductByName(String? searchProduct) {
    this.searchProduct = searchProduct;
    notifyListeners();
  }
}
