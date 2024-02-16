import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/Model/contactModel.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/helper_widgets.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/numbersScreen/number_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/numbersScreen/widget/ContactDilogBox.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/flutter_toast.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  DatabaseService databaseService = DatabaseService();

  void updateCompanyCalls(PhoneNumb phoneNumb, bool isDelete) async {
    try {
      await databaseService.companycalls.doc('phoneNumber').set({
        'detalis': FieldValue.arrayUnion([
          {
            'name': phoneNumb.name,
            'phone': phoneNumb.phone,
          }
        ]),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating companycalls: $e");
      throw e;
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3)}';
  }

  // void rmCont(int index, List<PhoneNumb> phoneNumb) {
  //   phoneNumb.removeAt(index);
  //   updateCompanyCalls(phoneNumb, false);
  //   setState(() {});
  //   Navigator.pop(context);
  // }

  String contactNum = '';
  // List<String> filteredList = [];
  List<String> phoNumber = [];
  List<String> name = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    log('build');
    return ChangeNotifierProvider(
        create: (context) => NumberModel(),
        child: Consumer<NumberModel>(
          builder: (context, model, child) {
            return Scaffold(
              body: Column(
                children: [
                  addVerticalSpace(40.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      addHorizontalSpace(30.w),
                      Text(
                        "ADD CONTACTS",
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
                            contactNum = value;
                            model.searchQuer(value);
                            if (value.isEmpty) {
                              model.isSearch = false;
                            } else {
                              model.isSearch = true;
                            }
                            setState(() {});
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
                            contentPadding:
                                EdgeInsets.only(left: 23.w, top: 14.h),
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => ContactAlertDilogBox(
                              onAdd: (val) {
                                PhoneNumb phoneNumb = PhoneNumb();
                                if (RegExp(r'[a-zA-Z]').hasMatch(val[0])) {
                                  FlutterTost.customToast(
                                      "Only Numbers are allowed");
                                  return;
                                }
                                if (val.isEmpty) return;
                                phoneNumb.phone = val[0];
                                phoneNumb.name = val[1];
                                updateCompanyCalls(phoneNumb, true);
                                model.getnames();
                              },
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/images/add.png",
                          height: 35,
                          width: 35,
                        ),
                      ),
                      addVerticalSpace(40.sp),
                    ],
                  ),
                  addVerticalSpace(20.sp),
                  Divider(
                    color: blackColor.withOpacity(0.2),
                    thickness: 1.sp,
                    height: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.sp, right: 20.sp),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: StreamBuilder(
                        stream: databaseService.companycalls.snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: Text(""));
                          } else if (snapshot.hasData) {
                            List phoNum = snapshot.data!.docs[0]['detalis'];
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 20.h),
                              itemCount: !model.isSearch
                                  ? phoNum.length
                                  : model.searchList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (contactNum.isEmpty) {
                                  return Container(
                                    // height: 80.h,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: blackColor.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(15.w),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${phoNum[index]['name']} (${formatPhoneNumber(phoNum[index]['phone'])})',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            letterSpacing: 0.5,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Sofia",
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              // show the dilog box
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Are you sure you want to delete this number?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('No')),
                                                        TextButton(
                                                            onPressed: () {
                                                              model
                                                                  .removeItemFromJobList(
                                                                      index);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('Yes')),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.delete))
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: blackColor.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(15.w),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${model.searchList[index]['name']} (${formatPhoneNumber(model.searchList[index]['phone']!)})',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            letterSpacing: 0.5,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Sofia",
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              // show the dilog box
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Are you sure you want to delete this number?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('No')),
                                                        TextButton(
                                                            onPressed: () {
                                                              // rmCont(
                                                              //   index,
                                                              //   phoNum,
                                                              //   ['asim'],
                                                              // );
                                                            },
                                                            child: Text('Yes')),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.delete))
                                      ],
                                    ),
                                  );
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
                ],
              ),
            );
          },
        ));
  }
}
