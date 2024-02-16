// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calendar_header.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calendar_view_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/grid_calendar.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/linear_calendar.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/helper_widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CalendarViewModel>(context);
    return Consumer<CalendarViewModel>(
      builder: (context, provider, child) => ModalProgressHUD(
        inAsyncCall: provider.isBusy,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(60.h),
              CalenderHeader(),
              SizedBox(
                height: 30.h,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: provider.selectedDate == 0
                      ? GridCalendarScreen()
                      : LinearCalendarScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomValue extends StatelessWidget {
  const CustomValue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      height: 180,
      width: 568.w,
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
        // borderRadius:
        // BorderRadius.circular(10.r),
      ),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tylon Maher",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Container(
                  height: 1,
                  width: 568.w,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
