import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/dashboard.dart';
import 'package:rhinoapp/service/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

// bool isSuperAdmin = false;
// String adminId = "";
String chatId = "";

class LoginViewmodel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();
  SharedPreferences? sharedPreferences;
//check amdin credential

  checkAdmin(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await databaseService.adminDB.get().then((value) {
      value.docs.forEach((element) {
        if (emailController.text.trim() == element["email"] &&
            passwordController.text.trim() == element["password"]) {
          // isSuperAdmin = element["isSuperAdmin"];
          // adminId = element["uid"].toString();
          log('this is what i want to the user of the day :%${element["uid"].toString()}');
          sharedPreferences!.setString("adminId", element["uid"].toString());
          log('this is what i want to the user of the day :%${element["isSuperAdmin"]}');
          sharedPreferences!.setBool("isSuperAdmin", element["isSuperAdmin"]);
          sharedPreferences!.setBool("isLogin", true);

          //get chat id
          getChatId();
          // Navigate to DashBoard screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashBoardScreen()));
          emailController.clear();
          passwordController.clear();

          notifyListeners();
        }
      });
    });

    notifyListeners();

    //   DocumentSnapshot documentSnapshot =
    //       await databaseService.adminDB.doc("admin").get();
    //   if (documentSnapshot.exists) {
    //     if (emailController.text.trim() == documentSnapshot["email"] &&
    //         passwordController.text.trim() == documentSnapshot["password"]) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // }
  }
}

getChatId() async {
  await FirebaseFirestore.instance
      .collection("DommyId")
      .doc("chat_id")
      .get()
      .then((value) => {
            chatId = value["id"],
          });

  print("chat id is $chatId");
}
