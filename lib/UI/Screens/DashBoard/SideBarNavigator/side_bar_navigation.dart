// ignore_for_file: must_be_immutable

import 'dart:math' as math;

import 'package:badges/badges.dart' as badge;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calendar_view_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notification_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/LoginScreen/login_screen.dart';
// import 'package:rhinoapp/UI/Screens/SideBarNavigator/ChatScreen/Calender/calender.dart';

import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainMenu/SiteScreen/site_viewmodel.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  /////////// list of screens ///////////

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<SideBarCount>(context, listen: false);
    final orderProvider = Provider.of<OrdersProvider>(context, listen: false);
    final siteProvider = Provider.of<SiteViewmodel>(context);

    final notificationModel = Provider.of<NotificationViewModel>(
      context,
      listen: true,
    );
    final calendarProvider = Provider.of<CalendarViewModel>(context);
    return Drawer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 20.w),
            child: CustomContainer(
              choseshadow: true,
              width: 292.w,
              height: MediaQuery.of(context).size.height - 20,
              color: secondaryColor,
              boarderRadius: 32.sp,
              widget: Column(
                children: [
                  addVerticalSpace(50.h),
                  Container(
                    child: Image.asset(
                      "assets/images/gofa.png",
                      width: 200.w,
                      height: 100.h,
                    ),
                  ),
                  addVerticalSpace(40.h),
                  // DrawerHeader(
                  //   child: Image.asset(
                  //     "assets/images/gofa.png",
                  //     width: 150.w,
                  //     height: 50.h,
                  //   ),
                  // ),
                  // addVerticalSpace(10.h),
                  DrawerListTile(
                    imgUrl: "assets/icons/sites.png",
                    title: "SITES",
                    color: countProvider.index == 1
                        ? redColor
                        : Colors.transparent,
                    press: (() {
                      setState(() {
                        countProvider.setIndex(1);
                        print("dfdsfasdfasdasdfa");
                      });
                    }),
                  ),
                  addVerticalSpace(40.h),
                  DrawerListTile(
                    color: countProvider.index == 2
                        ? redColor
                        : Colors.transparent,
                    imgUrl: "assets/icons/contacts.png",
                    title: "CONTACTS",
                    press: (() {
                      setState(() {
                        countProvider.setIndex(2);
                      });
                    }),
                  ),
                  addVerticalSpace(40.h),
                  DrawerListTile(
                    color: countProvider.index == 3
                        ? redColor
                        : Colors.transparent,
                    imgUrl: "assets/icons/services.png",
                    title: "SERVICES",
                    press: (() {
                      setState(() {
                        countProvider.setIndex(3);
                      });
                    }),
                  ),
                  addVerticalSpace(40.h),
                  DrawerListTile(
                    color: countProvider.index == 4
                        ? redColor
                        : Colors.transparent,
                    imgUrl: "assets/icons/products.png",
                    title: "PRODUCT",
                    press: (() {
                      setState(() {
                        countProvider.setIndex(4);
                        orderProvider.setOrderScreen(2);
                      });
                    }),
                  ),
                  addVerticalSpace(40.h),
                  DrawerListTile(
                    color: countProvider.index == 5
                        ? redColor
                        : Colors.transparent,
                    imgUrl: "assets/icons/chats.png",
                    title: "CHATS",
                    press: (() {
                      siteProvider.getMetaData();
                      countProvider.setIndex(5);

                      // called metadata function
                    }),
                  ),
                  addVerticalSpace(40.h),
                  GestureDetector(
                    onTap: () {
                      notificationModel.getSiteName();
                      notificationModel.resetNotificationCount();
                      countProvider.setIndex(6);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHorizontalSpace(10.w),
                        Container(
                          height: 36.h,
                          width: 5.w,
                          color: countProvider.index == 6
                              ? redColor
                              : Colors.transparent,
                        ),
                        addHorizontalSpace(10.w),
                        // notificationModel.notificationCount == 0
                        //     ? Icon(
                        //         Icons.notifications,
                        //         color: whiteColor,
                        //       )
                        //     : notificationModel.notificationCount > 9
                        //         ? badge.Badge(
                        //             badgeContent: Text(
                        //               "+9",
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //             child: Icon(
                        //               Icons.notifications,
                        //               color: whiteColor,
                        //             ),
                        //           )
                        //         : badge.Badge(
                        //             badgeContent: Text(
                        //               "${notificationModel.notificationCount}",
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //             child: Icon(
                        //               Icons.notifications,
                        //               color: whiteColor,
                        //             ),
                        //           ),

                        StreamBuilder(
                          stream: notificationModel
                              .databaseService.adminNotificationCountDB
                              .doc("notifications_count")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox();
                            } else {
                              return snapshot.data!["notifications"] == 0
                                  ? Icon(
                                      Icons.notifications,
                                      color: whiteColor,
                                    )
                                  : snapshot.data!["notifications"] > 9
                                      ? badge.Badge(
                                          badgeContent: Text(
                                            "+9",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.notifications,
                                            color: whiteColor,
                                          ),
                                        )
                                      : badge.Badge(
                                          badgeContent: Text(
                                            "${snapshot.data!["notifications"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.notifications,
                                            color: whiteColor,
                                          ),
                                        );
                            }
                          },
                        ),

                        addHorizontalSpace(40.sp),
                        Text(
                          "NOTIFICATIONS",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(40.h),
                  DrawerListTile(
                    color: countProvider.index == 7
                        ? redColor
                        : Colors.transparent,
                    imgUrl: "assets/icons/calender.png",
                    title: "CALENDAR",
                    press: (() {
                      setState(() {
                        calendarProvider.getAllServices();
                        countProvider.setIndex(7);
                      });
                    }),
                  ),
                  addVerticalSpace(40.h),
                  DrawerListTile(
                    color: countProvider.index == 8
                        ? redColor
                        : Colors.transparent,
                    imgUrl: "assets/icons/profile.png",
                    title: "PROFILE",
                    press: (() {
                      setState(() {
                        countProvider.setIndex(8);
                      });
                    }),
                  ),
                  addVerticalSpace(40.h),
                  GestureDetector(
                    onTap: () {
                      notificationModel.getSiteName();
                      notificationModel.resetNotificationCount();
                      countProvider.setIndex(9);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHorizontalSpace(10.w),
                        Container(
                          height: 36.h,
                          width: 5.w,
                          color: countProvider.index == 9
                              ? redColor
                              : Colors.transparent,
                        ),
                        addHorizontalSpace(10.w),
                        StreamBuilder(
                            stream: notificationModel
                                .databaseService.adminNotificationCountDB
                                .doc("notifications_count")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox();
                              } else {
                                return snapshot.data!["notifications"] == 0
                                    ? Image.asset(
                                        color: Colors.white,
                                        'assets/icons/report.png',
                                        height: 32.h,
                                        width: 32.w,
                                      )
                                    : snapshot.data!["notifications"] > 9
                                        ? badge.Badge(
                                            badgeContent: Text(
                                              "+9",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Image.asset(
                                              color: Colors.white,
                                              'assets/icons/report.png',
                                              height: 32.h,
                                              width: 32.w,
                                            ))
                                        : badge.Badge(
                                            badgeContent: Text(
                                              "${snapshot.data!["notifications"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Image.asset(
                                              color: Colors.white,
                                              'assets/icons/report.png',
                                              height: 32.h,
                                              width: 32.w,
                                            ));
                              }
                            }),
                        addHorizontalSpace(40.sp),
                        Text(
                          "REPORTED FAULTS",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),

                  addVerticalSpace(40.h),
                  GestureDetector(
                    onTap: () {
                      notificationModel.getSiteName();
                      notificationModel.resetNotificationCount();
                      countProvider.setIndex(10);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHorizontalSpace(10.w),
                        Container(
                          height: 36.h,
                          width: 5.w,
                          color: countProvider.index == 10
                              ? redColor
                              : Colors.transparent,
                        ),
                        addHorizontalSpace(10.w),
                        StreamBuilder(
                            stream: notificationModel
                                .databaseService.adminNotificationCountDB
                                .doc("notifications_count")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox();
                              } else {
                                return snapshot.data!["notifications"] == 0
                                    ? Image.asset(
                                        color: Colors.white,
                                        'assets/icons/site_request.png',
                                        height: 32.h,
                                        width: 32.w,
                                      )
                                    : snapshot.data!["notifications"] > 9
                                        ? badge.Badge(
                                            badgeContent: Text(
                                              "+9",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Image.asset(
                                              color: Colors.white,
                                              'assets/icons/site_request.png',
                                              height: 32.h,
                                              width: 32.w,
                                            ))
                                        : badge.Badge(
                                            badgeContent: Text(
                                              "${snapshot.data!["notifications"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Image.asset(
                                              color: Colors.white,
                                              'assets/icons/site_request.png',
                                              height: 32.h,
                                              width: 32.w,
                                            ));
                              }
                            }),
                        addHorizontalSpace(40.sp),
                        Text(
                          "SITE REQUESTS",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),

                  addVerticalSpace(40.h),
                  GestureDetector(
                    onTap: () {
                      notificationModel.getSiteName();
                      notificationModel.resetNotificationCount();
                      countProvider.setIndex(11);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHorizontalSpace(10.w),
                        Container(
                          height: 36.h,
                          width: 5.w,
                          color: countProvider.index == 11
                              ? redColor
                              : Colors.transparent,
                        ),
                        addHorizontalSpace(10.w),
                        StreamBuilder(
                            stream: notificationModel
                                .databaseService.adminNotificationCountDB
                                .doc("notifications_count")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox();
                              } else {
                                return snapshot.data!["notifications"] == 0
                                    ? Image.asset(
                                        color: Colors.white,
                                        'assets/icons/book_service.png',
                                        height: 32.h,
                                        width: 32.w,
                                      )
                                    : snapshot.data!["notifications"] > 9
                                        ? badge.Badge(
                                            badgeContent: Text(
                                              "+9",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Image.asset(
                                              color: Colors.white,
                                              'assets/icons/book_service.png',
                                              height: 32.h,
                                              width: 32.w,
                                            ))
                                        : badge.Badge(
                                            badgeContent: Text(
                                              "${snapshot.data!["notifications"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Image.asset(
                                              color: Colors.white,
                                              'assets/icons/book_service.png',
                                              height: 32.h,
                                              width: 32.w,
                                            ));
                              }
                            }),
                        addHorizontalSpace(40.sp),
                        Text(
                          "BOOK SERVICE",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),

                  addVerticalSpace(40.h),

                  DrawerListTile(
                    color: countProvider.index == 12
                        ? redColor
                        : Colors.transparent,
                    // color: Colors.transparent,
                    imgUrl: "assets/icons/phone.png",
                    title: "NUMBERS",
                    press: (() {
                      setState(() {
                        countProvider.setIndex(12);
                      });
                    }),
                  ),
                  addVerticalSpace(30.h),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: IconButton(
                            icon: Icon(
                              Icons.logout_sharp,
                              color: redColor,
                              size: 50.h,
                            ),
                            onPressed: null,
                          ),
                        ),

                        addHorizontalSpace(35.w),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            countProvider.setIndex(1);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "LOGOUT",
                            style: TextStyle(
                              color: redColor,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // addHorizontalSpace(20.w)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//customRow

class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.press,
    required this.color,
    // required redstrip,
  });
  String imgUrl;
  String title;
  VoidCallback? press;
  Color color;

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<SideBarCount>(context, listen: false);
    print(countProvider.index);
    return GestureDetector(
      onTap: press,
      child: Row(
        children: [
          addHorizontalSpace(15.w),
          Container(
            height: 36.h,
            width: 5.w,
            color: color,
          ),
          addHorizontalSpace(8.sp),
          imgUrl.isEmpty
              ? SizedBox(
                  height: 32.h,
                  width: 21.w,
                )
              : Image.asset(
                  color: Colors.white,
                  imgUrl,
                  height: 32.h,
                  width: 32.w,
                ),
          addHorizontalSpace(30.sp),
          FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//ars