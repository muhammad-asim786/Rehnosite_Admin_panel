import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notification_alert_box.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../notification_viewmodel.dart';

class NotificationsHeader extends StatefulWidget {
  const NotificationsHeader({super.key});

  @override
  State<NotificationsHeader> createState() => _NotificationsHeaderState();
}

class _NotificationsHeaderState extends State<NotificationsHeader> {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationViewModel>(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              "NOTIFICATIONS",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 50.sp,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // SizedBox(
            //   height: 70.h,
            //   width: 520.w,
            //   child: TextField(
            //     cursorColor: secondaryColor,
            //     decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: secondaryColor,
            //         ),
            //         borderRadius: BorderRadius.circular(30.sp),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: secondaryColor,
            //         ),
            //         borderRadius: BorderRadius.circular(30.sp),
            //       ),
            //       contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
            //       floatingLabelBehavior: FloatingLabelBehavior.always,
            //       suffixIcon: Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Image.asset(
            //           "assets/images/search.png",
            //           height: 44.h,
            //           width: 44.w,
            //         ),
            //       ),
            //       hintStyle: TextStyle(
            //         color: blackColor.withOpacity(0.5),
            //         fontSize: 25.sp,
            //         letterSpacing: 0.5,
            //         fontWeight: FontWeight.w700,
            //       ),
            //       hintText: "Search",
            //       border: InputBorder.none,
            //     ),
            //   ),
            // ),

            addHorizontalSpace(20.w),
            GestureDetector(
              onTap: () {
                showDialog(
                  barrierColor: Colors.black.withOpacity(0.2),
                  context: context,
                  builder: (context) => NotificationAlerBox(
                    isSite: false,
                    siteName: '',
                  ),
                );
              },
              child:Image.asset(
               "assets/images/add.png",
                  
                  height: 35,
                  width: 35,
              ),
            ),
          ],
        ),
        addVerticalSpace(15.h),
        Row(
          children: [],
        ),
        addVerticalSpace(25.h),
        Row(
          children: [
            Text(
              "All notifications",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 35.sp,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
                fontFamily: "Sofia",
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  barrierColor: Colors.black.withOpacity(0.2),
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Clear All"),
                    content: Text(
                        "Are you sure you want to clear all notifications?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          notificationProvider.clearAllAdminNotification();
                          Navigator.pop(context);
                        },
                        child: Text("Clear"),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Clear All",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30.sp,
                  letterSpacing: 0.5,
                  color: Color(0xffC62125),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Sofia",
                ),
              ),
            ),
            addHorizontalSpace(20.w)
          ],
        ),
        Divider(
          color: blackColor.withOpacity(0.2),
          thickness: 1,
          height:0,
        ),
      ],
    );
  }
}
