// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';

///////////////////////
///widget///////////////
///////////////////////
class ProfileRowWidget extends StatefulWidget {
  bool selected = false;
  String title;
  String hint;
  TextEditingController? controller;
  bool? obsecureText;
  bool? readOnly;
  ProfileRowWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.selected,
    this.controller,
    this.readOnly,
    this.obsecureText = false,
  });

  @override
  State<ProfileRowWidget> createState() => _ProfileRowWidgetState();
}

class _ProfileRowWidgetState extends State<ProfileRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        addHorizontalSpace(30.w),
        Container(
          width: 200.w,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 30.sp,
              letterSpacing: 0.5,
              color: greyColor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        addHorizontalSpace(20.w),
        SizedBox(
          width: 400.w,
          height: 60.h,
          child: TextFormField(
            // enabled: widget.selected,
            // maxLines: 5,
            controller: widget.controller,
            obscureText: widget.obsecureText ?? false,
            cursorColor: secondaryColor,
            readOnly: widget.readOnly ?? false,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor.withOpacity(0.4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor.withOpacity(0.4)),
              ),

              contentPadding: EdgeInsets.only(left: 10.w, top: 5.h),
              suffixIcon: Icon(
                Icons.edit,
                color: secondaryColor,
                size: 40.sp,
              ),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(
                color: secondaryColor.withOpacity(0.5),
                fontSize: 25.sp,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
              ),
              hintText: widget.hint,
              border: InputBorder.none,
            ),
          ),
        ),
        Spacer(),
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       widget.selected = !widget.selected;
        //       print(widget.selected);
        //     });
        //   },
        //   child: Icon(
        //     Icons.edit,
        //     color: secondaryColor,
        //     size: 25.sp,
        //   ),
        // ),

        addHorizontalSpace(20.w),
      ],
    );
  }
}
