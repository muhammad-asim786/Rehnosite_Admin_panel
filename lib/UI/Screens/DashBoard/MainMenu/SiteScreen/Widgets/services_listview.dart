// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../../../../../CustomeWidgets/custom_container.dart';
import '../sites_screen.dart';

class ServicesListView extends StatefulWidget {
  int index;
  DocumentSnapshot? service;
  // String? userId, contatName;

  // List<dynamic> asignServiceList = [];

  ServicesListView({
    super.key,
    required this.index,
    required this.service,
    // this.userId,
    // this.contatName,
    // required this.asignServiceList,
  });

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  bool check = false;
  DateTime selectedDate = DateTime.now();

  gmail(String? email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email!,
      queryParameters: {'subject': 'Your Subject & Symbols are allowed!'},
    );

    await launchUrl(emailLaunchUri);
  }

  String? selectValue;
  @override
  Widget build(BuildContext context) {
    setState(() {});
    // var array = widget.service!["service level"]; // array is now List<dynamic>
    List<String> serviceLevel =
        List<String>.from(widget.service!["service level"]);

    // print(strings.runtimeType);

    DateFormat formatedDate = DateFormat('yyyy-MM-dd');
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2100),
        selectableDayPredicate: (DateTime date) {
          return true;
        },
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
        // dateSelected = DateFormat('yyyy-MM-dd').format(selectedDate);
        print(selectedDate);
      }
    }

    return Container(
      child: Consumer<SiteViewmodel>(
        builder: (context, model, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addHorizontalSpace(20.w),
                CustomSiteText2(
                  text: widget.service!['Service name'],
                  width: 100.w,
                ),
                SizedBox(
                  width: 20.w,
                ),

                // SizedBox(
                //   width:20.w,
                // ),

                SizedBox(
                  width: 80.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (serviceLevel.isEmpty) {
                          // Fluttertoast.showToast(
                          //     msg: "Currently no service level is available",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.CENTER,
                          //     timeInSecForIosWeb: 2,
                          //     backgroundColor: redColor,
                          //     webPosition: "center",
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("There is no service level")));
                        } else if (model.serviceLevel!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please select service level")));
                        }
                      },
                      child: Container(
                        width: 24.sp,
                        height: 22.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: secondaryColor,
                            width: 1,
                          ),
                        ),
                        child: serviceLevel.isEmpty
                            ? SizedBox()
                            : selectValue != null
                                ? Checkbox(
                                    side: BorderSide(
                                      color: Colors.transparent,
                                      width: 0,

                                      // strokeAlign: StrokeAlign.outside,
                                    ),
                                    checkColor: Colors.green,
                                    activeColor: Colors.transparent,
                                    tristate: false,
                                    value: check,
                                    onChanged: ((newVlue) {
                                      setState(() {
                                        check = newVlue!;
                                        print(
                                            "clicked...index.${widget.index}");
                                      });

                                      if (newVlue!) {
                                        model.setService(
                                          collectionId: model.collectionId!,
                                          docId: model.docId!,
                                          applies: check,
                                          serviceLevel: model.serviceLevel,
                                          startDate: (formatedDate
                                                  .format(selectedDate))
                                              .toString(),

                                          service:
                                              widget.service!['Service name'],
                                          serviceProvider: widget.service![
                                              'Service provider name'],
                                          email: widget.service![
                                              'Service provider email'],
                                          color: widget.service!['color'],
                                          serviceList: serviceLevel,

                                          // serviceLevel:
                                        );
                                        Navigator.pop(context);
                                        model.serviceLevel = "";
                                      } else {}

                                      // model.assignService(
                                      //     isTrue: newVlue,
                                      //     serviceId: widget.service!.id,
                                      //     siteDocId: widget.userId,
                                      //     service: widget.contatName);
                                    }))
                                : SizedBox(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 130.w,
                  height: 35.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: DropdownButton<String>(
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        value: selectValue,
                        isDense: true,
                        icon: Image.asset(
                          "assets/icons/arrow.png",
                          width: 20.w,
                          height: 20.h,
                        ),
                        isExpanded: true,
                        iconSize: 20.sp,
                        elevation: 16,
                        items: serviceLevel.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: "Sofia",
                                letterSpacing: 0.5,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Select service",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontFamily: "Sofia",
                            letterSpacing: 0.5,
                            color: secondaryColor.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (String? newValue) {
                          model.changeServiceLevel(newValue!);

                          setState(() {
                            selectValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  // color: redColor,
                  // child: CustomDropdown(
                  //   items: serviceLevel,
                  // icon: Image.asset(
                  //   "assets/icons/arrow.png",
                  //   width: 20.w,
                  //   height: 20.h,
                  // ),
                  //   // value: "Schedule - ${widget.service!['service level'][0]}",
                  // ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: 150.w,
                    height: 30.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatedDate.format(
                              selectedDate,
                            ),

                            // DateFormat('yyyy-MM-dd').format(selectedDate),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sofia",
                            ),
                          ),
                          Image.asset(
                            "assets/icons/cal2.png",
                            width: 25.w,
                            height: 25.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 140.w,
                  height: 30.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "29/04/2023",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 25.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sofia",
                          ),
                        ),
                        Image.asset(
                          "assets/icons/cal2.png",
                          width: 20.w,
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 150.w,
                  height: 30.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 80.w,
                          child: PopupMenuButton(
                            constraints: BoxConstraints(
                              minWidth: 150,
                              minHeight: 30,
                            ),
                            offset: Offset(50, 15),
                            color: Colors.black,
                            child: Text(
                              widget.service!['Service provider name'],
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 23.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Sofia",
                              ),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  gmail(widget
                                      .service!['Service provider email']
                                      .toString());
                                },
                                child: Text(
                                  widget.service!['Service provider email'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.sp,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text(
                                    widget.service!['Service provider name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.sp,
                                      letterSpacing: 0.5,
                                    )),
                                value: 2,
                              ),
                            ],
                          ),
                        ),
                        // addHorizontalSpace(10.w),
                        SizedBox(
                          height: 50.h,
                          width: 50.w,
                          child: CircleAvatar(
                            radius: 16.sp,
                            backgroundColor: redColor,
                            child: Icon(
                              Icons.close,
                              color: whiteColor,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                addHorizontalSpace(18.w),
              ],
            ),
            addVerticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: CustomContainer(
                height: 1,
                color: Colors.black,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
