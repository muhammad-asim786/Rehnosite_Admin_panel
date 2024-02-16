// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AddContactAlert extends StatefulWidget {
  String? site;
  int? index;
  AddContactAlert({
    super.key,
    required this.site,
    required this.index,
  });

  @override
  State<AddContactAlert> createState() => _AddContactAlertState();
}

class _AddContactAlertState extends State<AddContactAlert> {
  TextEditingController searchController = TextEditingController();

  // int indexValue = -1;
  late AutoScrollController controller;
  late List<List<int>> randomList;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  String contactSearch = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<SiteViewmodel>(
      builder: (context, model, child) => Container(
        width: 630.w,
        height: 710.h,
        child: Column(
          children: [
            addVerticalSpace(20.h),
            Row(
              children: [
                CustomContainer(
                  height: 80.h,
                  width: 580.w,
                  boarderRadius: 0,
                  color: whiteColor,
                  borderColor: Colors.transparent,
                  widget: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 10.w),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          contactSearch = value;
                        });
                      },
                      controller: searchController,
                      cursorColor: secondaryColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20.w, bottom: 30.h),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        hintStyle: TextStyle(
                          color: secondaryColor.withOpacity(0.6),
                          fontSize: 30.sp,
                          fontFamily: "Belt",
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: "Search",
                        // fillColor: Colors.grey[200],
                        // filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Text(
                  "ADD",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontFamily: "Belt",
                    color: searchController.text.isEmpty == true
                        ? secondaryColor.withOpacity(0.4)
                        : secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            addVerticalSpace(10.h),
            // Container(width: double.infinity, height: 2.h, color: greyColor),
            CustomContainer(
              height: 500.h,
              width: double.infinity,
              color: whiteColor,
              widget: FutureBuilder(
                future: model.databaseService.contactServiceDB.get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(""),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    controller.scrollToIndex(model.indexValue);

                    return ListView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<QueryDocumentSnapshot> documents =
                            snapshot.data!.docs;

                        documents.sort((a, b) =>
                            (a['name'].toString().toLowerCase()).compareTo(
                              b['name'].toString().toLowerCase(),
                            ));
                        if (contactSearch.isEmpty) {
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: controller,
                            index: index,
                            child: GestureDetector(
                              onTap: () {
                                model.changeIndex(index);
                                model.changeSelectedValue(
                                  documents[index]["name"].toString(),
                                  documents[index]["email"].toString(),
                                  documents[index]["phone"].toString(),
                                );
                              },
                              child: Container(
                                height: 75.h,
                                decoration: BoxDecoration(
                                  color: model.indexValue == index
                                      ? secondaryColor
                                      : whiteColor,
                                ),
                                child: Column(
                                  children: [
                                    addVerticalSpace(20.h),
                                    Row(
                                      children: [
                                        addHorizontalSpace(20.w),
                                        Text(
                                          documents[index]["name"],
                                          style: TextStyle(
                                            color: model.indexValue == index
                                                ? whiteColor
                                                : blackColor,
                                            fontSize: 25.sp,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Sofia",
                                          ),
                                        ),
                                        addHorizontalSpace(18.w),
                                      ],
                                    ),
                                    addVerticalSpace(20.h),
                                    Container(
                                        width: double.infinity,
                                        height: 2.h,
                                        color: model.indexValue == index
                                            ? secondaryColor
                                            : greyColor),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (documents[index]["name"]
                            .toString()
                            .toLowerCase()
                            .contains(contactSearch.toLowerCase())) {
                          return GestureDetector(
                            onTap: () {
                              model.changeIndex(index);
                              model.changeSelectedValue(
                                documents[index]["name"].toString(),
                                documents[index]["email"].toString(),
                                documents[index]["phone"].toString(),
                              );
                              setState(() {});
                            },
                            child: Container(
                              height: 75.h,
                              decoration: BoxDecoration(
                                color: model.indexValue == index
                                    ? secondaryColor
                                    : whiteColor,
                              ),
                              child: Column(
                                children: [
                                  addVerticalSpace(20.h),
                                  Row(
                                    children: [
                                      addHorizontalSpace(20.w),
                                      Text(
                                        documents[index]["name"],
                                        style: TextStyle(
                                          color: model.indexValue == index
                                              ? whiteColor
                                              : blackColor,
                                          fontSize: 25.sp,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Sofia",
                                        ),
                                      ),
                                      addHorizontalSpace(18.w),
                                    ],
                                  ),
                                  addVerticalSpace(20.h),
                                  Container(
                                      width: double.infinity,
                                      height: 2.h,
                                      color: model.indexValue == index
                                          ? secondaryColor
                                          : greyColor),
                                ],
                              ),
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
            GestureDetector(
              onTap: () {
                log(model.selectedValue.toString());

                //add contact to site
                model.addContactName(
                  widget.site.toString().toString(),
                  model.selectedValue.toString(),
                  model.selectEmail.toString(),
                  model.phoneNumber.toString(),
                );

                Navigator.pop(context);
              },
              child: CustomContainer(
                width: 170.w,
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
            )
          ],
        ),
      ),
    );
  }
}
