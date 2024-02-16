// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/BookService/book_service_viewmodel.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';

class BookServiceMainListView extends StatefulWidget {
  int index;
  DocumentSnapshot? site;
  BookServiceMainListView({required this.index, required this.site});

  @override
  State<BookServiceMainListView> createState() =>
      _BookServiceMainListViewState();
}

class _BookServiceMainListViewState extends State<BookServiceMainListView> {
  bool selected = false;
  bool check = false;
  int? selectIndex = -1;
  String? contactName = '';
  String? id;
  List<dynamic> ContactId = [];
  @override
  Widget build(BuildContext context) {
    // final countProvider = Provider.of<SideBarCount>(context, listen: false);
    // final siteProvider = Provider.of<SiteViewmodel>(context);

    // final notificationModel = Provider.of<NotificationViewModel>(context);

    // List<dynamic> nameofContact = widget.site!["nameOfContact"];

    // log(nameofContact.toString());
    final bookServiceModel =
        Provider.of<BookServiceViewModel>(context, listen: false);
    bookServiceModel.clearSelectedData();

    return Consumer<BookServiceViewModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(20.h),
          GestureDetector(
            onTap: () {
              model.selectData(widget.index.toString());
            },
            child: CustomContainer(
              height: 80.h,
              choseshadow: true,
              color: whiteColor,
              boarderRadius: 16.sp,
              width: double.infinity,
              widget: Row(
                children: [
                  addHorizontalSpace(10.w),
                  Text(
                    widget.site!["Current site"],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sofia",
                    ),
                  ),
                  Spacer(),
                  // GestureDetector(
                  //   onTap: () {
                  //     // notificationModel.getSiteName();
                  //     // showDialog(
                  //     //   barrierColor: Colors.black.withOpacity(0.2),
                  //     //   context: context,
                  //     //   builder: (context) => NotificationAlerBox(
                  //     //     siteName: widget.site!["Site Name"],
                  //     //   ),
                  //     // );
                  //   },
                  //   child: Image.asset(
                  //     "assets/icons/notifications.png",
                  //     height: 45.h,
                  //     color: secondaryColor,
                  //     width: 45.h,
                  //   ),
                  // ),
                  addHorizontalSpace(20.w),
                  !model.selectedMap.containsKey(widget.index.toString())
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: blackColor,
                          size: 30,
                        )
                      : Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                            size: 30,
                          ),
                        ),
                  addHorizontalSpace(20.w),
                ],
              ),
            ),
          ),
          Visibility(
            visible: model.selectedMap.containsKey(widget.index.toString()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(20.h),
                Row(
                  children: [
                    CustomContainer(
                      height: 350.h,
                      width: 330.w,
                      choseshadow: true,
                      color: Color.fromRGBO(248, 248, 248, 1),
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addHorizontalSpace(4.w),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Text(
                              "Reported by",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 35.sp,
                                letterSpacing: 0.5,
                                fontFamily: "Sofia",
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          addVerticalSpace(40.h),
                          Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 10.w),
                            child: Column(
                              children: [
                                CustomNameContainer(
                                  name: widget.site!["Contact name"],
                                ),
                                addVerticalSpace(20.h),
                                CustomNameContainer(
                                  name: widget.site!["Contact email"],
                                ),
                                addVerticalSpace(20.h),
                                CustomNameContainer(
                                  name: widget.site!["Contact phone"],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    addHorizontalSpace(20.w),
                    CustomContainer(
                        height: 350.h,
                        width: 950.w,
                        choseshadow: true,
                        color: Color(0xffF8F8F8),
                        widget: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service Booked",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  letterSpacing: 0.5,
                                  fontFamily: "Sofia",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              SizedBox(
                                height: 50.h,
                                width: 350,
                                child: Row(
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.spaceBetween,

                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170.w,
                                      child: Text(
                                        "SERVICES",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          letterSpacing: 0.5,
                                          fontFamily: "Sofia",
                                          color:
                                              secondaryColor.withOpacity(0.6),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "SERVICE LEVEL",
                                    //   textAlign: TextAlign.start,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //     fontSize: 25.sp,
                                    //     letterSpacing: 0.5,
                                    //     fontFamily: "Sofia",
                                    //     color: secondaryColor.withOpacity(0.6),
                                    //     fontWeight: FontWeight.w600,
                                    //   ),
                                    // ),

                                    SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        "DATE",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          letterSpacing: 0.5,
                                          fontFamily: "Sofia",
                                          color:
                                              secondaryColor.withOpacity(0.6),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(20.h),
                              SizedBox(
                                height: 60.h,
                                width: 500,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60.h,
                                      width: 170.w,
                                      child: Text(
                                        widget.site!["Site name"],
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          letterSpacing: 0.5,
                                          fontFamily: "Sofia",
                                          color:
                                              secondaryColor.withOpacity(0.6),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 60.h,
                                    //   width: 220.w,
                                    //   child: Text(
                                    //     "SERVICE LEVEL",
                                    //     textAlign: TextAlign.start,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: TextStyle(
                                    //       fontSize: 25.sp,
                                    //       letterSpacing: 0.5,
                                    //       fontFamily: "Sofia",
                                    //       color: secondaryColor.withOpacity(0.6),
                                    //       fontWeight: FontWeight.w600,
                                    //     ),
                                    //   ),
                                    // ),

                                    SizedBox(
                                      height: 60.h,
                                      width: 150.w,
                                      child: Text(
                                        widget.site!["service date"],
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          letterSpacing: 0.5,
                                          fontFamily: "Sofia",
                                          color:
                                              secondaryColor.withOpacity(0.6),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Container(
                                height: 70.h,
                                width: 500.w,
                                child: Text(
                                  widget.site!["Comment"],
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    letterSpacing: 0.5,
                                    fontFamily: "Sofia",
                                    color: secondaryColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                addVerticalSpace(20.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNameContainer extends StatelessWidget {
  String? name;
  CustomNameContainer({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 250.w,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: secondaryColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addHorizontalSpace(10.w),
            Text(
              name!,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 25.sp,
                letterSpacing: 0.5,
                fontFamily: "Sofia",
                color: secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
