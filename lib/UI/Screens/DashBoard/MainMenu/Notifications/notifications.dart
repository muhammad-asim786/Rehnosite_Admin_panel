// import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/Widgets/header.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notification_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';
import '../../../Providers/side_bar_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NotificationViewModel>(context);
    final sideBarCount = Provider.of<SideBarCount>(context);
    final siteModel = Provider.of<SiteViewmodel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.sp),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpace(60.h),
            NotificationsHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: StreamBuilder(
                stream: model.databaseService.adminNotificatoinDB
                    .orderBy(
                      'time',
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  String? previousDate = "";

                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];

                          DateTime itemDate = data['time'].toDate();

                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(itemDate);
                          String today =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          String yesterday = DateFormat('yyyy-MM-dd').format(
                              DateTime.now().subtract(Duration(days: 1)));

                          String label = '';
                          if (formattedDate == today) {
                            label = 'Today';
                          } else if (formattedDate == yesterday) {
                            label = 'Yesterday';
                          } else {
                            label = formattedDate;
                          }
                          print(label);

                          if (formattedDate == previousDate) {
                            label = "";
                            print("same date" + previousDate.toString());
                          } else if (label == previousDate) {
                            label = "";
                            print("same date" + previousDate.toString());
                          } else {
                            previousDate = label;

                            print("previous date" + previousDate.toString());
                            print("label" + label.toString());
                            print("formattedDate" + formattedDate.toString());
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  color: blackColor.withOpacity(0.5),
                                ),
                              ),
                              addVerticalSpace(20.h),
                              GestureDetector(
                                onTap: () {
                                  model
                                      .clickOnNotificationAndMoveToSpecificRoute(
                                          data, sideBarCount, siteModel);
                                },
                                child: CustomContainer(
                                  height: 90.h,
                                  width: double.infinity,
                                  borderColor: data["read"] == false
                                      ? Color(0xffDAE6FF)
                                      : whiteColor,
                                  boarderRadius: 16.r,
                                  choseshadow: true,

                                  color: data["read"] == false
                                      ? Color(0xffDAE6FF)
                                      : whiteColor,
                                  // color: Color(0xffDAE6FF),
                                  widget: Row(
                                    children: [
                                      addHorizontalSpace(10.w),
                                      Image.asset(
                                        "assets/icons/message2.png",
                                        height: 60.h,
                                        width: 60.w,
                                      ),
                                      addHorizontalSpace(25.w),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${data["type"].toString()} from ${data['contact name']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 30.sp,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xff535353),
                                                  fontFamily: "Sofia",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              addHorizontalSpace(10.w),
                                              Container(
                                                height: 10.h,
                                                width: 10.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  // color: notifications[index]
                                                  //             .status ==
                                                  //         true
                                                  //     ? blackColor
                                                  //         .withOpacity(0.9)
                                                  //     : Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                              )
                                            ],
                                          ),
                                          addVerticalSpace(5.h),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 600.w,
                                                child: Text(
                                                  data['message'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 25.sp,
                                                    letterSpacing: 0.5,
                                                    color: greyColor
                                                        .withOpacity(0.6),
                                                    fontFamily: "Sofia",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          addVerticalSpace(15.h),
                                          Text(
                                            timeago
                                                .format(data['time'].toDate()),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 25.sp,
                                              letterSpacing: 0.5,
                                              color: greyColor.withOpacity(0.6),
                                              fontFamily: "Sofia",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      addHorizontalSpace(30.w),
                                    ],
                                  ),
                                ),
                              ),
                              addVerticalSpace(25.h),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
