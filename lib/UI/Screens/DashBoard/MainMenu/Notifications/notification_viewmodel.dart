import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class NotificationViewModel extends ChangeNotifier {
  DatabaseService databaseService = DatabaseService();
  List<String> siteName = [];
  String? selectSiteValue;

  int notificationCount = 0;

// count the number of notifications
  receiveNewNotification() async {
    notificationCount = 0;
    databaseService.adminNotificationCountDB
        .doc("notifications_count")
        .snapshots()
        .listen((event) {
      notificationCount = int.parse(event["notifications"].toString());
    });
    log("==========>>" + notificationCount.toString());
    notifyListeners();
  }

  // recete the notification count

  resetNotificationCount() async {
    await databaseService.adminNotificationCountDB
        .doc("notifications_count")
        .update({
      "notifications": 0,
    });

    notifyListeners();
  }

//send notification to all users

  void sendingNotificationToUser(
      String siteName, String message, String notificationType, image) async {
    final snapshot = await databaseService.userSiteDB.get();
    String? docId = '';

    //upload file to firebase storage
    String? url;

    if (image.isNotEmpty) {
      final refresend = await FirebaseStorage.instance
          .ref('images')
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putData(image);

      url = await refresend.ref.getDownloadURL();
      log("==========>>");
      print(url);
    }

    //check if the site name is in the database

    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        if (doc.data()['Site Name'] == siteName) {
          docId = doc.id;
          break;
        }
      }

      //if the site name is in the database send notification to all users

      await databaseService.userSiteDB
          .doc(docId)
          .collection("Notifications")
          .add({
        'Message': message,
        "type": notificationType,
        "site name": siteName,
        'Date': DateTime.now(),
        'Image': url ?? '',
      });

      await databaseService.userSiteDB
          .doc(docId)
          .collection("Contacts")
          .get()
          .then((value) async {
        for (var doc in value.docs) {
          log("==========>>");
          print(doc.id);
          print("token=======>>: ${doc.data()['token']}");

          //send notification to all users
          NotificationService.sendPushMessage(
              doc.data()['token'], "New Feed ", "New Feed is added");

          //add user notification to the database

          databaseService.userNotificationDB.add({
            'Message': message,
            "type": notificationType,
            'Date': DateTime.now(),
            "name": doc.data()['name'],
            "email": doc.data()['email'],
            "phone": doc.data()['phoneNumber'],
            "user id": doc.id,
            "isRead": false,
          });

//update the notification count

          databaseService.userSiteDB
              .doc(docId)
              .collection("Contacts")
              .doc(doc.id)
              .update({
            "Notifications": FieldValue.increment(1),
          });
        }
      });
      selectSiteValue = null;
      notifyListeners();
    } else {
      print("Site name not found");
    }
  }

  //get all the site name from the database

  void getSiteName() async {
    siteName.clear();

    notifyListeners();
    final snapshot = await databaseService.userSiteDB.get();
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        siteName.add(doc.data()['Site Name']);
      }
    }

    log("==========>>");
    log("get all site name from the database${siteName.length}}");
    notifyListeners();
  }

  //clear all the Admin notification

  void clearAllAdminNotification() async {
    await databaseService.adminNotificatoinDB.snapshots().forEach((element) {
      for (var doc in element.docs) {
        doc.reference.delete();
      }
    });
  }

// click on specific notification

  void clickOnNotificationAndMoveToSpecificRoute(
    DocumentSnapshot data,
    SideBarCount sideBarCount,
    SiteViewmodel siteModel,
  ) async {
    try {
      String type = data["type"];
      switch (type) {
        case "Site Request":
          sideBarCount.setIndex(10);
          break;
        case "Fault report":
          sideBarCount.setIndex(9);
          break;

        case "message":
          siteModel.getMetaData();
          sideBarCount.setIndex(5);
          break;

        case "New Service Request":
          sideBarCount.setIndex(11);
          break;
      }

      // update the read value in admin notification
      await databaseService.adminNotificatoinDB.doc(data.id).update({
        "read": true,
      });
    } catch (e) {}
  }
}

//send notification

class NotificationService {
  static sendPushMessage(String fcmtoken, String title, String body) async {
    try {
      await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization":
                "key=AAAAFAipiDI:APA91bEdMsMZWUvDxcRTYEAXsBxY3dNho3HcrdSYILuKgY9fgUWlf05JIZwDS-Sxyj3wXFMOxzKxBlnvHwR-iQK1kWjz1uRXimT3RAMbZU5HZIiIGZETkcAG-XWVQq_fvl1FrW-8L-Wu"
          },
          body: jsonEncode(<String, dynamic>{
            "priority": "high",
            "data": <String, dynamic>{
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "status": "done",
              "body": body,
              "title": title,
            },
            "to": fcmtoken,
            "notification": {
              "title": title,
              "body": body,
              "mutable_content": true,
              "sound": "Tri-tone",
              "android_channel_id": "abce"
            },
          }));
    } catch (e) {
      print("some error");
    }
  }

  // when click on notification move to specific
}
