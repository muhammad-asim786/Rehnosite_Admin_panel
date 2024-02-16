// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/service_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/flutter_toast.dart';

import '../ProductsScreen/helper_widgets.dart';

class ServicesLevelListView extends StatefulWidget {
  DocumentSnapshot? service;
  ServicesLevelListView({super.key, required this.service});

  @override
  State<ServicesLevelListView> createState() => _ServicesLevelListViewState();
}

class _ServicesLevelListViewState extends State<ServicesLevelListView> {
  TextEditingController nameController = TextEditingController();

  int indexValue = -1;
  String? selectedValue;

  List<String> domy = [];
  List weekSchedule = [
    'Fortnightly',
    'Monthly',
    'Weekly',
    "On Demand",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];
  @override
  Widget build(BuildContext context) {
    log(widget.service!.id);
    log(widget.service!["color"]);

    return Consumer<ServiceViewModel>(
      builder: (context, model, child) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.sp),
          ),
        ),
        child: Container(
          width: 550.w,
          height: 700.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 634.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.sp),
                    topRight: Radius.circular(32.sp),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        "SERVICE LEVEL",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: whiteColor,
                          letterSpacing: 0.5,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: whiteColor,
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              addVerticalSpace(10.h),
              Expanded(
                  child: ListView.builder(
                itemCount: weekSchedule.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: GestureDetector(
                      onTap: () {
                        if (domy.contains(weekSchedule[index])) {
                          setState(() {
                            domy.remove(weekSchedule[index]);
                          });
                        } else {
                          setState(() {
                            domy.add(weekSchedule[index]);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 480.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4.sp),
                            ),
                            child: Column(
                              children: [
                                // addVerticalSpace(12.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      weekSchedule[index].toString(),
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        color: blackColor.withOpacity(0.5),
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            domy.contains(weekSchedule[index])
                                                ? redColor
                                                : Colors.transparent,
                                        // borderRadius:
                                        //     BorderRadius.circular(50.sp),
                                      ),
                                      child: domy.contains(weekSchedule[index])
                                          ? Icon(
                                              Icons.check,
                                              color: whiteColor,
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(12.h),
                                Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: domy.contains(weekSchedule[index])
                                        ? secondaryColor
                                        : blackColor.withOpacity(0.5))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
              addVerticalSpace(10.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    print('dome data:$domy');
                    print(domy.length);
                    if (selectedValue != null) {
                      model.addServiceLevel(widget.service!.id, selectedValue!);
                      Navigator.pop(context);
                    } else if (domy.length > 0) {
                      print(domy);
                      String domyString = "";
                      for (var i = 0; i < domy.length; i++) {
                        domyString = domyString + domy[i] + "/";
                      }
                      //remove the last slash
                      domyString =
                          domyString.substring(0, domyString.length - 1);
                      model.addServiceLevel(widget.service!.id, domyString);
                      Navigator.pop(context);
                    } else {
                      FlutterTost.customToast("Please select a service level");
                    }
                  },
                  child: CustomContainer(
                    width: 200.w,
                    height: 60.h,
                    boarderRadius: 17.sp,
                    widget: Center(
                      child: Text(
                        "Add",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30.sp,
                          letterSpacing: 0.5,
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              addVerticalSpace(12.h),
            ],
          ),
        ),
      ),
    );
  }
}
