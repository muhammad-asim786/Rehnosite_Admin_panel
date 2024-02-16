import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class NumberModel extends ChangeNotifier {
  bool isSearch = false;
  DatabaseService dbservice = DatabaseService();
  List<dynamic> contacts = [];
  List<dynamic> searchList = [];

  NumberModel() {
    getnames();
  }

  Future<void> getnames() async {
    try {
      var querySnapshot = await dbservice.companycalls.get();
      contacts = querySnapshot.docs[0].data()['detalis'];
      notifyListeners();
    } catch (e) {
      log('Error fetching names: $e');
      contacts = [];
    }
  }

  void searchQuer(String val) {
    String value = val.toLowerCase();
    isSearch = true;
    searchList = contacts
        .where((element) =>
            element['name'].toString().toLowerCase().contains(value) ||
            element['phone'].toString().toLowerCase().contains(value))
        .toList();
    notifyListeners();
  }

  // deleteContact through index;
  Future<void> removeItemFromJobList(int index) async {
    try {
      DocumentReference documentRef = dbservice.companycalls.doc('phoneNumber');
      DocumentSnapshot docSnapshot = await documentRef.get();
      if (docSnapshot.exists) {
        List<dynamic> jobList = docSnapshot['detalis'] ?? [];
        if (index >= 0 && index < jobList.length) {
          jobList.removeAt(index);
          await documentRef.update({'detalis': jobList});
          contacts.removeAt(index);
          log('Item removed successfully.');
        } else {
          print('Index out of range.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error removing item: $e');
    }
  }
}
