import 'package:flutter/material.dart';

class SideBarCount with ChangeNotifier {
  int _index = 1;
  int get index => _index;

  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}

class OrdersProvider with ChangeNotifier {
  String? orderStatus = "PRODUCTS";
  int? _orders;
  int? get order => _orders;

  changeString(String value) {
    orderStatus = value;
    notifyListeners();
  }

  void setOrderScreen(int value) {
    _orders = value;
    notifyListeners();
  }
}

class CalendarProvider with ChangeNotifier {
  DateTime? _dateTime = DateTime.now();
  DateTime? get dateTime => _dateTime;
  // String _dateTime = DateFormat('yyyy-MM-dd').format(dateTime);

  void calenderValuePicked(DateTime value) {
    _dateTime = value;
    notifyListeners();
  }
}
