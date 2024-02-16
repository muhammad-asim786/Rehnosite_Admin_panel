// ignore_for_file: must_be_immutable, unused_element

import 'dart:developer';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

import '../../../../../Utils/helper_widgets.dart';
import 'calendar_view_model.dart';

class GridCalendarScreen extends StatefulWidget {
  const GridCalendarScreen({super.key});

  @override
  State<GridCalendarScreen> createState() => _GridCalendarScreenState();
}

class _GridCalendarScreenState extends State<GridCalendarScreen> {
  bool cleaning = false;
  bool waterSupply = false;
  bool skipChangeover = false;
  bool chemicalToiletService = false;

  // final _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    DateTime _focusedDay = DateTime.now();
    log(_focusedDay.weekday.toString());

    return Consumer<CalendarViewModel>(
      builder: (context, provider, child) => Container(
        width: 500.w,
        child: MonthView(
          minMonth: provider.startDay == 0
              ? CalendarConstants.epochDate
              : DateTime.now().subtract(Duration(days: provider.startDay)),
          maxMonth: provider.startDay == 0
              ? CalendarConstants.maxDate
              : DateTime.now().add(Duration(days: provider.endDay)),
          // minMonth: CalendarConstants.epochDate,
          // maxMonth: CalendarConstants.maxDate,
          onDateLongPress: (date) {},
          onEventTap: (env, date) {
            print(date.year);
          },
          onCellTap: (env, date) {},
          controller: EventController()..addAll(provider.eventFilterList),
          cellBuilder: (date, event, isToday, isInMonth) {
            return Container(
              color: Colors.white,
              width: 200,
              constraints: BoxConstraints(minHeight: 200),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    date.day.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                  provider.eventFilterList.length != 0
                      ? Expanded(
                          child: ListView(
                            children: [
                              for (var i = 0;
                                  i < provider.eventFilterList.length;
                                  i++)
                                if (date.isAfter(
                                        provider.eventFilterList[i].date) ||
                                    date == provider.eventFilterList[i].date)
                                  if (provider.eventFilterList[i].date
                                              .weekday ==
                                          date.weekday &&
                                      provider.eventFilterList[i].date.month <=
                                          date.month)
                                    GestureDetector(
                                      onTap: () {
                                        provider.contactNameFromSite(
                                            provider.eventFilterList[i].title);
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ServiceDialogWidget(
                                              provider: provider,
                                              i: i,
                                              contactNameList: provider
                                                  .contactNameFromSiteList,
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 200,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        color: provider
                                                    .eventFilterList[i].color ==
                                                Colors.white
                                            ? Colors.amber
                                            : provider.eventFilterList[i].color,
                                        child: Column(
                                          children: [
                                            Text(
                                              provider.eventFilterList[i].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: provider
                                                            .eventFilterList[i]
                                                            .color ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.sp,
                                              ),
                                            ),
                                            Text(
                                              '(${provider.eventFilterList[i].description})',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: provider
                                                            .eventFilterList[i]
                                                            .color ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView(
                            children: [
                              for (var i = 0;
                                  i < provider.eventList.length;
                                  i++)
                                if (date.isAfter(provider.eventList[i].date) ||
                                    date == provider.eventList[i].date)
                                  if ((provider.eventList[i].date.weekday ==
                                          date.weekday &&
                                      provider.eventList[i].date.month <=
                                          date.month))
                                    GestureDetector(
                                      onTap: () {
                                        provider.contactNameFromSite(
                                            provider.eventList[i].title);
                                        Future.delayed(
                                            Duration(milliseconds: 1), () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ServiceDialogWidget(
                                              provider: provider,
                                              i: i,
                                              contactNameList: provider
                                                  .contactNameFromSiteList,
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 200,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        color: provider.eventList[i].color ==
                                                Colors.white
                                            ? Colors.amber
                                            : provider.eventList[i].color,
                                        child: Column(
                                          children: [
                                            Text(
                                              provider.eventList[i].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: provider.eventList[i]
                                                            .color ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.sp,
                                              ),
                                            ),
                                            Text(
                                              '(${provider.eventList[i].description})',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: provider.eventList[i]
                                                            .color ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                              // Container(
                              //   height: 33,
                              //   width: 200,
                              //   padding: EdgeInsets.symmetric(horizontal: 10),
                              //   color: Colors.amber,
                              //   child: Text(_events.isNotEmpty
                              //       ? _events[1].title
                              //       : 'fasfasfasfasfasfasfasffsafsfs'),
                              // ),

                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
          cellAspectRatio: 1.2,
        ),
      ),
    );

    //       // agendaItemHeight: 100,
    //       appointmentDisplayCount: 3,
    //       agendaStyle: AgendaStyle(
    //         appointmentTextStyle: TextStyle(
    //           color: Colors.white,
    //           fontSize: 30.sp,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       // numberOfWeeksInView: 5,
    //       appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    // );
  }
}

class ServiceDialogWidget extends StatefulWidget {
  ServiceDialogWidget({
    super.key,
    required this.provider,
    required this.i,
    required this.contactNameList,
  });

  final CalendarViewModel provider;
  final int i;
  List<String> contactNameList = [];

  @override
  State<ServiceDialogWidget> createState() => _ServiceDialogWidgetState();
}

class _ServiceDialogWidgetState extends State<ServiceDialogWidget> {
  @override
  Widget build(BuildContext context) {
    log('-------------');
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
                        color: widget.provider.eventList[widget.i].color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHorizontalSpace(10),
                          Text(
                            "${widget.provider.eventList[widget.i].title} (${widget.provider.eventList[widget.i].description})",
                            style: TextStyle(
                              color:
                                  widget.provider.eventList[widget.i].color ==
                                          Colors.white
                                      ? Colors.black
                                      : Colors.white,
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

DateTime get _now => DateTime.now();
List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: DateTime(2023, 5, 23),
    event: Event("Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(
      _now.year,
      _now.month,
      _now.day,
    ),
    endTime: DateTime(
      _now.year,
      _now.month,
      _now.day + 2,
    ),
    endDate: DateTime(
      _now.year,
      _now.month,
      _now.day + 2,
    ),
  ),
  CalendarEventData(
    date: DateTime(2023, 5, 23),
    event: Event("Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(
      _now.year,
      _now.month,
      _now.day,
    ),
    endTime: DateTime(
      _now.year,
      _now.month,
      _now.day + 2,
    ),
    endDate: DateTime(
      _now.year,
      _now.month,
      _now.day + 2,
    ),
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 10)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: Event("Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
    endDate: DateTime(_now.year, _now.month, _now.day + 2),
  ),
];
