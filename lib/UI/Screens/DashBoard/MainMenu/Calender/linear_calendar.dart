// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calendar_view_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calender.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../Utils/helper_widgets.dart';

class LinearCalendarScreen extends StatefulWidget {
  const LinearCalendarScreen({super.key});

  @override
  State<LinearCalendarScreen> createState() => _LinearCalendarScreenState();
}

class _LinearCalendarScreenState extends State<LinearCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(
      builder: (context, model, child) => SfCalendar(
        view: CalendarView.schedule,

        appointmentBuilder: (context, calendarAppointmentDetails) {
          final data = calendarAppointmentDetails.appointments.first;

          List serviceList = data.location.toString().split('/').toList();
          print(serviceList);

          return GestureDetector(
            onTap: () {
              log(serviceList.toString());
              model.contactNameFromSite(serviceList[0].toString());
              Future.delayed(Duration(seconds: 3), () {
                print("-------->>${serviceList[0]}");
                print(model.contactNameFromSiteList);
                showDialog(
                    context: context,
                    builder: (context) => SerivceNameWidget(
                        provider: model,
                        color: data.color,
                        name: serviceList[0],
                        contactNameList: model.contactNameFromSiteList));
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color:
                        data.color == Colors.white ? Colors.grey : data.color,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    data.subject.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          );
        },

        showCurrentTimeIndicator: false,

        appointmentTimeTextFormat: 'hh:mm a',

        scheduleViewSettings: ScheduleViewSettings(
          appointmentItemHeight: 70,

          // hideEmptyScheduleWeek: true

          // hideEmptyScheduleWeek: true,
        ),

        dataSource: MeetingDataSource(
          model.dommyDateList,
        ),
        // scheduleViewSettings: ScheduleViewSettings(
        //   appointmentItemHeight: 70,
        //   appointmentTextStyle: TextStyle(
        //     color: Colors.red,
        //     fontSize: 16,
        //   ),
        // ),

        //viewNavigationMode: ViewNavigationMode.snap,
      ),
    );
  }
}

class SerivceNameWidget extends StatefulWidget {
  SerivceNameWidget({
    super.key,
    required this.provider,
    required this.color,
    this.name,
    required this.contactNameList,
  });

  final CalendarViewModel provider;

  Color color;
  String? name;

  List<String> contactNameList = [];

  @override
  State<SerivceNameWidget> createState() => _SerivceNameWidgetState();
}

class _SerivceNameWidgetState extends State<SerivceNameWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.contactNameList.length);
    return Dialog(
      child: Container(
        height: 829.h,
        width: 621.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80.h,
              width: double.infinity,
              color: secondaryColor,
              child: Center(
                  child: Text(
                'SERVICES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25.sp,
                ),
              )),
            ),
            addVerticalSpace(27.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHorizontalSpace(10),
                          Text(
                            widget.name.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(20.h),
                  Text(
                    'Sites Contacts',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpace(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Container(
                height: 250,
                // color: Color(0xffF8F8F8),
                width: double.infinity,
                child: ListView.builder(
                  itemCount: widget.provider.contactNameFromSiteList.length,
                  itemBuilder: (context, index) {
                    String name =
                        widget.provider.contactNameFromSiteList[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Color(0xffA1A1A1).withOpacity(0.5),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  // widget.provider.changeIsBusy();

                  Navigator.pop(context);
                },
                child: Container(
                  height: 70.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
