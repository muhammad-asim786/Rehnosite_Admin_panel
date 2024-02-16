import 'package:flutter/material.dart';

class BaseViewModal extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}

enum ViewState {
  loading,
  idle,
  busy,
}
