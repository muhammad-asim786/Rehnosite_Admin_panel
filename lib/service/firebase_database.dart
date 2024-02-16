import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhinoapp/Model/contact_model.dart';

class DatabaseService {
  ContactModel contactModel = ContactModel();
  final contactServiceDB = FirebaseFirestore.instance.collection("Contacts");
  final serviceDB = FirebaseFirestore.instance.collection("Services");
  final siteDB = FirebaseFirestore.instance.collection("Sites");
  final productsDB = FirebaseFirestore.instance.collection("Products");
//
  final userSiteDB = FirebaseFirestore.instance.collection("Site");

  final adminDB = FirebaseFirestore.instance.collection("AdminCredential");
  final assingService = FirebaseFirestore.instance.collection('AssignService');
  final chatDB = FirebaseFirestore.instance.collection("Chat");
  final adminNotificatoinDB =
      FirebaseFirestore.instance.collection("Admin Notification");
  final userNotificationDB =
      FirebaseFirestore.instance.collection("User Notification");
  final reportFaultDB = FirebaseFirestore.instance.collection("ReportFault");
  final siteRequestDB = FirebaseFirestore.instance.collection("SiteRequest");
  final bookServiceRequestDB =
      FirebaseFirestore.instance.collection("BookServiceRequest");

  final placeOrderDB = FirebaseFirestore.instance.collection("Orders");
  final adminNotificationCountDB =
      FirebaseFirestore.instance.collection("AdminNotificationCount");

  final companycalls = FirebaseFirestore.instance.collection("CompanyCall");

  //add contacts
  addContact(ContactModel contactModel) async {
    log(contactModel.toJson().toString());

    try {
      await contactServiceDB.add(contactModel.toJson());
    } catch (e) {
      log("error" + e.toString());
    }
  }

  //add services

  addServices(String? value, String? email, String? phone, String name) async {
    try {
      final doc = await serviceDB.add({
        "Service name": value,
        "color": "0xffFFFFFF",
        "Service provider email": email,
        "Service provider phone": phone,
        "Service provider name": name,
        "service level": [],
      });
      await serviceDB.doc(doc.id).update({"id": doc.id});
    } catch (e) {
      log("error" + e.toString());
    }
  }

  //add site
  addSite(String? value) async {
    try {
      log("site name" + value.toString());
      await userSiteDB.add({
        "Site Name": value,
        "Contacts": [],
      });
      // await siteDB.add({
      //   "Site": value,
      //   "nameOfContact": [],
      //   // "asignService": [],
      // });
    } catch (e) {
      log("error" + e.toString());
    }
  }
}
