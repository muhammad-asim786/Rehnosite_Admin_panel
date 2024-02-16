// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/helper_widgets.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/admins/other_admin_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/profile_header.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/profile_row_widget.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/profile_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/LoginScreen/login_screen.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  bool selected = false;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String dropdownvalue = 'English';

  // List of items in our dropdown menu
  var items = [
    'Urdu',
    'Persian',
    'English',
    'Spanish',
    'Arabic',
  ];
  int value = 0;

  changeWidget(int value) {
    setState(() {
      this.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('i am called by many time which you want');
    final provider = Provider.of<SideBarCount>(context, listen: true);
    return ChangeNotifierProvider(
      create: (context) => ProfileViewmodel(),
      child: Consumer<ProfileViewmodel>(
        builder: (context, model, child) => SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: model.isLoaidng
                  ? Center(child: LinearProgressIndicator())
                  : Column(
                      children: [
                        ProfileHeader(
                          model: model,
                        ),
                        addVerticalSpace(26.h),
                        Row(
                          children: [
                            addHorizontalSpace(25.w),
                            GestureDetector(
                              onTap: () {
                                changeWidget(0);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "My Account",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                      letterSpacing: 0.5,
                                      color: value == 0
                                          ? secondaryColor
                                          : secondaryColor.withOpacity(0.6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  addVerticalSpace(3.h),
                                  Container(
                                    height: 3.h,
                                    width: 150.w,
                                    color: value == 0
                                        ? secondaryColor
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 85.w,
                            ),
                            model.isSuperAdmin
                                ? GestureDetector(
                                    onTap: () {
                                      changeWidget(1);
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          "Other Admins",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 40.sp,
                                            letterSpacing: 0.5,
                                            color: value == 1
                                                ? secondaryColor
                                                : secondaryColor
                                                    .withOpacity(0.6),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        addVerticalSpace(3.h),
                                        Container(
                                          height: 3.h,
                                          width: 150.w,
                                          color: value == 1
                                              ? secondaryColor
                                              : Colors.transparent,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        addVerticalSpace(60.h),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: value == 1
                              ? OtherAdminScreen(
                                  model: model,
                                )
                              : Column(
                                  children: [
                                    ProfileRowWidget(
                                      controller: model.emailController,
                                      title: "Email/User Name",
                                      hint: "jadaholder@gmail.com",
                                      selected: widget.selected,
                                    ),
                                    addVerticalSpace(60.h),
                                    ProfileRowWidget(
                                      obsecureText: true,
                                      controller: model.passwordController,
                                      title: "Password",
                                      hint: "***********",
                                      selected: widget.selected1,
                                    ),
                                    addVerticalSpace(60.h),
                                    ProfileRowWidget(
                                      controller: model.nameController,
                                      title: "Full Name",
                                      hint: "Jada Holder",
                                      selected: widget.selected2,
                                    ),
                                    addVerticalSpace(60.h),
                                    ProfileRowWidget(
                                      controller: model.titleController,
                                      title: "Title",
                                      hint: "Administrator",
                                      selected: widget.selected3,
                                    ),
                                    addVerticalSpace(60.h),
                                    Row(
                                      children: [
                                        addHorizontalSpace(30.w),
                                        Container(
                                          width: 200.w,
                                          //alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Language",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 30.sp,
                                              letterSpacing: 0.5,
                                              color: greyColor.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        addHorizontalSpace(20.w),
                                        CustomContainer(
                                          height: 60.h,
                                          width: 400.w,
                                          boarderRadius: 0.r,
                                          color: whiteColor,
                                          borderColor:
                                              secondaryColor.withOpacity(0.4),
                                          widget: Container(
                                            width: 400.w,
                                            height: 50.h,
                                            child: Container(
                                              width: 400.w,
                                              child: DropdownButton(
                                                underline: SizedBox(),
                                                isExpanded: true,

                                                // Initial Value
                                                value: dropdownvalue,
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 25,
                                                ),

                                                // Array list of items
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownvalue = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: TextButton(
                                          onPressed: () {
                                            model.saveOtherAdmin();
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 25.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    addVerticalSpace(40.h),
                                    Row(
                                      children: [
                                        Text(''),
                                        addHorizontalSpace(245.w),
                                        GestureDetector(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.clear();
                                            provider.setIndex(1);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ),
                                            );
                                          },
                                          child: CustomContainer(
                                            width: 410.w,
                                            height: 82.h,
                                            boarderRadius: 15.sp,
                                            widget: Center(
                                              child: Text(
                                                "LOGOUT",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 30.sp,
                                                  color: whiteColor,
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
