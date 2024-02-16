// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/Widgets/services_listview.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../../../../../CustomeWidgets/custom_container.dart';
import '../sites_screen.dart';

class ServicesConatainer extends StatefulWidget {
  int? index;
  String? id;
  String? contactName;
  List<dynamic> asignServiceList = [];
  ServicesConatainer(
      {super.key,
      required this.index,
      required this.contactName,
      required this.id,
      required this.asignServiceList});

  @override
  State<ServicesConatainer> createState() => _ServicesConatainerState();
}

class _ServicesConatainerState extends State<ServicesConatainer> {
  bool check = false;
  List selectedServiceList = [];
  DateTime selectedDate = DateTime.now();
  gmail(String? email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email!,
      queryParameters: {'subject': 'Your Subject & Symbols are allowed!'},
    );

    await launchUrl(emailLaunchUri);
  }

  String? value;
  String? nextDate = "";
  DateFormat formatedDate = DateFormat('yyyy-MM-dd');

  void setTheNextDate(DocumentSnapshot snapshot) {
    List<String> serviceLevelList = snapshot["service level"].split('/');

    // DateTime today = DateTime
    //     .now(); // Replace with your current date or DateTime.now() for the current date

    if (serviceLevelList.length > 0) {
      int date = showDate(serviceLevelList[0]);

      DateTime dateTime = DateTime.parse(snapshot["start date"]);
      print(selectedServiceList);

      if (serviceLevelList[0].toString() == "Weekly") {
        DateTime nextMonday = dateTime.add(Duration(days: 7));

        //dateTime = dateTime.add(Duration(days: date));

        nextDate = formatedDate.format(nextMonday);
      } else if (serviceLevelList[0] == "Monthly") {
        DateTime nextMonday = dateTime.add(Duration(days: 30));

        //dateTime = dateTime.add(Duration(days: date));

        nextDate = formatedDate.format(nextMonday);
      } else if (serviceLevelList[0] == "Fortnightly") {
        DateTime nextMonday = dateTime.add(Duration(days: 14));

        //dateTime = dateTime.add(Duration(days: date));

        nextDate = formatedDate.format(nextMonday);
      } else if (serviceLevelList[0] == "On Demand") {
        // DateTime nextMonday = dateTime.add(Duration(days: 0));

        //dateTime = dateTime.add(Duration(days: date));

        nextDate = "";
      } else {
        print("else part called");
        int daysUntilNextMonday = (date - dateTime.weekday + 7) % 7;

        if (daysUntilNextMonday == 0) {
          DateTime nextMonday = dateTime.add(Duration(days: 7));

          //dateTime = dateTime.add(Duration(days: date));

          nextDate = formatedDate.format(nextMonday);
        } else {
          log("daysUntilNextMonday--->>$daysUntilNextMonday");
          DateTime nextMonday =
              dateTime.add(Duration(days: daysUntilNextMonday));

          //dateTime = dateTime.add(Duration(days: date));

          nextDate = formatedDate.format(nextMonday);
        }
      }

      // } else if (dateTime.isAfter(DateTime.now())) {
      //   int daysUntilNext = (date - DateTime.now().weekday + 7) % 7;
      //   DateTime nextMonday = dateTime.add(Duration(days: daysUntilNext));

      //   // dateTime = dateTime.add(Duration(days: date));
      //   nextDate = formatedDate.format(nextMonday);
      // }
      log("next date is $dateTime");

      // DateTime nextDate = snapshot['start date'].toDate();
      // nextDate = nextDate.add(Duration(days: date));
      // log("next date is ${nextDate}");
    }
  }

  int showDate(String day) {
    switch (day) {
      case 'Monday':
        return 1;

      case 'Tuesday':
        return 2;

      case 'Wednesday':
        return 3;

      case 'Thursday':
        return 4;

      case 'Friday':
        return 5;

      case 'Saturday':
        return 6;

      case 'Sunday':
        return 7;

      case "Weekley":
        return 7;

      case "Monthly":
        return 30;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatedDate = DateFormat('yyyy-MM-dd');

    Future<void> _selectDate(
        BuildContext context, SiteViewmodel model, String serviceId) async {
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
        model.updateDate(
            formatedDate.format(selectedDate).toString(), serviceId);
      }
    }

    print("assgin service List:${widget.asignServiceList}");
    return Consumer<SiteViewmodel>(
      builder: (context, model, child) => Container(
        child: Column(
          children: [
            addVerticalSpace(4.h),
            Row(
              children: [
                addHorizontalSpace(4.w),
                Text(
                  "Services",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontFamily: "Sofia",
                    letterSpacing: 0.5,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            addVerticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addHorizontalSpace(6.w),

                SizedBox(
                  width: 100.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SERVICES",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(10.w),
                SizedBox(
                  width: 110.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("APPLIES",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(40.w),
                SizedBox(
                  width: 130.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SERVICE LEVEL",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                addHorizontalSpace(20.w),
                SizedBox(
                  width: 130.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("START DATE",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(110.w),
                SizedBox(
                  width: 140.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("NEXT SERVICE DATE",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(27.w),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 150.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SERVICE PROVIDER",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
            addVerticalSpace(15.h),
            widget.index == -1
                ? SizedBox()
                : Expanded(
                    child: StreamBuilder(
                      stream: model.databaseService.userSiteDB
                          .doc(model.collectionId)
                          .collection("Contacts")
                          .doc(model.docId)
                          .collection("Services")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(''),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          selectedServiceList.clear();
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<QueryDocumentSnapshot> service =
                                  snapshot.data!.docs;

                              service.sort((a, b) =>
                                  (a['service'].toString().toLowerCase())
                                      .compareTo(
                                    b['service'].toString().toLowerCase(),
                                  ));

                              // DocumentSnapshot service =
                              //     snapshot.data!.docs[index];
                              selectedServiceList
                                  .add(service[index]["service"]);

                              selectedDate = DateTime.parse(
                                  service[index]["start date"].toString());

                              List<String> serviceLevel = List<String>.from(
                                  service[index]["service list"]);

                              value = service[index]["service level"];
                              log("value:$value");
                              setTheNextDate(service[index]);

                              return Column(
                                children: [
                                  addVerticalSpace(20.h),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        addHorizontalSpace(6.w),
                                        CustomSiteText2(
                                          text: service[index]["service"],
                                          width: 110.w,
                                        ),
                                        Container(
                                          width: 100.w,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                addHorizontalSpace(10.w),
                                                Container(
                                                  width: 24.sp,
                                                  height: 22.sp,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: secondaryColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Checkbox(
                                                      side: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 0,

                                                        // strokeAlign: StrokeAlign.outside,
                                                      ),
                                                      checkColor: Colors.green,
                                                      activeColor:
                                                          Colors.transparent,
                                                      tristate: false,
                                                      value: service[index]
                                                          ["applies"],
                                                      onChanged: ((newVlue) {
                                                        // update the value of applies
                                                        model.updateApplies(
                                                            newVlue!,
                                                            service[index]
                                                                .id
                                                                .toString());
                                                        // setState(() {
                                                        //   // check = newVlue!;
                                                        //   // print(
                                                        //   //     "clicked...index.${widget.index}");
                                                        // });

                                                        // model.setService(
                                                        //     collectionId:);

                                                        // model.assignService(
                                                        //     isTrue: newVlue,
                                                        //     serviceId: widget.service!.id,
                                                        //     siteDocId: widget.userId,
                                                        //     service: widget.contatName);
                                                      })),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 130.w,
                                          height: 35.h,
                                          // child: Text(
                                          //   snapshot.data!
                                          //       .docs[index]["service level"]
                                          //       .toString(),
                                          //   style: TextStyle(
                                          //     color: secondaryColor,
                                          //     fontSize: 15,
                                          //     fontFamily: "Sofia",
                                          //     letterSpacing: 0.5,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                          // color: redColor,
                                          // child: CustomDropdown(
                                          //   items: serviceLevel,
                                          //   icon: Image.asset(
                                          //     "assets/icons/arrow.png",
                                          //     width: 20.w,
                                          //     height: 20.h,
                                          //   ),
                                          // value: "Schedule - ${widget.service!['service level'][0]}",
                                          //),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButton(
                                              underline: Container(
                                                color: Colors.transparent,
                                              ),
                                              isDense: true,
                                              isExpanded: true,
                                              iconSize: 20.sp,
                                              elevation: 16,
                                              icon: Image.asset(
                                                "assets/icons/arrow.png",
                                                width: 20.w,
                                                height: 20.h,
                                              ),
                                              value: value,
                                              items: serviceLevel
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                model.changeServiceValue(
                                                    newValue!,
                                                    service[index]
                                                        .id
                                                        .toString());
                                              },
                                            ),
                                          ),
                                        ),
                                        addHorizontalSpace(20.w),
                                        GestureDetector(
                                          onTap: () {
                                            //update the date

                                            _selectDate(context, model,
                                                service[index].id.toString());
                                          },
                                          child: Container(
                                            width: 120.w,
                                            height: 30.h,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                        Container(
                                          width: 150.w,
                                          height: 30.h,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                addHorizontalSpace(10.w),
                                                Text(
                                                  nextDate.toString(),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
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
                                                      service[index]
                                                          ["service provider"],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: secondaryColor,
                                                        fontSize: 23.sp,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Sofia",
                                                      ),
                                                    ),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        child: Text(
                                                          service[index][
                                                              "service provider"],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 23.sp,
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                        value: 1,
                                                      ),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          gmail(service[index]
                                                                  ["email"]
                                                              .toString());
                                                        },
                                                        child: Text(
                                                            service[index]
                                                                ["email"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 23.sp,
                                                              letterSpacing:
                                                                  0.5,
                                                            )),
                                                        value: 2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      model.deleteService(
                                                          service[index]
                                                              .id
                                                              .toString());
                                                    },
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
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // addHorizontalSpace(18.w),
                                      ]),
                                  addVerticalSpace(10.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.sp),
                                    child: CustomContainer(
                                      height: 1,
                                      color: Colors.black,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
            addVerticalSpace(30.h),
            widget.index == -1
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: GestureDetector(
                              onTap: () {
                                print(
                                    "service Lenght ${selectedServiceList.length}");
                                showDialog(
                                  context: context,
                                  builder: (ctx) => ServiceWidgetAlert(
                                    selectedServiceList: selectedServiceList,
                                  ),
                                );
                              },
                              child:
                                  Icon(Icons.add, size: 30, color: redColor)))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

// service widget alert

class ServiceWidgetAlert extends StatefulWidget {
  List selectedServiceList = [];
  ServiceWidgetAlert({super.key, required this.selectedServiceList});

  @override
  State<ServiceWidgetAlert> createState() => _ServiceWidgetAlertState();
}

class _ServiceWidgetAlertState extends State<ServiceWidgetAlert> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    log("height:$height");
    log("width:$width");
    log(widget.selectedServiceList.toString());
    final model = Provider.of<SiteViewmodel>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.sp),
        ),
      ),
      child: Container(
        height: 400,
        width: width < 1680 ? 820 : width * 0.5344,
        // color: Colors.red,
        child: Column(
          children: [
            addVerticalSpace(20.sp),
            Row(
              children: [
                addHorizontalSpace(4.sp),
                Text(
                  "Services",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontFamily: "Sofia",
                    letterSpacing: 0.5,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            addVerticalSpace(10.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // addHorizontalSpace(65.sp),
                addHorizontalSpace(20.w),
                SizedBox(
                  width: 90.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SERVICES",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                // addHorizontalSpace(90.sp),
                SizedBox(
                  width: 90.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("APPLIES",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(70.sp),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 130.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SERVICE LEVEL",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(90.sp),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 150.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("START DATE",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(160.sp),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 140.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("NEXT SERVICE DATE",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                // addHorizontalSpace(80.sp),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 150.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SERVICE PROVIDER",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Sofia",
                          letterSpacing: 0.5,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
            addVerticalSpace(15.sp),
            addVerticalSpace(10.sp),
            Expanded(
              child: StreamBuilder(
                stream: model.databaseService.serviceDB.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text(""));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // DocumentSnapshot service = snapshot.data!.docs[index];
                        List<QueryDocumentSnapshot> service =
                            snapshot.data!.docs;

                        service.sort((a, b) =>
                            (a['Service name'].toString().toLowerCase())
                                .compareTo(
                              b['Service name'].toString().toLowerCase(),
                            ));

                        if (widget.selectedServiceList
                            .contains(service[index]["Service name"])) {
                          return Container();
                        } else {
                          return ServicesListView(
                            index: index,
                            service: service[index],
                          );
                        }
                      },
                    );
                  } else {
                    return Container();
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
