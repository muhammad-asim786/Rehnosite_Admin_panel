// ignore_for_file: must_be_immutable, unused_field, non_constant_identifier_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calendar_view_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/helper_widgets.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderHeader extends StatefulWidget {
  const CalenderHeader({super.key});

  @override
  State<CalenderHeader> createState() => _CalenderHeaderState();
}

class _CalenderHeaderState extends State<CalenderHeader> {
  bool serviceType = false;
  bool date_range = false;
  bool serviceProvider = false;
  late SharedPreferences prefs;

  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // Rest of your initialization logic
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final model = Provider.of<CalendarViewModel>(context, listen: false);
    setState(() {
      if (args.value is PickerDateRange) {
        final date = args.value as PickerDateRange;
        model.setDateRange(date.startDate!.day, date.endDate!.day);
      } else {
        final date = args.value as DateTime;
        log(date.toString());

        // print(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalendarViewModel>(context, listen: true);
    // provider.eventFilterList.clear();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(10.h),
        Text(
          "CALENDAR / SERVICE TYPE",
          style: TextStyle(
            fontSize: 50.sp,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        addVerticalSpace(55.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 90.h,
              width: 700.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Color keys",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => CustomColorKey());
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Row(
              //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 30.h,
              //               width: 30.w,
              //               decoration: BoxDecoration(
              //                 color: colorBlue,
              //               ),
              //             ),
              //             addHorizontalSpace(8.w),
              //             Text(
              //               "Cleaning",
              //               style: TextStyle(
              //                 fontSize: 30.sp,
              //                 letterSpacing: 0.5,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         ),
              //         addHorizontalSpace(130),
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 30.h,
              //               width: 30.w,
              //               decoration: BoxDecoration(
              //                 color: redColor,
              //               ),
              //             ),
              //             addHorizontalSpace(8.w),
              //             Text(
              //               "Water Supply",
              //               style: TextStyle(
              //                 fontSize: 30.sp,
              //                 letterSpacing: 0.5,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     addVerticalSpace(17.h),
              //     Row(
              //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 30.h,
              //               width: 30.w,
              //               decoration: BoxDecoration(
              //                 color: Color(0xff9697BE),
              //               ),
              //             ),
              //             addHorizontalSpace(8.w),
              //             Text(
              //               "Skip Changeover",
              //               style: TextStyle(
              //                 fontSize: 30.sp,
              //                 letterSpacing: 0.5,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         ),
              //         addHorizontalSpace(70),
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 30.h,
              //               width: 30.w,
              //               decoration: BoxDecoration(
              //                 color: Color(0xffCFE069),
              //               ),
              //             ),
              //             addHorizontalSpace(8.w),
              //             Text(
              //               "Chemical Toilet Service",
              //               style: TextStyle(
              //                 fontSize: 30.sp,
              //                 letterSpacing: 0.5,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.storeDataInCSV();
                    // log(provider.csvFileList.toString());
                  },
                  child: ImageIcon(
                    AssetImage("assets/images/csv_icon.png"),
                    size: 35,
                  ),
                ),
                addHorizontalSpace(20.w),
                GestureDetector(
                  onTap: () {
                    provider.changeValue(0);
                  },
                  child: ImageIcon(
                    AssetImage("assets/images/grid_view.png"),
                    size: 35,
                    color:
                        provider.selectedDate != 1 ? blackColor : Colors.grey,
                  ),
                ),
                addHorizontalSpace(20.w),
                GestureDetector(
                  onDoubleTap: () {
                    provider.changeValue(1);
                    print("List");
                  },
                  child: ImageIcon(
                    AssetImage("assets/images/list_icon.png"),
                    size: 35,
                    color:
                        provider.selectedDate != 0 ? blackColor : Colors.grey,
                  ),
                ),
                addHorizontalSpace(20.w),
                addHorizontalSpace(20.w),
                PopupMenuButton(
                  onCanceled: () {
                    serviceProvider = false;
                    serviceType = false;
                    date_range = false;
                  },
                  onOpened: () {
                    provider.getServiceProviderNameAndService();
                  },
                  onSelected: (value) {},
                  offset: Offset(0, 20),
                  constraints: BoxConstraints(
                    minWidth: 456.w,
                    minHeight: 479.h,
                  ),
                  child: Container(
                    width: 100.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: whiteColor,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          addHorizontalSpace(10.w),
                          Icon(
                            Icons.filter_alt_outlined,
                            size: 25,
                            color: whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: StatefulBuilder(
                        builder: (context, setState) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Service Type",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Filter");
                                    setState(() {
                                      serviceType = !serviceType;
                                    });
                                  },
                                  child: Icon(
                                    !serviceType
                                        ? Icons.arrow_forward_ios
                                        : Icons.arrow_drop_down,
                                    size: 20,
                                    color: greyColor,
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(10.h),
                            Visibility(
                              visible: serviceType,
                              child: ServiceTypeWidget(
                                serviceList: provider.serviceProviderNameList,
                                provider: provider,
                                isServiceProvider: false,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: StatefulBuilder(
                        builder: (context, setState) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Service Provider",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Filter");
                                    setState(() {
                                      serviceProvider = !serviceProvider;
                                    });
                                  },
                                  child: Icon(
                                    !serviceType
                                        ? Icons.arrow_forward_ios
                                        : Icons.arrow_drop_down,
                                    size: 20,
                                    color: greyColor,
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(10.h),
                            Visibility(
                              visible: serviceProvider,
                              child: ServiceTypeWidget(
                                serviceList: provider.serviceList,
                                provider: provider,
                                isServiceProvider: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: StatefulBuilder(
                        builder: (context, setState) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date Range",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Filter");
                                    setState(() {
                                      date_range = !date_range;
                                    });
                                  },
                                  child: Icon(
                                    !serviceType
                                        ? Icons.arrow_forward_ios
                                        : Icons.arrow_drop_down,
                                    size: 20,
                                    color: greyColor,
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(10.h),
                            Visibility(
                              visible: date_range,
                              child: Container(
                                height: 500.h,
                                width: 500.w,
                                decoration: BoxDecoration(
                                  // color: greyColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: SfDateRangePicker(
                                  onSelectionChanged: _onSelectionChanged,
                                  startRangeSelectionColor: Colors.blue,
                                  selectionColor: secondaryColor,
                                  endRangeSelectionColor: Colors.blue,
                                  view: DateRangePickerView.month,
                                  rangeSelectionColor: Colors.blue[100],
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        print("Filter------------>>");
                        serviceProvider = false;
                        serviceType = false;
                        date_range = false;

                        log("Start Date ${provider.startDay}");
                        log("End Date ${provider.endDay}");

                        // provider.changeIsBusy();
                      },
                      child: Center(
                        child: Container(
                          height: 60.h,
                          width: 185.w,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                              child: Text(
                            "Done",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        print("Filter------------>>");

                        // Set the filter states to false
                        serviceProvider = false;
                        serviceType = false;
                        date_range = false;

                        // Iterate through the items that need to be cleared and set their values to false
                        for (int index = 0;
                            index < provider.serviceList.length;
                            index++) {
                          String key =
                              "servicelist${provider.serviceList[index]}";
                          await prefs.setBool(key, false);
                        }
                        for (int index = 0;
                            index < provider.serviceProviderNameList.length;
                            index++) {
                          String key =
                              "serviceprovider${provider.serviceProviderNameList[index]}";
                          await prefs.setBool(key, false);
                        }

                        // Call the clearFilter method provided by your provider to clear filters
                        provider.clearFilter();
                      },
                      child: Center(
                        child: Container(
                          height: 60.h,
                          width: 185.w,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Text(
                              "Clear filter",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 25.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class CustomColorKey extends StatefulWidget {
  const CustomColorKey({super.key});

  @override
  State<CustomColorKey> createState() => _CustomColorKeyState();
}

class _CustomColorKeyState extends State<CustomColorKey> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Text(
                "Colors with Service",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Services").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final color = Color(
                            int.parse(snapshot.data!.docs[index]["color"]));

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  color == Colors.white ? Colors.grey : color,
                            ),
                            title: Text(
                                snapshot.data!.docs[index]["Service name"]),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}

class ServiceTypeWidget extends StatefulWidget {
  List<String> serviceList = [];
  CalendarViewModel provider;
  bool? isServiceProvider;
  ServiceTypeWidget(
      {super.key,
      required this.serviceList,
      required this.provider,
      this.isServiceProvider});

  @override
  State<ServiceTypeWidget> createState() => _ServiceTypeWidgetState();
}

class _ServiceTypeWidgetState extends State<ServiceTypeWidget> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    print(widget.serviceList);
    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
      ),
      child: Container(
        height: 250.h,
        width: 456.w,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: widget.serviceList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.serviceList[index].toString(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomSelection(
                    provider: widget.provider,
                    index: index,
                    isServiceProvider: widget.isServiceProvider,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomSelection extends StatefulWidget {
  CalendarViewModel provider;
  int index;
  bool? isServiceProvider;
  CustomSelection(
      {super.key,
      required this.provider,
      required this.index,
      this.isServiceProvider});
  @override
  State<CustomSelection> createState() => _CustomSelectionState();
}

class _CustomSelectionState extends State<CustomSelection> {
  bool? isSelect = false;
  late SharedPreferences prefs;
  late String prefKey;

  @override
  void initState() {
    super.initState();
    _loadSelectedState();
  }

  Future<void> _loadSelectedState() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load the prefKey based on the current state
      prefKey = _generatePrefKey();
      isSelect = prefs.getBool(prefKey) ?? false;
    });
  }

  void _updateSelectedState(bool newValue, String key) {
    setState(() {
      prefs.setBool(key, newValue);
      isSelect = newValue;
    });
  }

  String _generatePrefKey() {
    // Generate and return the prefKey based on the current state
    if (widget.isServiceProvider!) {
      return "servicelist${widget.provider.serviceList[widget.index]}";
    } else {
      return "serviceprovider${widget.provider.serviceProviderNameList[widget.index]}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool newValue = !isSelect!;
        String newPrefKey =
            _generatePrefKey(); // Get the prefKey based on the current state
        print("Nasir $newPrefKey");

        if (widget.isServiceProvider!) {
          widget.provider.setFilterByServiceProvider(
              widget.provider.serviceList[widget.index]);
        } else {
          widget.provider
              .setFilter(widget.provider.serviceProviderNameList[widget.index]);
        }

        _updateSelectedState(newValue, newPrefKey);
      },
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelect! ? Colors.blue : Colors.grey,
          ),
          color: isSelect! ? Colors.blue : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 10,
        ),
      ),
    );
  }
}

class CustomCircle extends StatefulWidget {
  const CustomCircle({super.key});

  @override
  State<CustomCircle> createState() => _CustomCircleState();
}

class _CustomCircleState extends State<CustomCircle> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.red,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.blue,
        ));
  }
}
