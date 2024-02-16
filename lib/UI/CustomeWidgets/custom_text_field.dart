// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool obsecureText;
  final Widget? widget;
  final int? maxLine;
  final String? lableText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? initialValue;
  final Function(String)? validator;
  // TextEditingController? controller = TextEditingController();
  final Function(String)? onChanged;

  CustomTextField(
      {Key? key,
      this.hintText = "",
      // this.controller,
      // required this.onChanged,
      this.obsecureText = false,
      this.textInputType = TextInputType.text,
      this.widget,
      this.maxLine = 1,
      this.lableText,
      this.initialValue,
      this.onChanged,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.h,
      width: 450.w,
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30.sp),
        child: TextFormField(
          validator: (value) => validator!(value!),
          onChanged: onChanged,
          initialValue: initialValue ?? "",
          maxLines: maxLine,
          keyboardType: textInputType,
          cursorColor: secondaryColor,
          // controller: controller,
          obscureText: obsecureText,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: lableText ?? "",
            labelStyle: TextStyle(
              color: whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
            ),
            suffixIcon: widget,
            hintStyle: TextStyle(
              color: secondaryColor.withOpacity(0.5),
              fontSize: 25.sp,
              fontWeight: FontWeight.w200,
            ),
            hintText: hintText,
            border: InputBorder.none,
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15.r),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15.r),
            // ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final String? hintText;
  final bool obsecureText;
  double width;
  double height;
  final Widget? widget;
  final int? maxLine;
  final String? lableText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  bool? isOnlyNumber = false;
  // final String? initialValue;
  final Function(String)? validator;
  // TextEditingController? controller = TextEditingController();
  final Function(String)? onChanged;

  CustomTextField2(
      {Key? key,
      this.hintText = "",
      this.width = 10,
      this.height = 10,
      //this.controller,
      // required this.onChanged,
      this.obsecureText = false,
      this.textInputType = TextInputType.text,
      this.widget,
      this.maxLine = 1,
      this.lableText,
      this.isOnlyNumber = false,
      // this.initialValue,
      this.onChanged,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isor = false;
    return Container(
      height: 80,
      width: width,
      padding: EdgeInsets.only(bottom: 7.h, left: 10.w),
      color: greyColor.withOpacity(0.2),
      child: TextFormField(
        autocorrect: true,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: isOnlyNumber!
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ]
            : null,

        controller: controller,
        textAlign: TextAlign.start,
        validator: (value) => validator!(value!),
        onChanged: onChanged,
        // initialValue: initialValue ?? "",
        maxLines: maxLine,
        keyboardType: textInputType,
        cursorColor: secondaryColor,

        // controller: controller,
        obscureText: obsecureText,

        decoration: InputDecoration(
          isDense: true,
          fillColor: greyColor.withOpacity(0.5),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: lableText ?? "",
          contentPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
            color: secondaryColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
          ),
          suffixIcon: widget,

          hintStyle: TextStyle(
            color: secondaryColor.withOpacity(0.5),
            fontSize: 20.sp,
            fontWeight: FontWeight.w200,
          ),
          hintText: hintText,
          border: InputBorder.none,
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15.r),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15.r),
          // ),
        ),
      ),
    );
  }
}
