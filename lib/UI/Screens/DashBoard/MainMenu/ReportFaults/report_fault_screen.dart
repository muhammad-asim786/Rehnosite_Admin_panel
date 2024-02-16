// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ReportFaults/report_fault_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ReportFaults/report_main_listView.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

class ReportFaultScreen extends StatefulWidget {
  ReportFaultScreen({super.key});

  @override
  State<ReportFaultScreen> createState() => _ReportFaultScreenState();
}

class _ReportFaultScreenState extends State<ReportFaultScreen> {
  bool selected = false;
  bool check = false;
  // create some values
// create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);

    print(pickerColor);
  }

  String searchSiteName = '';

  @override
  Widget build(BuildContext context) {
    //  final reportModel=Provider.of<ReportFaultViewModel>(context,listen: false);
    // reportModel.clearSelectedData();

    return Consumer<ReportFaultViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(60.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addHorizontalSpace(20.w),
                Text(
                  "REPORT FAULTS",
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
            addVerticalSpace(10.sp),
            Divider(
              color: blackColor.withOpacity(0.2),
              thickness: 1.sp,
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 1051.h,
                child: StreamBuilder(
                  stream: model.databaseService.reportFaultDB
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text(""));
                    }

                    // else if (snapshot.connectionState ==
                    //     ConnectionState.waiting) {
                    //   return Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }

                    else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot reportFault =
                              snapshot.data!.docs[index];
                          List<QueryDocumentSnapshot> documents =
                              snapshot.data!.docs;

                          // documents.sort((a, b) => (a['Fault site']
                          //             .toString()
                          //             .substring(0, 1)
                          //             .toUpperCase() +
                          //         a["Fault site"].toString().substring(1))
                          //     .compareTo(b['Fault site']
                          //             .toString()
                          //             .substring(0, 1)
                          //             .toUpperCase() +
                          //         b["Fault site"].toString().substring(1)));

                          if (searchSiteName.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: ReportMainListView(
                                index: index,
                                site: documents[index],
                              ),
                            );
                          } else if (documents[index]["Fault site"]
                              .toString()
                              .toLowerCase()
                              .contains(searchSiteName.toLowerCase())) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: ReportMainListView(
                                index: index,
                                site: documents[index],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            addVerticalSpace(50.h)
          ],
        ),
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
