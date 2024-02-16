import 'package:flutter/material.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

final List<BoxShadow>? shadow = [
  BoxShadow(
    color: blackColor.withOpacity(0.24),
    spreadRadius: 0,
    blurRadius: 1,
    offset: Offset(0, 0), // changes position of shadow
  ),
];
Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}
// Text(
//                 "SITES",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                   fontSize: 44.sp,
//                   fontFamily: "Sofia",
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),