import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/service_screen_listview.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/service_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/flutter_toast.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

BuildContext? contxt;

class ServicesScreen extends StatefulWidget {
  ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  bool selected = false;
  bool check = false;
  String searchServiceName = '';
  @override
  Widget build(BuildContext context) {
    // final serviceModel = Provider.of<ServiceViewModel>(context, listen: false);
    // serviceModel.clearSelectedData();
    return ChangeNotifierProvider(
      create: (context) => ServiceViewModel(),
      child: Consumer<ServiceViewModel>(
        builder: (context, model, child) => Scaffold(
          body: Column(
            children: [
              addVerticalSpace(60.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  addHorizontalSpace(20.w),
                  Text(
                    "SERVICES",
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
                      // controller: model.serviceController,
                      onChanged: (value) {
                        setState(() {
                          searchServiceName = value;
                        });
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
                          color: blackColor.withOpacity(0.6),
                          fontSize: 25.sp,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  addHorizontalSpace(20.w),

                  // Add Iamge in top bar right corner
                  GestureDetector(
                    onTap: () {
                      model.removeDuplicates();
                      model.getServiceData();
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0)), //this right here
                                child: Container(
                                  height: 580.h,
                                  width: 634.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 70.h,
                                        width: 634.w,
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("ADD SERVICE ",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 30.sp,
                                                color: whiteColor,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 60.h,
                                                  width: 518.w,
                                                  child: TextFormField(
                                                    controller:
                                                        model.serviceName,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Enter Service Here",
                                                      hintStyle: TextStyle(
                                                        color: secondaryColor
                                                            .withOpacity(0.5),
                                                        fontSize: 20.sp,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: secondaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 23.w,
                                                              top: 14.h),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: secondaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 10.w),
                                            SizedBox(
                                              height: 35,
                                              width: 35,
                                            )
                                          ],
                                        ),
                                      ),
                                      addVerticalSpace(20),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 60.h,
                                                  width: 518.w,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        model.serviceLevel,
                                                    decoration: InputDecoration(
                                                      suffixIcon:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          items: model
                                                              .serviceList
                                                              .map((e) => e
                                                                  .serviceProviderName)
                                                              .map((String
                                                                      item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child: Text(
                                                                      item,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20.sp,
                                                                      ),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            model
                                                                .removeDuplicates();
                                                            int selectedIndex = model
                                                                .serviceList
                                                                .indexOf(model
                                                                    .serviceList
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .serviceProviderName ==
                                                                        value));
                                                            model.selecValues(
                                                                value!,
                                                                selectedIndex);
                                                          },
                                                          buttonStyleData:
                                                              const ButtonStyleData(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            height: 40,
                                                            width: 140,
                                                          ),
                                                          menuItemStyleData:
                                                              const MenuItemStyleData(
                                                            height: 40,
                                                          ),
                                                        ),
                                                      ),
                                                      hintText:
                                                          "Service Provider’s Name",
                                                      hintStyle: TextStyle(
                                                        color: secondaryColor
                                                            .withOpacity(0.5),
                                                        fontSize: 20.sp,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: secondaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 23.w,
                                                              top: 14.h),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: secondaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 10.w),
                                            GestureDetector(
                                              onTap: () {
                                                model.clearControllers();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.r)),
                                                              child: Container(
                                                                height: 580.h,
                                                                width: 634.w,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <Widget>[
                                                                    Container(
                                                                      height:
                                                                          70.h,
                                                                      width:
                                                                          634.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(12.r),
                                                                          topRight:
                                                                              Radius.circular(12.r),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            "ADD SERVICE PROVIDER",
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                              fontSize: 30.sp,
                                                                              color: whiteColor,
                                                                              letterSpacing: 0.5,
                                                                              fontWeight: FontWeight.w700,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            40.h),
                                                                    addVerticalSpace(
                                                                        20),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              20.w),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 60.h,
                                                                                width: 518.w,
                                                                                child: TextFormField(
                                                                                  controller: model.serviceProviderName,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: "Service Provider’s Name",
                                                                                    hintStyle: TextStyle(
                                                                                      color: secondaryColor.withOpacity(0.5),
                                                                                      fontSize: 20.sp,
                                                                                      letterSpacing: 0.5,
                                                                                      fontWeight: FontWeight.w700,
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: secondaryColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                    ),
                                                                                    contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: secondaryColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    addVerticalSpace(
                                                                        20),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              37.w),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                60.h,
                                                                            width:
                                                                                513,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: model.serviceProviderEmail,
                                                                              decoration: InputDecoration(
                                                                                hintText: "Service Provider’s Email",
                                                                                hintStyle: TextStyle(
                                                                                  color: secondaryColor.withOpacity(0.5),
                                                                                  fontSize: 20.sp,
                                                                                  letterSpacing: 0.5,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: secondaryColor,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                ),
                                                                                contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: secondaryColor,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    addVerticalSpace(
                                                                        20),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              37.w),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                60.h,
                                                                            width:
                                                                                513,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: model.serviceProviderPhone,
                                                                              decoration: InputDecoration(
                                                                                hintText: "Service Provider’s Phone NO.",
                                                                                hintStyle: TextStyle(
                                                                                  color: secondaryColor.withOpacity(0.5),
                                                                                  fontSize: 20.sp,
                                                                                  letterSpacing: 0.5,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: secondaryColor,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                ),
                                                                                contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: secondaryColor,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            50.h),
                                                                    Center(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (model.serviceProviderName.text.isEmpty &&
                                                                              model.serviceProviderEmail.text.isEmpty &&
                                                                              model.serviceProviderPhone.text.isEmpty) {
                                                                            FlutterTost.customToast("Please Enter Service Provider Name, Email and Phone No.");
                                                                            return;
                                                                          }
                                                                          model.serviceLevel.text = model
                                                                              .serviceProviderName
                                                                              .text;
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              212.w,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                secondaryColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child: Center(
                                                                              child: Text(
                                                                            "Add",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 30.sp,
                                                                              color: whiteColor,
                                                                              letterSpacing: 0.5,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          )),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              },

                                              /// inside the add button in the adding service dialog
                                              child: Image.asset(
                                                "assets/images/add.png",
                                                height: 35,
                                                width: 35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      addVerticalSpace(20),
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            var a = model.serviceLevel.text;
                                            var b = "Select Service Level";
                                            if (model
                                                .serviceName.text.isEmpty) {
                                              FlutterTost.customToast(
                                                  "Please Enter Service Name");
                                              return;
                                            }
                                            if (a == b) {
                                              FlutterTost.customToast(
                                                  "Please Select Service Level");
                                              return;
                                            }

                                            model.addService(
                                                model.serviceName.text,
                                                model.serviceProviderEmail.text,
                                                model.serviceProviderPhone.text,
                                                model.serviceProviderName.text);
                                            Navigator.pop(context);
                                            Get.off(() => ServicesScreen());
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: 212.w,
                                            decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Save",
                                              style: TextStyle(
                                                fontSize: 30.sp,
                                                color: whiteColor,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Image.asset(
                      "assets/images/add.png",
                      height: 35,
                      width: 35,
                    ),
                  ),

                  addHorizontalSpace(10.w),
                  // Person Icon in top bar right corner
                  GestureDetector(
                    onTap: () {
                      model.getServiceData();
                      model.removeDuplicates();
                      showDialog(
                          context: context,
                          builder: (context) {
                            contxt = context;
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Container(
                                height: 580.h,
                                width: 634.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 80.h,
                                      width: 634.w,
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text("Service Providers",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 30.sp,
                                              color: whiteColor,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                    ),
                                    SizedBox(height: 40.h),
                                    Expanded(
                                      child: ListView.builder(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          scrollDirection: Axis.vertical,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: model.serviceList.length,
                                          itemBuilder: (context, index) {
                                            log('this is my index here: $index');
                                            return Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 37.w,
                                                    vertical: 10.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 60.h,
                                                      width: 513,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        controller:
                                                            TextEditingController(
                                                                text: model
                                                                    .serviceList[
                                                                        index]
                                                                    .serviceProviderName),
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon: SizedBox(
                                                            width: 80.w,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                //! this is the edit icon;
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    model
                                                                        .getServiceData();
                                                                    model.assigneOldData(
                                                                        index);
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            Dialog(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                                                              child: Container(
                                                                                height: 580.h,
                                                                                width: 634.w,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      height: 70.h,
                                                                                      width: 634.w,
                                                                                      decoration: BoxDecoration(
                                                                                        color: secondaryColor,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(12.0),
                                                                                          topRight: Radius.circular(12.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Center(
                                                                                        child: Text("ADD SERVICE",
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              fontSize: 30.sp,
                                                                                              color: whiteColor,
                                                                                              letterSpacing: 0.5,
                                                                                              fontWeight: FontWeight.w700,
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(height: 40.h),
                                                                                    addVerticalSpace(20),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Column(
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                height: 60.h,
                                                                                                width: 518.w,
                                                                                                child: TextFormField(
                                                                                                  controller: model.serviceProviderNameEdit,
                                                                                                  decoration: InputDecoration(
                                                                                                    hintText: "Service Provider’s Name",
                                                                                                    hintStyle: TextStyle(
                                                                                                      color: secondaryColor.withOpacity(0.5),
                                                                                                      fontSize: 20.sp,
                                                                                                      letterSpacing: 0.5,
                                                                                                      fontWeight: FontWeight.w700,
                                                                                                    ),
                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: secondaryColor,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                                    ),
                                                                                                    contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: secondaryColor,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    addVerticalSpace(20),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 37.w),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            height: 60.h,
                                                                                            width: 513,
                                                                                            child: TextFormField(
                                                                                              controller: model.serviceProviderEmailEdit,
                                                                                              decoration: InputDecoration(
                                                                                                hintText: "Service Provider’s Email",
                                                                                                hintStyle: TextStyle(
                                                                                                  color: secondaryColor.withOpacity(0.5),
                                                                                                  fontSize: 20.sp,
                                                                                                  letterSpacing: 0.5,
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: secondaryColor,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                                ),
                                                                                                contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: secondaryColor,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    addVerticalSpace(20),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 37.w),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            height: 60.h,
                                                                                            width: 513,
                                                                                            child: TextFormField(
                                                                                              controller: model.serviceProviderPhoneEdit,
                                                                                              decoration: InputDecoration(
                                                                                                hintText: "Service Provider’s Phone NO.",
                                                                                                hintStyle: TextStyle(
                                                                                                  color: secondaryColor.withOpacity(0.5),
                                                                                                  fontSize: 20.sp,
                                                                                                  letterSpacing: 0.5,
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: secondaryColor,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                                ),
                                                                                                contentPadding: EdgeInsets.only(left: 23.w, top: 14.h),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: secondaryColor,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(height: 50.h),
                                                                                    Center(
                                                                                      child: GestureDetector(
                                                                                        onTap: () async {
                                                                                          await model.updateDAta(model.serviceList[index].serviceProviderName);
                                                                                          Navigator.pop(contxt!);
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 50.h,
                                                                                          width: 212.w,
                                                                                          decoration: BoxDecoration(
                                                                                            color: secondaryColor,
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            "Edit",
                                                                                            style: TextStyle(
                                                                                              fontSize: 30.sp,
                                                                                              color: whiteColor,
                                                                                              letterSpacing: 0.5,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ));
                                                                  },
                                                                  child: Icon(
                                                                    Icons.edit,
                                                                    color:
                                                                        secondaryColor,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  //! this is the delete icons;
                                                                  onTap: () {
                                                                    model.deleteServiceNme(model
                                                                        .serviceList[
                                                                            index]
                                                                        .serviceProviderName);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color:
                                                                        secondaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          hintText:
                                                              "Enter Service Here",
                                                          hintStyle: TextStyle(
                                                            color: secondaryColor
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 20.sp,
                                                            letterSpacing: 0.5,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  secondaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 23.w,
                                                                  top: 14.h),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  secondaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 55.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.person,
                        color: whiteColor,
                        size: 30.sp,
                      )),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(10.sp),
              Divider(
                color: blackColor.withOpacity(0.2),
                thickness: 1.sp,
                height: 0,
              ),
              // addVerticalSpace(30.h),
              Padding(
                padding: EdgeInsets.only(left: 30.sp, right: 20.sp),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.826,
                  child: StreamBuilder(
                    stream: model.databaseService.serviceDB.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text(""),
                        );
                      } else if (snapshot.data!.docs.length > 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<QueryDocumentSnapshot> service =
                                snapshot.data!.docs;

                            service.sort((a, b) =>
                                (a['Service name'].toString().toLowerCase())
                                    .compareTo(
                                  b['Service name'].toString().toLowerCase(),
                                ));

                            if (searchServiceName.isEmpty) {
                              return ServiceScreenListView(
                                index: index,
                                service: service[index],
                              );
                            } else if (service[index]['Service name']
                                .toString()
                                .toLowerCase()
                                .contains(searchServiceName.toLowerCase())) {
                              return ServiceScreenListView(
                                index: index,
                                service: service[index],
                              );
                            }
                            return Container();
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
      ),
    );
  }
}

class CustomSiteText extends StatelessWidget {
  final String text;
  final double width;
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
  final String text;
  final double width;
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
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          fontFamily: "Sofia",
        ),
      ),
    );
  }
}
