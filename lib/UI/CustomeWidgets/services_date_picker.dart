// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final Color color;

  const Event(this.title, this.color);
}

Map<DateTime, List<Event>> events = {
  DateTime(2023, 2, 14): [
    Event('Valentine\'s Day', Colors.red),
  ],
  DateTime(2023, 2, 22): [
    Event('Meeting', Colors.blue),
  ],
  DateTime(2023, 2, 24): [
    Event('Birthday', Colors.pink),
    Event('Anniversary', Colors.purple),
  ],
};
List<Event> _selectedEvents = [];

class ServicesScreenDatePicker extends StatefulWidget {
  ServicesScreenDatePicker({super.key, required this.selectedDAY});
  DateTime? selectedDAY;

  @override
  State<ServicesScreenDatePicker> createState() =>
      _ServicesScreenDatePickerState();
}

class _ServicesScreenDatePickerState extends State<ServicesScreenDatePicker> {
  // DateTime selectedDAY    final countProvider = Provider.of<SideBarCount>(context, listen: false);
  // DateTime _focusedDay = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final calendareProvider = Provider.of<CalendarProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      title: Container(
        width: 536.h,
        height: 438.w,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 58,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          daysOfWeekHeight: 30.h,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Sofia",
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Sofia",
              fontWeight: FontWeight.bold,
            ),
          ),
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Sofia",
              fontWeight: FontWeight.bold,
            ),
          ),
          focusedDay: _focusedDay,
          availableCalendarFormats: {
            CalendarFormat.month: '',
            CalendarFormat.twoWeeks: '',
            CalendarFormat.week: ''
          },
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(widget.selectedDAY, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(widget.selectedDAY, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                widget.selectedDAY = selectedDay;
                calendareProvider.calenderValuePicked(widget.selectedDAY!);
                Navigator.pop(context);
                _focusedDay = focusedDay;
              });
            }
          },
          // onFormatChanged: (format) {
          //   if (_calendarFormat != format) {
          //     // Call `setState()` when updating calendar format
          //     setState(() {
          //       _calendarFormat = format;
          //     });
          //   }
          // },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}

// selectedDayPredicate: (day) {
//   return isSameDay(selectedDAY, day);
// },
// onDaySelected: (selectedDay, focusedDay) {
//   setState(() {
//     selectedDAY = selectedDay;
//     _focusedDay = focusedDay; // update `_focusedDay` here as well
//   });
// },