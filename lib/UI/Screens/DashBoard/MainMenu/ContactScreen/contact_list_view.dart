import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ContactScreen/contactScreen_viewmodel.dart';

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.only(top: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: model.databaseService.contactServiceDB.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(""),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                    documents.sort((a, b) =>
                        (a['name'].toString().toLowerCase())
                            .compareTo(b['name'].toString().toLowerCase()));

                    if (model.searchText!.isEmpty) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: CustomContainer(
                              width: 1266.w,
                              height: 80.h,
                              color: whiteColor,
                              boarderRadius: 16.sp,
                              choseshadow: true,
                              widget: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  addHorizontalSpace(35.w),
                                  Container(
                                    width: 200.w,
                                    child: Text(
                                      documents[index]["name"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        letterSpacing: 0.5,
                                        color: secondaryColor,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(15.w),
                                  Container(
                                    width: 200.w,
                                    child: Text(
                                      documents[index]["jobTitle"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        letterSpacing: 0.5,
                                        color: secondaryColor,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(2.w),
                                  Container(
                                    width: 200.w,
                                    child: Text(
                                      documents[index]["companyName"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        letterSpacing: 0.5,
                                        color: secondaryColor,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 200.w,
                                    child: Text(
                                      documents[index]["phone"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        letterSpacing: 0.5,
                                        color: secondaryColor,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(50.w),
                                  Spacer(),
                                  Container(
                                    width: 300.w,
                                    child: Text(
                                      documents[index]["email"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        letterSpacing: 0.5,
                                        color: secondaryColor,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        String id = documents[index].id;
                                        model.showDilog(context, id,
                                            documents[index]["email"]);
                                      },
                                      child: Icon(Icons.delete)),
                                  addHorizontalSpace(20.h),
                                  addVerticalSpace(20.h),
                                ],
                              ),
                            ),
                          ),
                          addVerticalSpace(22.h),
                        ],
                      );
                    } else if (documents[index]["name"]
                        .toString()
                        .toLowerCase()
                        .contains(model.searchText!.toLowerCase().toString())) {
                      return Column(
                        children: [
                          CustomContainer(
                            width: 1266.w,
                            height: 80.h,
                            color: whiteColor,
                            boarderRadius: 16.sp,
                            choseshadow: true,
                            widget: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                addHorizontalSpace(40.w),
                                Container(
                                  width: 200.w,
                                  child: Text(
                                    documents[index]["name"],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      letterSpacing: 0.5,
                                      color: secondaryColor,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(15.w),
                                Container(
                                  width: 200.w,
                                  child: Text(
                                    documents[index]["jobTitle"],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      letterSpacing: 0.5,
                                      color: secondaryColor,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(2.w),
                                Container(
                                  width: 200.w,
                                  child: Text(
                                    documents[index]["companyName"],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      letterSpacing: 0.5,
                                      color: secondaryColor,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200.w,
                                  child: Text(
                                    documents[index]["phone"],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      letterSpacing: 0.5,
                                      color: secondaryColor,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(50.w),
                                Container(
                                  width: 300.w,
                                  child: Text(
                                    documents[index]["email"],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      letterSpacing: 0.5,
                                      color: secondaryColor,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                addVerticalSpace(20.h),
                              ],
                            ),
                          ),
                          addVerticalSpace(22.h),
                        ],
                      );
                    }
                    return Container();
                  });
            } else {
              // return Text("dklk");

              return Container();
            }
          },
        ),
      ),
    );
  }
}
