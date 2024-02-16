import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhinoapp/Model/base_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notification_viewmodel.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class SiteRequestViewModel extends BaseViewModal {
  final databaseService = DatabaseService();
  int? index;
  bool isSearch = false;
  // int? expandedTileIndex;
  List<int> expandedTileIndices = [];

  void changeIndex(int index) {
    if (index == this.index) {
      this.index = null;
      notifyListeners();
      return;
    }
    this.index = index;
    notifyListeners();
  }

  void reqSiteAproveOrReject(
      String id,
      String name,
      String email,
      String phoneNum,
      String fcm,
      String message,
      String docId,
      String contactId) {
    log('this is want :$id');
    NotificationService.sendPushMessage(fcm, "New Message", message);
    databaseService.userNotificationDB.add({
      'Message': message,
      "type": "message",
      'Date': DateTime.now(),
      "name": name,
      "email": email,
      "phone": phoneNum,
      "user id": id,
      "isRead": false,
    });
    databaseService.userSiteDB
        .doc(docId)
        .collection("Contacts")
        .doc(contactId)
        .update({
      "Notifications": FieldValue.increment(1),
    });
  }
}
