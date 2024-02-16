// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ReportFaults/report_main_listView.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/siteRequest/site_request_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/flutter_toast.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class SiteRequestScreen extends StatefulWidget {
  SiteRequestScreen({super.key});

  @override
  State<SiteRequestScreen> createState() => _SiteRequestScreenState();
}

class _SiteRequestScreenState extends State<SiteRequestScreen> {
  bool selected = false;
  bool check = false;
  // create some values
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  //  ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);

    print(pickerColor);
  }

  String searchSiteName = '';
  // int idex = 0;
  final databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<SiteRequestViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(60.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addHorizontalSpace(20.w),
              Text(
                "SITE REQUESTS",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 50.sp,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              SizedBox(
                height: 70.h,
                width: 520.w,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchSiteName = value;
                    });
                  },
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(25.sp),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        "assets/images/search.png",
                        height: 40.h,
                        width: 40.w,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: blackColor.withOpacity(0.6),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                ),
              ),
              addHorizontalSpace(20.w),
            ],
          ),
          addVerticalSpace(30.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.sp, right: 20.sp),
                child: Row(
                  children: [
                    SizedBox(
                      width: 300.h,
                      child: Text(
                        "Requested by",
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                    ),
                    addHorizontalSpace(240.w),
                    SizedBox(
                      width: 300.h,
                      child: Text(
                        "Requested Site",
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(10.sp),
              Divider(
                color: blackColor.withOpacity(0.2),
                thickness: 1.sp,
                height: 0,
              ),
            ],
          ),
          addVerticalSpace(20.h),
          Padding(
            padding: EdgeInsets.only(left: 30.sp, right: 20.sp),
            child: Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.81,
                child: StreamBuilder(
                  stream: databaseService.siteRequestDB
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    log('my stream builder is rebuilding');
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<SiteRequestViewModel>(
                        builder: (context, valuee, child) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot siteRequest =
                                  snapshot.data!.docs[index];
                              String id = snapshot.data!.docs[index].id;
                              String? isApprove = siteRequest['isApproveOrNot'];
                              if (searchSiteName.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () {
                                        valuee.changeIndex(index);
                                      },
                                      child: Container(
                                          height: 80.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          margin: EdgeInsets.only(bottom: 15.h),
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    blackColor.withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Container(
                                                width: 300.h,
                                                child: Text(
                                                  siteRequest["Contact name"],
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 30.sp,
                                                    letterSpacing: 0.5,
                                                    fontFamily: "Sofia",
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              addHorizontalSpace(230.w),
                                              Container(
                                                width: 300.h,
                                                child: Text(
                                                  siteRequest["Site name"],
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 30.sp,
                                                    letterSpacing: 0.5,
                                                    fontFamily: "Sofia",
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              // addHorizontalSpace(500.w),
                                              valuee.index != index
                                                  ? Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: blackColor,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Transform.rotate(
                                                          angle: 90 *
                                                              math.pi /
                                                              180,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color:
                                                                secondaryColor,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ))),
                                    ),
                                    SizedBox(height: 5.h),
                                    valuee.index == index
                                        ? Container(
                                            padding:
                                                EdgeInsets.only(bottom: 20.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: CustomContainer(
                                                        height: 350.h,
                                                        width: 330.w,

                                                        choseshadow: true,
                                                        // color: Color.fromRGBO(
                                                        //     248, 248, 248, 1),
                                                        color: Colors.white,
                                                        widget: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            addHorizontalSpace(
                                                                4.w),
                                                            addVerticalSpace(
                                                                40.h),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          30.w,
                                                                      right:
                                                                          10.w),
                                                              child: Column(
                                                                children: [
                                                                  CustomNameContainer(
                                                                    // name: widget.site!["Contact name"],
                                                                    name: siteRequest[
                                                                        "Contact name"],
                                                                  ),
                                                                  addVerticalSpace(
                                                                      20.h),
                                                                  CustomNameContainer(
                                                                    // name: widget.site!["Contact email"],
                                                                    name: siteRequest[
                                                                        "Contact email"],
                                                                  ),
                                                                  addVerticalSpace(
                                                                      20.h),
                                                                  CustomNameContainer(
                                                                    // name: widget.site!["Contact phone"],
                                                                    name: siteRequest[
                                                                        "Contact phone"],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    addHorizontalSpace(80.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CustomContainer(
                                                              height: 350.h,
                                                              width: 700.w,
                                                              choseshadow: true,
                                                              color:
                                                                  Colors.white,
                                                              widget: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.sp),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        350.h,
                                                                    width:
                                                                        700.w,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(vertical: 10.h),
                                                                        child:
                                                                            Text(
                                                                          siteRequest[
                                                                              "Site message"],
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              TextStyle(
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontSize:
                                                                                30.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontFamily:
                                                                                "Sofia",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 10.w),
                                                            isApprove!
                                                                    .isNotEmpty
                                                                ? Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      isApprove !=
                                                                              'Approve'
                                                                          ? SizedBox(
                                                                              // width: 60.w,
                                                                              height: 40.h,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  valuee.reqSiteAproveOrReject(siteRequest["ContadId"], siteRequest["Contact name"], siteRequest["Contact email"], siteRequest["Contact phone"], siteRequest["token"], 'Confirmation, you have now been added to the ${siteRequest["Site name"]} site', siteRequest['siteId'], siteRequest['ContadId']);
                                                                                  valuee.databaseService.siteRequestDB.doc(id).update({
                                                                                    'isApproveOrNot': 'Approve'
                                                                                  });
                                                                                  FlutterTost.customToast("You are Approve This Site");
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Colors.green,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(20.r),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  'Approve',
                                                                                  style: TextStyle(color: whiteColor),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Icon(
                                                                              Icons.check),
                                                                      SizedBox(
                                                                          height:
                                                                              20.w),
                                                                      isApprove !=
                                                                              'Reject'
                                                                          ? SizedBox(
                                                                              // width: 70.w,
                                                                              height: 40.h,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  valuee.reqSiteAproveOrReject(siteRequest["ContadId"], siteRequest["Contact name"], siteRequest["Contact email"], siteRequest["Contact phone"], siteRequest["token"], 'Confirmation, Your site change request has been rejected', siteRequest['siteId'], siteRequest['ContadId']);
                                                                                  valuee.databaseService.siteRequestDB.doc(id).update({
                                                                                    'isApproveOrNot': 'Reject'
                                                                                  });
                                                                                  FlutterTost.customToast("You are Reject This Site");
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Colors.red,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(20.r),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  'Reject',
                                                                                  style: TextStyle(color: whiteColor),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Icon(
                                                                              Icons.cancel),
                                                                    ],
                                                                  )
                                                                : SizedBox
                                                                    .shrink()
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                );
                              } else if (siteRequest["Site name"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchSiteName
                                      .toString()
                                      .toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () {
                                        valuee.changeIndex(index);
                                      },
                                      child: Container(
                                          height: 80.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          margin: EdgeInsets.only(bottom: 20.h),
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    blackColor.withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Container(
                                                width: 300.h,
                                                child: Text(
                                                  siteRequest["Contact name"],
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 35.sp,
                                                    letterSpacing: 0.5,
                                                    fontFamily: "Sofia",
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              addHorizontalSpace(230.w),
                                              Container(
                                                width: 300.h,
                                                child: Text(
                                                  siteRequest["Site name"],
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 35.sp,
                                                    letterSpacing: 0.5,
                                                    fontFamily: "Sofia",
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              addHorizontalSpace(640.w),
                                              valuee.index != index
                                                  ? Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: blackColor,
                                                      size: 30,
                                                    )
                                                  : Transform.rotate(
                                                      angle: 90 * math.pi / 180,
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: secondaryColor,
                                                        size: 30,
                                                      ),
                                                    ),
                                            ],
                                          ))),
                                    ),
                                    SizedBox(height: 5.h),
                                    valuee.index == index
                                        ? Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: CustomContainer(
                                                        height: 350.h,
                                                        width: 330.w,

                                                        choseshadow: true,
                                                        // color: Color.fromRGBO(
                                                        //     248, 248, 248, 1),
                                                        color: Colors.white,
                                                        widget: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            addHorizontalSpace(
                                                                4.w),
                                                            addVerticalSpace(
                                                                40.h),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          30.w,
                                                                      right:
                                                                          10.w),
                                                              child: Column(
                                                                children: [
                                                                  CustomNameContainer(
                                                                    // name: widget.site!["Contact name"],
                                                                    name: siteRequest[
                                                                        "Contact name"],
                                                                  ),
                                                                  addVerticalSpace(
                                                                      20.h),
                                                                  CustomNameContainer(
                                                                    // name: widget.site!["Contact email"],
                                                                    name: siteRequest[
                                                                        "Contact email"],
                                                                  ),
                                                                  addVerticalSpace(
                                                                      20.h),
                                                                  CustomNameContainer(
                                                                    // name: widget.site!["Contact phone"],
                                                                    name: siteRequest[
                                                                        "Contact phone"],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    addHorizontalSpace(100.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CustomContainer(
                                                              height: 350.h,
                                                              width: 700.w,
                                                              choseshadow: true,
                                                              color:
                                                                  Colors.white,
                                                              widget: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.sp),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        350.h,
                                                                    width:
                                                                        700.w,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(vertical: 10.h),
                                                                        child:
                                                                            Text(
                                                                          siteRequest[
                                                                              "Site message"],
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              TextStyle(
                                                                            letterSpacing:
                                                                                0.5,
                                                                            fontSize:
                                                                                30.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontFamily:
                                                                                "Sofia",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 10.w),
                                                            isApprove!
                                                                    .isNotEmpty
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      isApprove !=
                                                                              'Approve'
                                                                          ? SizedBox(
                                                                              width: 60.w,
                                                                              height: 40.h,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  valuee.reqSiteAproveOrReject(siteRequest["ContadId"], siteRequest["Contact name"], siteRequest["Contact email"], siteRequest["Contact phone"], siteRequest["token"], 'Confirmation, you have now been added to the ${siteRequest["Site name"]} site', siteRequest['siteId'], siteRequest['ContadId']);
                                                                                  valuee.databaseService.siteRequestDB.doc(id).update({
                                                                                    'isApproveOrNot': 'Approve'
                                                                                  });
                                                                                  FlutterTost.customToast("You are Approve This Site");
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Colors.green,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(20.r),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  'Approve',
                                                                                  style: TextStyle(fontSize: 11.sp),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Icon(
                                                                              Icons.check),
                                                                      SizedBox(
                                                                          width:
                                                                              20.w),
                                                                      isApprove !=
                                                                              'Reject'
                                                                          ? SizedBox(
                                                                              width: 60.w,
                                                                              height: 40.h,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  valuee.reqSiteAproveOrReject(siteRequest["ContadId"], siteRequest["Contact name"], siteRequest["Contact email"], siteRequest["Contact phone"], siteRequest["token"], 'Confirmation, Your site change request has been rejected', siteRequest['siteId'], siteRequest['ContadId']);
                                                                                  valuee.databaseService.siteRequestDB.doc(id).update({
                                                                                    'isApproveOrNot': 'Reject'
                                                                                  });
                                                                                  FlutterTost.customToast("You are Reject This Site");
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Colors.red,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(20.r),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  'Reject',
                                                                                  style: TextStyle(fontSize: 12.sp),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Icon(
                                                                              Icons.cancel),
                                                                    ],
                                                                  )
                                                                : SizedBox
                                                                    .shrink()
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                )),
          ),
          addVerticalSpace(50.h)
        ],
      ),
    );
  }
}

class CustomSiteText extends StatelessWidget {
  String text;
  double width;
  CustomSiteText({super.key, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 30.h,
      // color: redColor,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color(0xff656565),
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          fontFamily: "Sofia",
        ),
      ),
    );
  }
}

class CustomSiteText2 extends StatelessWidget {
  String text;
  double width;
  CustomSiteText2({super.key, required this.text, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 30.h,
      // color: redColor,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: secondaryColor,
          fontSize: 25.sp,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold,
          fontFamily: "Sofia",
        ),
      ),
    );
  }
}
