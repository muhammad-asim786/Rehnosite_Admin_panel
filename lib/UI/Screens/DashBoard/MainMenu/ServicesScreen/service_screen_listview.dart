// ignore_for_file: must_be_immutable, unused_field

import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/service_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/services_level_listview.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';

class ServiceScreenListView extends StatefulWidget {
  int index;
  DocumentSnapshot? service;
  ServiceScreenListView({required this.index, required this.service});
  @override
  State<ServiceScreenListView> createState() => _ServiceScreenListViewState();
}

class _ServiceScreenListViewState extends State<ServiceScreenListView> {
  bool selected = false;
  bool check = false;
  // create some values
  Color pickerColor = Color(0xffffffff);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback;
  void changeColor(Color color) {
    setState(() => pickerColor = color);

    // print(pickerColor);
  }

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ServiceViewModel>(context);
    // log(widget.service!.id);
    Color color = Color(int.parse(widget.service!['color'].toString()));

    log(color.toString());
    print(color.runtimeType);
    return Column(
      children: [
        addVerticalSpace(20.h),
        CustomContainer(
          height: 80.h,
          //Setting Shadow from here
          choseshadow: true,
          color: color,
          boarderRadius: 16.sp,
          width: double.infinity,
          widget: Row(
            children: [
              addHorizontalSpace(10.w),
              Text(
                widget.service!['Service name'],
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30.sp,
                  letterSpacing: 0.5,
                  color: color == Colors.white ? Colors.black : whiteColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sofia",
                ),
              ),
              addHorizontalSpace(20.w),

              //popUp shown after clicking on provider name in servcies   "N"
              PopupMenuButton(
                padding: EdgeInsets.only(bottom: 20),
                constraints: BoxConstraints(
                  minWidth: 150,
                  minHeight: 15,
                ),
                offset: Offset(-30, 25),
                color: Colors.black,
                child: Text(
                  "(${widget.service!['Service provider name']})",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 30.sp,
                    letterSpacing: 0.5,
                    color: color == Colors.white ? Colors.black : whiteColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sofia",
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      // gmail("jahan665577@gmail.com");
                    },
                    child: Text(
                      widget.service!['Service provider email'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text(widget.service!['Service provider phone'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.sp,
                          letterSpacing: 0.5,
                        )),
                    value: 2,
                  ),
                ],
              ),

              Spacer(),
              addHorizontalSpace(15.w),

              //Color Picker for assigning color "N"
              InkWell(
                // splashColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            model.updateColor(widget.service!.id,
                                pickerColor.toString().substring(6, 16));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Image.asset(
                  "assets/icons/colorpick.png",
                  height: 40.h,
                  color: color == Colors.white ? secondaryColor : whiteColor,
                  width: 40.h,
                ),
              ),

              addHorizontalSpace(15.w),
              GestureDetector(
                onTap: () {
                  model.removeDuplicates();
                  setState(() {
                    model.editingController.text =
                        widget.service!['Service name'];
                    model.nameController.text =
                        widget.service!["Service provider name"];
                    model.emailController.text =
                        widget.service!["Service provider email"];
                    model.phoneController.text =
                        widget.service!["Service provider phone"];
                  });
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Container(
                              height: 600.h,
                              width: 500.w,
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
                                      child: Text("Edit Service",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 30.sp,
                                            letterSpacing: 0.5,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 37.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Service Name",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            letterSpacing: 0.5,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            addVerticalSpace(6.h),
                                            SizedBox(
                                              height: 52.h,
                                              width: 300,
                                              child: TextFormField(
                                                controller:
                                                    model.editingController,
                                                decoration: InputDecoration(
                                                  hintText: "Service Name",
                                                  hintStyle: TextStyle(
                                                    color: secondaryColor
                                                        .withOpacity(0.26),
                                                    fontSize: 20.sp,
                                                    letterSpacing: 0.5,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: secondaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
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
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        addVerticalSpace(20.h),
                                        Text(
                                          "Service Provider’s Name",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            letterSpacing: 0.5,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            addVerticalSpace(6.h),
                                            SizedBox(
                                              height: 52.h,
                                              width: 300,
                                              child: TextFormField(
                                                controller:
                                                    model.nameController,
                                                decoration: InputDecoration(
                                                  //! this is the dropdown button for service provider name for edddi;
                                                  suffixIcon:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton2<String>(
                                                      isExpanded: true,
                                                      items: model.serviceList
                                                          .map((e) => e
                                                              .serviceProviderName)
                                                          .map((String item) =>
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
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .serviceProviderName ==
                                                                        value));
                                                        log('this is my inex $selectedIndex');
                                                        model.editselecValues(
                                                            value!,
                                                            selectedIndex);
                                                      },
                                                      buttonStyleData:
                                                          const ButtonStyleData(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 16),
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
                                                        .withOpacity(0.26),
                                                    fontSize: 20.sp,
                                                    letterSpacing: 0.5,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: secondaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
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
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (model.editingController.text
                                            .isNotEmpty) {
                                          model.updateService(
                                            widget.service!.id,
                                            model.editingController.text,
                                            model.nameController.text.trim(),
                                            model.emailController.text.trim(),
                                            model.phoneController.text.trim(),
                                          );
                                        }
                                        Navigator.pop(context);
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
                                            letterSpacing: 0.5,
                                            color: whiteColor,
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
                  "assets/icons/edit.png",
                  height: 40.h,
                  color: color == Colors.white ? secondaryColor : whiteColor,
                  width: 40.h,
                ),
              ),

              addHorizontalSpace(15.w),

              // Cross btn functionalty for deleting service

              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              "Are You sure you want to delete ${widget.service!["Service name"]} ?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                model.deleteService(widget.service!.id);
                                Navigator.of(context).pop();
                              },
                              child: Text("Yes"),
                            ),
                          ],
                        );
                      });
                  //
                },
                child: Image.asset(
                  "assets/icons/cross.png",
                  height: 40.h,
                  color: color == Colors.white ? redColor : whiteColor,
                  width: 40.h,
                ),
              ),

              addHorizontalSpace(15.w),
              !model.selectedMap.containsKey(widget.index.toString())
                  ? GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   selected = !selected;
                        // });
                        model.selectData(widget.index.toString());
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color:
                            color == Colors.white ? secondaryColor : whiteColor,
                      ),
                    )
                  : Transform.rotate(
                      angle: 90 * math.pi / 180,
                      child: GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   selected = !selected;
                          // });

                          model.selectData(widget.index.toString());
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: color == Colors.white
                              ? secondaryColor
                              : whiteColor,
                        ),
                      ),
                    ),
              addHorizontalSpace(20.w),
            ],
          ),
        ),

        Visibility(
          visible: model.selectedMap.containsKey(widget.index.toString()),
          child: ChemicalToiletService(
            service: widget.service,
          ),
        )
        // Visibility(
        //   visible: selected,
        //   child: Column(
        //     children: [
        //       addVerticalSpace(20.h),
        //       CustomContainer(
        //         height: 350.h,
        //         width: double.infinity,
        //         choseshadow: true,
        //         color: Color(0xffF8F8F8),
        //         widget: ServicesConatainer(),
        //       ),
        //       addVerticalSpace(20.h)
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class ChemicalToiletService extends StatefulWidget {
  DocumentSnapshot? service;
  ChemicalToiletService({super.key, required this.service});

  @override
  State<ChemicalToiletService> createState() => _ChemicalToiletServiceState();
}

