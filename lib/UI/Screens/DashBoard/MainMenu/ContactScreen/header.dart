import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_text_field.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ContactScreen/contactScreen_viewmodel.dart';

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';

class ContactScreenHeaderWidget extends StatelessWidget {
  ContactScreenHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, model, child) => Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: model.formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addHorizontalSpace(20.w),
                Text(
                  "CONTACTS",
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
                  child: Container(
                    margin: EdgeInsets.only(right: 50.w),
                    child: TextField(
                      onChanged: (value) {
                        model.searchContact(value);
                      },
                      cursorColor: secondaryColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(30.sp),
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
                            height: 44.h,
                            width: 44.w,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: blackColor.withOpacity(0.5),
                          fontSize: 25.sp,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(30.h),
            Row(
              children: [
                addHorizontalSpace(12.w),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: CustomContainer(
                    boarderRadius: 10,
                    width: 1266.w,
                    height: 80.h,
                    color: secondaryColor,
                    widget: Row(
                      children: [
                        addHorizontalSpace(50.w),
                        Container(
                          width: 200.w,
                          child: Text(
                            "NAME",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              color: whiteColor,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        addHorizontalSpace(10.w),
                        Container(
                          width: 200.w,
                          child: Text(
                            "JOB TITLE",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              color: whiteColor,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 200.w,
                          child: Text(
                            "COMPANY",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              color: whiteColor,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // addHorizontalSpace(20.w),
                        Container(
                          width: 200.w,
                          child: Text(
                            "PHONE",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              color: whiteColor,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        addHorizontalSpace(50.w),
                        Container(
                          width: 300.w,
                          child: Text(
                            "EMAIL",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 0.5,
                              color: whiteColor,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(20.h),
              ],
            ),
            addVerticalSpace(20.h),
            Row(
              children: [
                addHorizontalSpace(14.w),
                Stack(
                  children: [
                    Container(
                      width: 1266.w,
                      height: 63.h,
                      // color: secondaryColor,
                      child: Row(
                        children: [
                          addHorizontalSpace(45.w),
                          CustomTextField2(
                            onChanged: (p0) {
                              model.serachContact(p0);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Name";
                              }
                              return null;
                            },
                            controller: model.nameController,
                            // onChanged: (value) {
                            //   model.contactModel.name = value;
                            // },
                            width: 140.w,
                            height: 80.h,
                            hintText: "Enter Name",
                          ),
                          addHorizontalSpace(70.w),
                          CustomTextField2(
                            onChanged: (value) {},
                            controller: model.jobTitleController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Job Title";
                              }
                              return null;
                            },
                            // onChanged: (value) {
                            //   model.contactModel.jobTitle = value;
                            // },
                            width: 150.w,
                            height: 45.h,
                            hintText: "Enter Job Title",
                          ),
                          addHorizontalSpace(50.w),
                          CustomTextField2(
                            controller: model.companyController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Company";
                              }
                              return null;
                            },
                            // onChanged: (value) {
                            //   // print(value);
                            //   if (value.isEmpty) {
                            //     return "Enter Company";
                            //   }
                            //   return null;

                            // },
                            width: 150.w,
                            height: 45.h,
                            hintText: "Enter Company",
                          ),
                          addHorizontalSpace(50.w),
                          CustomTextField2(
                            onChanged: (value) {},
                            isOnlyNumber: true,
                            textInputType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Phone";
                              }

                              //only take numbers

                              return null;
                            },
                            controller: model.phonController,
                            // onChanged: (value) {
                            //   print(value);
                            //   model.contactModel.phone = value;
                            // },
                            width: 200.w,
                            height: 45.h,
                            hintText: "Enter Phone",
                          ),
                          addHorizontalSpace(50.w),
                          CustomTextField2(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Email";
                              }
                              return null;
                            },
                            controller: model.emailController,
                            // onChanged: (value) {
                            //   // print(value);
                            //   model.contactModel.email = value;
                            // },
                            width: 200.w,
                            height: 45.h,
                            hintText: "Enter Email",
                          ),
                          addHorizontalSpace(130.w),
                          GestureDetector(
                            onTap: () {
                              log('good to here');
                              if (model.nameController.text != "" &&
                                  model.jobTitleController.text != "" &&
                                  model.companyController.text != "" &&
                                  model.phonController.text != "" &&
                                  model.emailController.text != "") {
                                log('i am in if codition here ');
                                model.addContact();
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content:
                                            Text("Please fill all the fields"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ok"))
                                        ],
                                      );
                                    });
                              }
                              // if (model.formKey.currentState!.validate()) {
                              //   model.addContact();
                              // }
                            },
                            child: Image.asset(
                              "assets/icons/add.png",
                              height: 25.h,
                              width: 25.w,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
