import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rhinoapp/Model/base_model.dart';
import 'package:rhinoapp/Model/contact_model.dart';
import 'package:rhinoapp/service/firebase_database.dart';

List<HubContactModel> contactList = [];
List<HubContactModel> filteredContactList = [];

class ContactViewModel extends BaseViewModal {
  // ContactViewModel() {
  //   getAllContacts();
  // }
  ContactModel contactModel = ContactModel();
  DatabaseService databaseService = DatabaseService();

//global key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  String? searchText = '';
  bool isSearch = false;

  searchContact(String? searchText) {
    this.searchText = searchText;
    notifyListeners();
  }

  //add contacts
  addContact() async {
    try {
      log('i am in try');
      // first get all contact snapshot and email store in emailList
      final snapshot = await databaseService.contactServiceDB.get();
      if (snapshot.docs.length > -1) {
        List<String> emailList = [];
        snapshot.docs.forEach((element) {
          emailList.add(element["email"]);
        });
        //check condition if email exist
        if (emailList.contains(emailController.text)) {
          Fluttertoast.showToast(
              msg: "Email already exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              webPosition: "center",
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red.shade300,
              textColor: Colors.white,
              fontSize: 16.0);
          clearValue();
          emailList.clear();
          notifyListeners();
        } else {
          log('i am in else');
          //add another contact
          contactModel.name = nameController.text;
          contactModel.jobTitle = jobTitleController.text;
          contactModel.email = emailController.text;
          contactModel.phone = phonController.text;
          contactModel.companyName = companyController.text;
          clearValue();
          notifyListeners();
          await databaseService.addContact(contactModel);
          contactModel = ContactModel();
          Fluttertoast.showToast(
              msg: "Contact added successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              webPosition: "center",
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red.shade300,
              textColor: Colors.white,
              webBgColor: "#e74c3c",
              fontSize: 16.0);
          notifyListeners();
        }
      }
    } catch (e) {
      log("error" + e.toString());
    }
  }

  clearValue() {
    nameController.clear();
    jobTitleController.clear();
    emailController.clear();
    phonController.clear();
    companyController.clear();
  }

  // delete contact;
  Future<void> deleteContact(String id, String email) async {
    log('this is email ' + email);
    await databaseService.contactServiceDB.doc(id).delete();
    deleteDaFromSite(email);
    Fluttertoast.showToast(
        msg: "Contact deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        webPosition: "center",
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
        webBgColor: "#e74c3c",
        fontSize: 16.0);

    notifyListeners();
  }

  void showDilog(BuildContext context, String id, String email) {
    // show the dilog box
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Are you sure you want to delete this number?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
              TextButton(
                  onPressed: () {
                    deleteContact(id, email);
                    Navigator.pop(context);
                  },
                  child: Text('Yes')),
            ],
          );
        });
  }

  // delete data form the site Collection;
  void deleteDaFromSite(String email) async {
    List<String> userEmails = [];
    try {
      await FirebaseFirestore.instance.collection('Site').get().then((value) {
        value.docs.forEach((element) {
          userEmails.add(element.reference.id);
          element.reference
              .collection('Contacts')
              .where('email', isEqualTo: email)
              .get()
              .then((value) {
            value.docs.forEach((element) {
              element.reference.delete();
            });
          });
        });
      }).then((value) => log('your is site and contact is clear'));
      await databaseService.contactServiceDB
          .doc()
          .collection('Contacts')
          .where('email', isEqualTo: email)
          .get()
          .then((docrefrenc) {
        docrefrenc.docs.forEach((doc) {
          doc.reference.delete();
        });
      }).then((value) => log('your is contact is clear'));
      for (var e in userEmails) {
        final collection = FirebaseFirestore.instance.collection('Site');
        DocumentSnapshot document = await collection.doc(e).get();
        if (document.exists) {
          List<dynamic> users = document['Contacts'];
          users.removeWhere((user) => user['email'] == email);
          await collection.doc(e).update({'Contacts': users});
        }
      }
      FirebaseFirestore.instance
          .collection('SiteRequest')
          .where('Contact email', isEqualTo: email)
          .get()
          .then((docrefrenc) {
        docrefrenc.docs.forEach((doc) {
          doc.reference.delete();
        });
      }).then((value) => log('your is SiteResquest is clear'));
      FirebaseFirestore.instance
          .collection('Chat')
          .where('userEmail', isEqualTo: email)
          .get()
          .then((docrefrenc) {
        docrefrenc.docs.forEach((doc) {
          doc.reference.delete();
        });
      }).then((value) => log('Your is chat is clear'));
    } catch (e) {
      log('this is you error : $e');
    }
  }

  var contactStream =
      FirebaseFirestore.instance.collection('hubspotContact').snapshots();

  // searching the contats;
  void serachContact(String searchText) {
    filteredContactList.clear();

    if (nameController.text.isNotEmpty) {
      isSearch = true;
      notifyListeners();
    } else {
      isSearch = false;
      notifyListeners();
    }
    log('this is the length of the contactList ${contactList.length}');
    filteredContactList = contactList
        .where((e) => e.name!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    log('this is my want lenght: ${filteredContactList.length}');
    notifyListeners();
  }

  //get all Contacts;
  Future<void> getAllContacts() async {
    final contactStream =
        FirebaseFirestore.instance.collection('hubspotContact');
    const batchSize = 3000; // Adjust the batch size as needed

    try {
      QuerySnapshot value;
      do {
        // Fetch data in batches
        value = await contactStream.limit(batchSize).get();

        // Clear existing data in the contactList before populating it
        contactList.clear();

        // Populate contactList with the current batch of documents
        value.docs.forEach((element) {
          contactList.add(
              HubContactModel.fromJson(element.data() as Map<String, dynamic>));
        });

        // Log the length of the current batch
        log('Processing batch, current length: ${contactList.length}');

        // Notify listeners after processing each batch
        notifyListeners();
      } while (value.docs.length == batchSize);

      // Log the total length after fetching all data
      log('Total length of data: ${contactList.length}');
    } catch (e) {
      // Handle errors
      log('Error: $e');
    }

    // Notify listeners after the asynchronous operation is complete
    notifyListeners();
  }
}
