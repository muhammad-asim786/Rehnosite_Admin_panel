// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notification_viewmodel.dart';
import 'package:rhinoapp/service/firebase_database.dart';

import '../../../../../Utils/flutter_toast.dart';

class SiteViewmodel extends ChangeNotifier {
  // selected value
  Map<String, bool> selectedMap = {};

  // selectedData which contains
  void selectData(String id) {
    if (selectedMap.containsKey(id)) {
      selectedMap.remove(id);
      selectedMap.clear();
    } else {
      selectedMap.clear();
      selectedMap[id] = true;
    }
    notifyListeners();
  }

  void clearSelectedData() {
    selectedMap.clear();
    notifyListeners();
  }

  DatabaseService databaseService = DatabaseService();
  int indexValue = -1;
  int storeValue = 0;
  String? collectionId = '';
  String? docId = '';
  String? serviceLevel = '';
  String? phoneNumber = '';
  String? currentSite;

  List<String> serviceList = [];

  String? selectedValue = '';
  String selectEmail = '';

  String? chatRoomId = '';
  List<MessageModel> messageList = [];

  String? contactName = '';

  List<MetaDataModel> metaDataList = [];
  // String? documentId = '';
//change index for color

  changeIndex(int index) {
    indexValue = index;

    notifyListeners();
  }

  //change selected value
  changeSelectedValue(String? value, String? email, String phoneNumber) {
    log("selectValue:::$value");
    selectedValue = value;
    selectEmail = email!;
    this.phoneNumber = phoneNumber;
    // documentId = id;
    notifyListeners();
  }

  //change contact name
  setContactName(String value) {
    contactName = value;
    log("setContactName::$contactName");
    notifyListeners();
  }

  setTheCurrentSite(String currentSite) {
    this.currentSite = currentSite;
    notifyListeners();
  }

  //change service level
  changeServiceLevel(String? value) {
    serviceLevel = value;

    log("serviceLevel::$serviceLevel");
  }

  void changeServiceValue(String? value, String? id) async {
    await databaseService.userSiteDB
        .doc(collectionId)
        .collection("Contacts")
        .doc(docId)
        .collection("Services")
        .doc(id)
        .update({
      "service level": value,
    });
  }

// set collection and doc id
  void setCollectionAndDocId(String collectionId, String docId) {
    this.collectionId = collectionId;
    this.docId = docId;
  }

  //add site
  addSite(String? value) async {
    log("value::$value");
    print(value);
    //first check the enter siteName exist
    final snapshot = await databaseService.userSiteDB.get();
    if (snapshot.docs.length > 0) {
      List<String> siteNameList = [];
      for (var data in snapshot.docs) {
        siteNameList.add(data["Site Name"].toString().toLowerCase());
      }

      // check if exist or not

      if (siteNameList.contains(value!.toLowerCase())) {
        FlutterTost.customToast("Site Name already exist");
        return;
      } else {
        log("value::$value");
        // add site name
        await databaseService.addSite(value);
        FlutterTost.customToast("SiteName added Successfully");
      }
    } else {
      await databaseService.addSite(value);
      FlutterTost.customToast("SiteName added Successfully");
    }
    notifyListeners();
  }

  //change the applies

  void updateApplies(bool applies, String? serviceId) async {
    await databaseService.userSiteDB
        .doc(collectionId)
        .collection("Contacts")
        .doc(docId)
        .collection("Services")
        .doc(serviceId)
        .update({
      "applies": applies,
    });
  }