class _ChemicalToiletServiceState extends State<ChemicalToiletService> {
  List weekSchedule = [
    'Schedule - Fortnightly',
    'Schedule - Monthly',
    'Schedule - Weekly',
    'Schedule - Wed/Thurs/Friday',
    'Schedule - Mon/Wed/Friday',
    'Schedule - Tues/Friday',
    'Schedule - Tues/Thurs/Friday',
  ];
  @override
  Widget build(BuildContext context) {
    List servicelLevel = widget.service!['service level'];
    print(servicelLevel);
    return Consumer<ServiceViewModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(20.h),
          CustomContainer(
            height: servicelLevel.length == 0
                ? 130.h
                : (40.0 * servicelLevel.length) + 115.h,
            width: double.infinity,
            choseshadow: true,
            color: Color(0xffF8F8F8),
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services Level",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 30.sp,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  addVerticalSpace(20.h),
                  Expanded(
                      child: ListView.builder(
                    itemCount: servicelLevel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          addVerticalSpace(12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Sechedule - ${servicelLevel[index]}",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    model.deleteServiceLevel(widget.service!.id,
                                        servicelLevel[index]);
                                  },
                                  child: CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor: redColor,
                                    child: Icon(
                                      Icons.close,
                                      size: 15,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          addVerticalSpace(12.h),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          )
                        ],
                      );
                    },
                  )),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => ServicesLevelListView(
                            service: widget.service,
                          ),
                        );
                      },
                      child: Icon(Icons.add, size: 20, color: secondaryColor))
                ],
              ),
            ),
          ),
          addVerticalSpace(20.h)
        ],
      ),
    );
  }
}
