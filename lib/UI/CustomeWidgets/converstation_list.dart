// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/helper_widgets.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

class ConversationList extends StatelessWidget {
  String? chatId;
  String name;
  String messageText;

  String time;
  bool? isRead;
  String? currentSite;
  int? selectInex;
  int? index;
  // bool isMessageRead;
  ConversationList({
    required this.name,
    required this.messageText,
    required this.time,
    this.isRead,
    this.currentSite,
    this.selectInex,
    this.index,
    // required this.isMessageRead,
    this.chatId,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: secondaryColor.withOpacity(0.4),
                      child: Icon(
                        Icons.person,
                        color: whiteColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: selectInex == index ? 30.sp : 25.sp,
                              letterSpacing: 0.5,
                              fontWeight: selectInex == index
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              fontFamily: "Sofia",
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            messageText,
                            style: TextStyle(
                              fontSize: selectInex == index ? 23.sp : 18.sp,
                              letterSpacing: 0.5,
                              color: selectInex == index
                                  ? Colors.black
                                  : Colors.grey.shade600,
                              fontWeight: selectInex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontFamily: "Sofia",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 18.sp,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Sofia",
                ),
              ),
            ],
          ),
          addVerticalSpace(30.h),
          Container(
            width: 360.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
