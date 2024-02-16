import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rhinoapp/Model/services_model.dart';
import 'package:rhinoapp/Utils/flutter_toast.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class ServiceViewModel extends ChangeNotifier {
  ServiceViewModel() {
    getServiceData();
  }

  DatabaseService databaseService = DatabaseService();
  final serviceName = TextEditingController();
  final serviceLevel = TextEditingController(text: "Select Service Level");
  final serviceProviderName = TextEditingController();
  final serviceProviderEmail = TextEditingController();
  final serviceProviderPhone = TextEditingController();

  // edit controller;
  TextEditingController editingController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  int inedex = 0;
  String? service = '';
  List<ServiceModel> serviceList = [];

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

  //get services
  getServices(String? searchLevel) {
    this.service = searchLevel;
    notifyListeners();
  }

//add services
  addService(String? values, String? email, String? phone, String? name) async {
    await databaseService.addServices(values, email, phone, name!);
    FlutterTost.customToast("Service added successfully");
    getServiceData();
    clearController();
    notifyListeners();
  }

//delete services
  deleteService(String id) async {
    await databaseService.serviceDB.doc(id).delete();
    getServiceData();
    notifyListeners();
  }

//update services

  updateService(
    String id,
    String value,
    String? name,
    String? email,
    String? phone,
  ) async {
    await databaseService.serviceDB.doc(id).update({
      "Service name": value,
      "Service provider name": name,
      "Service provider email": email,
      "Service provider phone": phone,
    });
    notifyListeners();
  }

  //update color
  updateColor(String id, String value) async {
    await databaseService.serviceDB.doc(id).update({"color": value});

    notifyListeners();
  }

  addServiceLevel(String id, String value) async {
    print(id);
    print(value);
    await databaseService.serviceDB.doc(id).update({
      "service level": FieldValue.arrayUnion([value])
    });
    notifyListeners();
  }

  //delete service level
  deleteServiceLevel(String id, String value) async {
    print(id);
    print(value);
    await databaseService.serviceDB.doc(id).update({
      "service level": FieldValue.arrayRemove([value])
    });
    notifyListeners();
  }

  // get the service level data and store it in a list;
  void getServiceData() async {
    final data = await databaseService.serviceDB.get();
    data.docs.forEach((data) {
      inedex++;
      serviceList.add(ServiceModel(
          id: data.id,
          index: inedex,
          serviceName: data["Service name"],
          serviceProviderEmail: data["Service provider email"],
          serviceProviderName: data["Service provider name"],
          serviceProviderPhone: data["Service provider phone"]));
    });
    log('this is the lenght of the service list ${serviceList.length}');
    notifyListeners();
  }

  void clearController() {
    serviceName.clear();
    serviceProviderName.clear();
    serviceProviderEmail.clear();
    serviceProviderPhone.clear();
    serviceLevel.clear();
    notifyListeners();
  }

  selecValues(String value, int index) {
    serviceLevel.text = value;
    serviceProviderName.text = serviceList[index].serviceProviderName;
    serviceProviderEmail.text = serviceList[index].serviceProviderEmail;
    serviceProviderPhone.text = serviceList[index].serviceProviderPhone;
    notifyListeners();
  }

  // edit selced values;
  editselecValues(String value, int index) {
    log('this is my name ${serviceList[index].serviceProviderName}');
    nameController.text = serviceList[index].serviceProviderName;
    emailController.text = serviceList[index].serviceProviderEmail;
    phoneController.text = serviceList[index].serviceProviderPhone;
    notifyListeners();
  }

  Future<void> removeDuplicates() async {
    log('this is called');
    Set<String> uniqueProviderNames = Set<String>();
    List<ServiceModel> uniqueServiceList = [];

    for (ServiceModel service in serviceList) {
      if (!uniqueProviderNames.contains(service.serviceProviderName)) {
        uniqueProviderNames.add(service.serviceProviderName);
        uniqueServiceList.add(service);
      }
    }

    // Update your original serviceList with the unique entries
    serviceList = List.from(uniqueServiceList);
    notifyListeners();
  }

  deleteServiceNme(String id) async {
    log('i am called here:');
    await databaseService.serviceDB
        .where("Service provider name", isEqualTo: id)
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          element.reference.update({"Service provider name": ''});
        });
      },
    );
    serviceList.clear();
    getServiceData();
    notifyListeners();
  }

  final serviceProviderNameEdit = TextEditingController();
  final serviceProviderEmailEdit = TextEditingController();
  final serviceProviderPhoneEdit = TextEditingController();
  assigneOldData(int index) async {
    log('this is i want index .......=========.....> $index');
    serviceProviderNameEdit.text = serviceList[index].serviceProviderName;
    serviceProviderEmailEdit.text = serviceList[index].serviceProviderEmail;
    serviceProviderPhoneEdit.text = serviceList[index].serviceProviderPhone;
    notifyListeners();
  }

  Future<void> updateDAta(String name) async {
    await databaseService.serviceDB
        .where("Service provider name", isEqualTo: name)
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          element.reference.update({
            'Service provider name': serviceProviderNameEdit.text,
            'Service provider email': serviceProviderEmailEdit.text,
            'Service provider phone': serviceProviderPhoneEdit.text,
          });
        });
      },
    );
    serviceList.clear();
    getServiceData();
    notifyListeners();
  }

  void clearControllers() {
    serviceProviderName.clear();
    serviceProviderEmail.clear();
    serviceProviderPhone.clear();
    serviceLevel.clear();
  }
}
