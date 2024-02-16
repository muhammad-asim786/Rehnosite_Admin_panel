// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ReportFaults/report_fault_viewmodel.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';

class ReportMainListView extends StatefulWidget {
  int index;
  DocumentSnapshot? site;
  ReportMainListView({required this.index, required this.site});

  @override
  State<ReportMainListView> createState() => _ReportMainListViewState();
}

class _ReportMainListViewState extends State<ReportMainListView> {
  bool selected = false;
  bool check = false;
  int? selectIndex = -1;
  String? contactName = '';
  String? id;
  List<dynamic> ContactId = [];
  @override
  Widget build(BuildContext context) {
//  final reportModel=Provider.of<ReportFaultViewModel>(context,listen:true);
//     reportModel.clearSelectedData();

    return Consumer<ReportFaultViewModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(20.h),
          GestureDetector(
            onTap: () {
              model.selectData(widget.index.toString());
            },
            child: CustomContainer(
              height: 80.h,
              choseshadow: true,
              color: whiteColor,
              boarderRadius: 16.sp,
              width: double.infinity,
              widget: Row(
                children: [
                  addHorizontalSpace(10.w),
                  Text(
                    widget.site!["Fault site"],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sofia",
                    ),
                  ),
                  Spacer(),
                  addHorizontalSpace(20.w),
                  !model.selectedMap.containsKey(widget.index.toString())
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
                  addHorizontalSpace(20.w),
                ],
              ),
            ),
          ),
          Visibility(
            visible: model.selectedMap.containsKey(widget.index.toString()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(20.h),
                Row(
                  children: [
                    CustomContainer(
                      height: 350.h,
                      width: 330.w,
                      choseshadow: true,
                      color: Color.fromRGBO(248, 248, 248, 1),
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addHorizontalSpace(4.w),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Text(
                              "Reported by",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 35.sp,
                                letterSpacing: 0.5,
                                fontFamily: "Sofia",
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          addVerticalSpace(40.h),
                          Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 10.w),
                            child: Column(
                              children: [
                                CustomNameContainer(
                                  name: widget.site!["Contact name"],
                                ),
                                addVerticalSpace(20.h),
                                CustomNameContainer(
                                  name: widget.site!["Contact email"],
                                ),
                                addVerticalSpace(20.h),
                                CustomNameContainer(
                                  name: widget.site!["Contact phone"],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    addHorizontalSpace(20.w),
                    CustomContainer(
                        height: 350.h,
                        width: 920.w,
                        choseshadow: true,
                        color: Color(0xffF8F8F8),
                        widget: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fault Details",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  letterSpacing: 0.5,
                                  fontFamily: "Sofia",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              // Image.network(
                              //   widget.site!["Fault pic"].toString(),
                              //   height: 200.h,
                              //   width: 300.w,
                              //   fit: BoxFit.cover,
                              // ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: Container(
                                              child: Image.network(
                                                widget.site!["Fault pic"]
                                                    .toString(),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 250.h,
                                      width: 385.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.site!["Fault pic"]
                                                .toString(),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(10.w),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 450.w,
                                      maxHeight: 250.h,
                                    ),
                                    child: SingleChildScrollView(
                                      child: ReadMoreText(
                                        widget.site!["Fault message"],
                                        trimLines: 4,
                                        colorClickableText: Colors.pink,

                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Show more',

                                        trimExpandedText: '. Show less',
                                        lessStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.3),
                                          fontWeight: FontWeight.bold,
                                        ),

                                        moreStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.3),
                                          fontWeight: FontWeight.bold,
                                        ),

                                        // child: Text(
                                        //   widget.site!["Fault message"],
                                        //   textAlign: TextAlign.start,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   style: TextStyle(
                                        //     fontSize: 25.sp,
                                        //     letterSpacing: 0.5,
                                        //     fontFamily: "Sofia",
                                        //     color: secondaryColor,
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        //)
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                addVerticalSpace(20.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNameContainer extends StatelessWidget {
  String? name;
  CustomNameContainer({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 250.w,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: secondaryColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addHorizontalSpace(10.w),
            Text(
              name!,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 25.sp,
                letterSpacing: 0.5,
                fontFamily: "Sofia",
                color: secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