  //add name of contact in site
  void addContactName(
    String id,
    String value,
    String email,
    String? phoneNumber,
  ) async {
    String password = "1234";
    print(id);
    print(value);
    List<String> contactList = [];
    contactList.clear();

// get all the contact name

    await databaseService.userSiteDB
        .doc(id)
        .collection("Contacts")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        contactList.add(element["name"].toString());
      });
    });
    // check the name in the contactList if contains then can not assign again
    if (contactList.contains(value)) {
      log("Value already exist");

      // Get.snackbar("Error", "Value already exist");
    }
    //
    else {
      //here first check for contact exist in the all sites if exist then
      // can not send email again

      //get all siteService
      final snapshot = await databaseService.userSiteDB.get();
      List dommyContact = [];
      for (var data in snapshot.docs) {
        dommyContact.addAll(data["Contacts"]);
      }

      // check email if contain in the list then only add contact to the site but does not send email otherwise send email also

      bool isExist = containsName(dommyContact, email);

      if (isExist) {
        //  sendEmailToCustomer(email);

        await databaseService.userSiteDB.doc(id).update({
          "Contacts": FieldValue.arrayUnion([
            {
              "email": email,
              "password": password,
            }
          ])
        });

        await databaseService.userSiteDB.doc(id).collection("Contacts").add({
          "name": value,
          "email": email,
          "password": password,
          "time": Timestamp.now(),
          "token": "",
          "phoneNumber": phoneNumber,
          "Notifications": 0,
          "Messages": 0,
        });
      }
      // when email does not exist in the given list then also send email with contacts
      else {
        sendEmailToCustomer(email);

        await databaseService.userSiteDB.doc(id).update({
          "Contacts": FieldValue.arrayUnion([
            {
              "email": email,
              "password": password,
            }
          ])
        });

        await databaseService.userSiteDB.doc(id).collection("Contacts").add({
          "name": value,
          "email": email,
          "password": password,
          "time": Timestamp.now(),
          "token": "",
          "phoneNumber": phoneNumber,
          "Notifications": 0,
          "Messages": 0,
        });
      }
    }

    indexValue = -1;
    notifyListeners();
  }

  //delete the contact from site
  void deleteContactName(String id, String? docId) async {
    print(id);

    await databaseService.userSiteDB
        .doc(id)
        .collection("Contacts")
        .doc(docId)
        .delete();
    notifyListeners();
  }

  // asign Service

  void assignService(
      {String? service,
      String? siteDocId,
      String? serviceId,
      bool? isTrue}) async {
    DocumentSnapshot snapshot =
        await databaseService.siteDB.doc(siteDocId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    //check condition

    if (isTrue!) {
      print('store value as:$storeValue');
      print("serviceId::$serviceId");

      //get contactName
      List nameOfContact = data["nameOfContact"];
      print(nameOfContact);

      //get Store id
      List contactId = nameOfContact[storeValue]["ContactId"];
      print(contactId);

      contactId.add(serviceId);
      nameOfContact[storeValue]["ContactId"] = contactId;
      print(nameOfContact);

      await databaseService.siteDB
          .doc(siteDocId)
          .update({"nameOfContact": nameOfContact});

      // await databaseService.assingService.doc(serviceId).set({
      //   "Service name": service,
      //   "serviceId": serviceId,
      //   "siteId": siteDocId,
      //   "time": Timestamp.now(),
      // });
    } else {
      List nameOfContact = data["nameOfContact"];

      log(nameOfContact.toString());
      List contactId = nameOfContact[storeValue]["ContactId"];

      contactId.removeAt(storeValue);
      nameOfContact[storeValue]["ContactId"] = contactId;
      print(nameOfContact);

      await databaseService.siteDB
          .doc(siteDocId)
          .update({"nameOfContact": nameOfContact});

      // nameOfContact.removeAt(storeValue);
      // await databaseService.siteDB
      //     .doc(siteDocId)
      //     .update({"nameOfContact": nameOfContact});

      // await databaseService.siteDB.doc(siteDocId).update({
      //   "asignService": FieldValue.arrayRemove([serviceId])
      // });
      // await databaseService.assingService.doc(serviceId).delete();
    }
  }

  //create chat room id
  // Future<String> createChatRoomId(String userId, String contactId) async {
  //   try {
  //     if (userId.substring(0, 1).codeUnitAt(0) >
  //         contactId.substring(0, 1).codeUnitAt(0)) {
  //       return "$contactId\_$userId";
  //     } else {
  //       return "$userId\_$contactId";
  //     }
  //   } catch (e) {
  //     log("error in create chat room id" + e.toString());
  //     return "";
  //   }
  // }

  String createChatRoomIdnew(String user1, user2) {
    log("user 1 is $user1");
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  //create chat room

  void chatRoom(String chatRoomId, String contactName, String contactId,
      String siteId, String userEmai) async {
    log('this is you want i dddd :$siteId');
    try {
      this.chatRoomId = chatRoomId;
      final snapshot = await databaseService.userSiteDB.doc(siteId).get();
      await databaseService.chatDB.doc(chatRoomId).get().then((value) {
        if (value.exists) {
          FlutterTost.customToast("Chat Room Already Exist with this user");
        } else {
          databaseService.chatDB.doc(chatRoomId).set({
            "chatRoomId": chatRoomId,
            "time": Timestamp.now(),
            "contactName": contactName,
            "lastMessage": '',
            "Admin": 'Admin',
            "userEmail": userEmai,
            "contactId": contactId,
            "users": [contactId],
            "unreadByAdmin": false,
            "unreadByUser": false,
            "currentSite": snapshot.data()!["Site Name"],
          });
        }
      });
      notifyListeners();
    } catch (e) {
      print("error in chat room" + e.toString());
    }
  }

  //send message

  void sendMessage(String message) async {
    log(contactName.toString());
    print('message Portion');
    try {
      await databaseService.chatDB
          .doc(this.chatRoomId)
          .collection("Message")
          .add({
        "message": message,
        "sendBy": 'Admin',
        "time": Timestamp.now(),
      });
      await databaseService.chatDB.doc(this.chatRoomId).update({
        "lastMessage": message,
        "time": Timestamp.now(),
        "unreadByUser": true,
      });

      //send notification

      final snapshot = await databaseService.userSiteDB.get();
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((element) async {
          if (element["Site Name"] == currentSite) {
            await databaseService.userSiteDB
                .doc(element.id)
                .collection("Contacts")
                .get()
                .then((value) {
              if (value.docs.isNotEmpty) {
                value.docs.forEach((e1) {
                  if (e1["name"] == contactName) {
                    //! send notification
                    NotificationService.sendPushMessage(
                        e1["token"], "New Message", message);

                    databaseService.userSiteDB
                        .doc(element.id)
                        .collection("Contacts")
                        .doc(e1.id)
                        .update({
                      "Messages": FieldValue.increment(1),
                      "Notifications": FieldValue.increment(1),
                    });

                    log("message send successfully");
                    log("name::${e1['name']}");

                    databaseService.userNotificationDB.add({
                      'Message': message,
                      "type": "message",
                      'Date': DateTime.now(),
                      "name": e1['name'],
                      "email": e1['email'],
                      "phone": e1['phoneNumber'],
                      "user id": e1.id,
                      "isRead": false,
                    });
                  }
                });
              }
            });
          }
        });
      }
    } catch (e) {
      print("error in send message" + e.toString());
    }
  }

//get all message
  getMessage(String chatId) async {
    messageList.clear();
    this.chatRoomId = chatId;
    log("chatId::$chatId");
    databaseService.chatDB
        .doc(chatId)
        .collection("Message")
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      messageList.clear();

      event.docs.forEach((element) {
        messageList.add(MessageModel(
          message: element["message"],
          sendBy: element["sendBy"],
          time: element["time"],
        ));
      });

      log("messageList::${messageList.length}");

      notifyListeners();
    });
  }

  // update unread message by admin

  void updateUnreadMessageByAdmin(String chatId) async {
    await databaseService.chatDB.doc(chatId).update({
      "unreadByAdmin": false,
    });
  }

  void getMetaData() async {
    log("GetMeta Data function called");
    databaseService.chatDB
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      metaDataList.clear();
      event.docs.forEach((element) {
        metaDataList.add(
          MetaDataModel(
            chatRoomId: element["chatRoomId"],
            contactName: element["contactName"],
            lastMessage: element["lastMessage"],
            time: element["time"],
            unreadByAdmin: element["unreadByAdmin"],
            currentSite: element["currentSite"],
          ),
        );
      });
      print("metaDataList::${metaDataList.length}");
      notifyListeners();
    });
  }

  //delete chat

  void deleteChat(String chatId) async {
    await databaseService.chatDB.doc(chatId).delete();
  }

  //get all service

  void getService(String collectionId, String docId) async {
    serviceList.clear();
    log("collectionId::$collectionId");
    log("docId::$docId");
    databaseService.userSiteDB
        .doc(collectionId)
        .collection("Contacts")
        .doc(docId)
        .collection("Services")
        .snapshots()
        .listen((event) {
      serviceList.clear();
      event.docs.forEach((element) {
        serviceList.add(element["service"]);
      });
      log("serviceList::${serviceList.length}");
    });
  }

  //set service to specific contact

  void setService({
    String? collectionId,
    String? docId,
    bool? applies,
    String? service,
    String? serviceLevel,
    String? startDate,
    String? serviceProvider,
    String? email,
    String? color,
    List? serviceList,

    //String? nextDate,
  }) async {
    log("collectionId::$collectionId");
    log("docId::$docId");

    final snap = await databaseService.userSiteDB.doc(collectionId).get();

    await databaseService.userSiteDB
        .doc(collectionId)
        .collection("Contacts")
        .doc(docId)
        .collection("Services")
        .add({
      "service": service,
      "applies": applies,
      "service level": serviceLevel,
      "start date": startDate,
      "service provider": serviceProvider,
      "email": email,
      "color": color,
      "service list": serviceList,
      "Site Name": snap.data()!["Site Name"],
      "next date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    });
  }

  //void delete service

  void deleteService(String? serviceId) async {
    await databaseService.userSiteDB
        .doc(collectionId)
        .collection("Contacts")
        .doc(docId)
        .collection("Services")
        .doc(serviceId)
        .delete();
  }

  //change date
  void updateDate(String date, String? serviceId) async {
    await databaseService.userSiteDB
        .doc(collectionId)
        .collection("Contacts")
        .doc(docId)
        .collection("Services")
        .doc(serviceId)
        .update({
      "start date": date,
    });
  }

  void deleteSiteContact(
    String siteId,
    String email,
    String password,
  ) async {
    final snapshot = await databaseService.userSiteDB.doc(siteId).get();
    List<dynamic> contactList = snapshot.data()!["Contacts"];
    var obj = {};
    for (var i = 0; i < contactList.length; i++) {
      if (contactList[i]["email"] == email &&
          contactList[i]["password"] == password) {
        obj = contactList[i];
      }
    }

    contactList.remove(obj);
    await databaseService.userSiteDB.doc(siteId).update({
      "Contacts": contactList,
    });

    notifyListeners();
  }

  //sending email

  sendEmailToCustomer(
    String email,
  ) async {
    final serviceId1 = "service_f8xsk67";
    final templateId1 = "template_g1uhxus";
    final userId1 = "t-ELWq-b3BQlhXGQN";
    final url1 = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(url1,
        headers: {
          "origin": "http://localhost",
          "Content-Type": "application/json"
        },
        body: json.encode(
          {
            "service_id": serviceId1,
            "template_id": templateId1,
            "user_id": userId1,
            "template_params": {
              // "from_email": fromEmail,
              "to_send": email,
              "reply_to": "arbabshujaat8@gmail.com",
              "from_name": "RhinoSite",

              "email": email,
              "password": "1234"
            }
          },
        ));
    log("email send to user");
  }

  //search in inbox by name
  String searchName = "";

  void searchByName(String name) {
    searchName = name;
    notifyListeners();
  }

  // check if name exist in list
  bool containsName(List<dynamic> list, String name) {
    for (var item in list) {
      if (item['email'] == name) {
        return true;
      }
    }
    return false;
  }
}

class MessageModel {
  String? message;
  String? sendBy;
  Timestamp? time;

  MessageModel({this.message, this.sendBy, this.time});
}

class MetaDataModel {
  String? contactName;
  String? chatRoomId;
  String? lastMessage;
  Timestamp? time;
  bool? unreadByAdmin;
  String? currentSite;

  MetaDataModel({
    this.chatRoomId,
    this.contactName,
    this.lastMessage,
    this.time,
    this.unreadByAdmin,
    this.currentSite,
  });
}
