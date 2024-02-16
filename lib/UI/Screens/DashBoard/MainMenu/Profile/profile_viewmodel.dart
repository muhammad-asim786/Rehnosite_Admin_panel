import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rhinoapp/service/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProfileViewmodel extends ChangeNotifier {
  DatabaseService databaseService = DatabaseService();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //for other admin

  TextEditingController otherAdminnameController = TextEditingController();
  TextEditingController otherAdminemailController = TextEditingController();
  TextEditingController otherAdmintitleController = TextEditingController();
  TextEditingController otherAdminpasswordController = TextEditingController();
  //
  SharedPreferences? sharedPreferences;
  bool isSuperAdmin = false;
  Uuid uuid = Uuid();
  bool isLoaidng = false;
  String adminId = "";
  String? selectText = "Add";
  String? docId;
  String? imgeUrl;

  ProfileViewmodel() {
    init();
  }

  init() async {
    log('this is 1');
    isLoaidng = true;
    log('this is 2');
    notifyListeners();
    sharedPreferences = await SharedPreferences.getInstance();
    log('this is 3');
    log(sharedPreferences!.getString("adminId").toString());
    log('this is 4');
    log("good" + sharedPreferences!.getBool("isSuperAdmin").toString());
    log('this is 5');
    isSuperAdmin = sharedPreferences!.getBool("isSuperAdmin") ?? false;
    log('this is $isSuperAdmin');
    log('this is 6');
    adminId = sharedPreferences!.getString("adminId").toString();
    log('this is $adminId');
    log('this is 7');
    notifyListeners();
    DocumentSnapshot snapshot =
        await databaseService.adminDB.doc(adminId).get();
    log('this is 8');
    nameController.text = snapshot["name"] ?? "";
    log('this is 9');
    emailController.text = snapshot["email"] ?? "";
    log('this is 10');
    titleController.text = snapshot["title"] ?? "";
    log('this is 11');
    passwordController.text = snapshot["password"] ?? "";
    log('this is 12');
    imgeUrl = snapshot["imgUrl"] ?? "";
    log('this is 13');
    isLoaidng = false;
    log('this is 14');
    notifyListeners();
  }

  void changeText(String text) {
    selectText = text;
    notifyListeners();
  }

  // image upload

  void uploadImageToFirebase(Uint8List image) async {
    final refresend = await FirebaseStorage.instance
        .ref('images')
        .child(DateTime.now().microsecondsSinceEpoch.toString())
        .putData(image);

    final url = await refresend.ref.getDownloadURL();
    log("==========>>");
    print(url);
    imgeUrl = url;

    await databaseService.adminDB.doc(adminId).update({
      "imgUrl": imgeUrl,
    });
    notifyListeners();
  }

  //add other admin

  addOtherAdmin() async {
    String uid = uuid.v4();

    notifyListeners();
    await databaseService.adminDB.doc(uid).set({
      "name": otherAdminnameController.text.trim(),
      "email": otherAdminemailController.text.trim(),
      "title": otherAdmintitleController.text.trim(),
      "password": otherAdminpasswordController.text.trim(),
      "isSuperAdmin": false,
      "uid": uid,
      "imgUrl": "",
    });

    notifyListeners();
  }

  //edite other admin
  editValue(DocumentSnapshot snapshot) async {
    otherAdminemailController.text = snapshot["email"] ?? "";
    otherAdminnameController.text = snapshot["name"] ?? "";
    otherAdmintitleController.text = snapshot["title"] ?? "";
    otherAdminpasswordController.text = snapshot["password"] ?? "";
    docId = snapshot.id;
    log("docId" + docId.toString());
    notifyListeners();
  }

  //update admin

  updateOtherAdmin() async {
    log(docId.toString());
    log("other admin value");
    await databaseService.adminDB.doc(docId).update({
      "name": otherAdminnameController.text.trim(),
      "email": otherAdminemailController.text.trim(),
      "title": otherAdmintitleController.text.trim(),
      "password": otherAdminpasswordController.text.trim(),
      "imgUrl": imgeUrl,
    });

    clearOtherAdmin();

    notifyListeners();
  }

  //delete admin
  deleteAdmin(String id) async {
    await databaseService.adminDB.doc(id).delete();
    notifyListeners();
  }

  clearOtherAdmin() {
    otherAdminnameController.clear();
    otherAdminemailController.clear();
    otherAdmintitleController.clear();
    otherAdminpasswordController.clear();
    notifyListeners();
  }

  //voi save other admin

  saveOtherAdmin() async {
    isLoaidng = true;
    notifyListeners();
    await databaseService.adminDB.doc(adminId).update({
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "title": titleController.text.trim(),
      "password": passwordController.text.trim(),
      "imgUrl": imgeUrl,
    });
    // init();

    isLoaidng = false;

    notifyListeners();
  }
}
