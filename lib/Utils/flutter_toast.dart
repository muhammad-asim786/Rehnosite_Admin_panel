import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart/colors.dart';

class FlutterTost {
  static customToast(String value) {
    Fluttertoast.showToast(
        msg: value.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: secondaryColor,
        textColor: whiteColor,
        webPosition: "center",
        fontSize: 16.0);
  }
}
