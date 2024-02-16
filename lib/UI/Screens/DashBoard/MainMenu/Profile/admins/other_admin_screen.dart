// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/profile_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

import '../../ProductsScreen/helper_widgets.dart';

class OtherAdminScreen extends StatefulWidget {
  ProfileViewmodel? model;
  OtherAdminScreen({super.key, required this.model});

  @override
  State<OtherAdminScreen> createState() => _OtherAdminScreenState();
}

class _OtherAdminScreenState extends State<OtherAdminScreen> {
  String? selectText = "Add";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectText = "Add";
                  });
                  addNewAdmin(context);
                },
                child: Icon(
                  Icons.add,
                  color: secondaryColor,
                  size: 50.sp,
                ),
              ),
            ],
          ),
          // addHorizontalSpace(15.w),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.48,

            child: StreamBuilder(
              stream: widget.model!.databaseService.adminDB
                  .where("isSuperAdmin", isEqualTo: false)
                  .snapshots(),
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
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot admin = snapshot.data!.docs[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 50.h),
                        width: 1175.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: greyColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]["name"],
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    color: secondaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectText = "Edit";
                                        });
                                        widget.model!.editValue(admin);
                                        addNewAdmin(context);
                                      },
                                      child: Image.asset(
                                        "assets/icons/edit.png",
                                        height: 40.h,
                                        color: secondaryColor,
                                        width: 40.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        widget.model!.deleteAdmin(admin.id);
                                      },
                                      child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.red,
                                          child: Center(
                                            child: Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            // child: ListView.builder(
            //   itemCount: nameList.length,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin: EdgeInsets.only(bottom: 50.h),
            //       width: 1175.w,
            //       height: 70.h,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: greyColor.withOpacity(0.2)),
            //         borderRadius: BorderRadius.circular(10),
            //         color: whiteColor,
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.2),
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       child: Center(
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 nameList[index].name!,
            //                 style: TextStyle(
            //                   fontSize: 30.sp,
            //                   letterSpacing: 0.5,
            //                   fontWeight: FontWeight.w700,
            //                   color: secondaryColor,
            //                 ),
            //               ),
            //               Row(
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () {
            //                       addNewAdmin(context);
            //                     },
            //                     child: Image.asset(
            //                       "assets/icons/edit.png",
            //                       height: 40.h,
            //                       color: secondaryColor,
            //                       width: 40.h,
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 10.w,
            //                   ),
            //                   GestureDetector(
            //                     onTap: () {
            //                       setState(() {
            //                         nameList.removeAt(index);
            //                       });
            //                     },
            //                     child: CircleAvatar(
            //                         radius: 10,
            //                         backgroundColor: Colors.red,
            //                         child: Center(
            //                           child: Icon(
            //                             Icons.close,
            //                             size: 20,
            //                             color: Colors.white,
            //                           ),
            //                         )),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
      // child: Container(
      //   width: 1175.w,
      //   height: 65.h,
      //   color: Colors.red,
      // ),
    );
  }

  // add new admin

  Future<dynamic> addNewAdmin(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)), //this right here
              child: Form(
                key: _formKey,
                child: Container(
                  height: 776.h,
                  width: 855.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 87.h,
                        width: 855.w,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Center(
                          child: Text("ADD NEW ADMIN",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 35.sp,
                                letterSpacing: 0.5,
                                color: whiteColor,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 65.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 37.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdmineRowWidget(
                              controller:
                                  widget.model!.otherAdminemailController,
                              title: "Email/Use Name",
                              hintText: "paulfrye@gmail.com",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 46.h,
                            ),
                            AdmineRowWidget(
                              controller:
                                  widget.model!.otherAdminpasswordController,
                              title: "Password",
                              hintText: "********",
                            ),
                            SizedBox(
                              height: 46.h,
                            ),
                            AdmineRowWidget(
                              controller:
                                  widget.model!.otherAdminnameController,
                              title: "Full Name",
                              hintText: "Paul Frye",
                            ),
                            SizedBox(
                              height: 46.h,
                            ),
                            AdmineRowWidget(
                              controller:
                                  widget.model!.otherAdmintitleController,
                              title: "Title",
                              hintText: "Sub-Administrator",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 145.h,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (validation()) {
                              if (selectText == "Add") {
                                widget.model!.addOtherAdmin();
                                Navigator.pop(context);
                              } else if (selectText == "Edit") {
                                widget.model!.updateOtherAdmin();
                                Navigator.pop(context);
                              }
                              print(widget.model!.selectText.toString());
                            }
                          },
                          child: Container(
                            height: 70.h,
                            width: 307.w,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              widget.model!.selectText.toString(),
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: whiteColor,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  validation() {
    if (widget.model!.otherAdminemailController.text.isEmpty &&
        widget.model!.otherAdminpasswordController.text.isEmpty &&
        widget.model!.otherAdminnameController.text.isEmpty &&
        widget.model!.otherAdmintitleController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

class OtherAdminModel {
  String? name;
  OtherAdminModel({this.name});
}

//

class AdmineRowWidget extends StatelessWidget {
  AdmineRowWidget({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.validator,
  });
  String? title;
  String? hintText;
  TextEditingController? controller;
  Function(String)? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        addHorizontalSpace(30.w),
        Container(
          width: 150.w,
          alignment: Alignment.centerLeft,
          child: Text(
            title!,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 25.sp,
              letterSpacing: 0.5,
              color: greyColor.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 400.w,
          height: 65.h,
          child: TextFormField(
            validator: (value) => validator!(value!),
            controller: controller,
            // enabled: widget.selected,
            // maxLines: 5,
            cursorColor: secondaryColor,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor.withOpacity(0.4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor.withOpacity(0.4)),
              ),

              contentPadding: EdgeInsets.only(left: 10.w, top: 5.h),
              // suffixIcon: Icon(
              //   Icons.edit,
              //   color: secondaryColor,
              //   size: 25.sp,
              // ),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(
                color: secondaryColor.withOpacity(0.5),
                fontSize: 25.sp,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
        Spacer(),
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       widget.selected = !widget.selected;
        //       print(widget.selected);
        //     });
        //   },
        //   child: Icon(
        //     Icons.edit,
        //     color: secondaryColor,
        //     size: 25.sp,
        //   ),
        // ),

        addHorizontalSpace(20.w),
      ],
    );
  }
}
