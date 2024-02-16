import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ContactScreen/contactScreen_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ContactScreen/contact_list_view.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ContactScreen/header.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(60.h),
            ContactScreenHeaderWidget(),
            addVerticalSpace(10.h),
            Divider(
              color: blackColor.withOpacity(0.2),
              thickness: 1.sp,
              height: 0,
            ),
            // ContactListView(),
            Stack(
              children: [
                Container(
                  height: 850.h,
                  width: 1290.w,
                  child: ContactListView(),
                ),
                model.isSearch
                    ? Container(
                        margin: EdgeInsets.only(left: 40.w),
                        width: 1050.w,
                        height: 600.h,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: blackColor.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                          shrinkWrap: true,
                          itemCount: filteredContactList.length,
                          itemBuilder: (context, index) {
                            var data = filteredContactList[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: InkWell(
                                onTap: () {
                                  model.nameController.text = data.name!;
                                  model.jobTitleController.text = '';
                                  model.emailController.text = data.email!;
                                  model.phonController.text = data.phone!;
                                  model.companyController.text =
                                      data.companyName!;
                                  model.isSearch = false;
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Adjust the Text widgets based on your data structure
                                        Container(
                                          width: 200.w,
                                          child: Text(
                                            data.name!,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200.w,
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200.w,
                                          child: Text(
                                            data.companyName!,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200.w,
                                          child: Text(
                                            data.phone!,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200.w,
                                          child: Text(
                                            data.email!,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    /*StreamBuilder(
                        stream: model
                            .contactStream, // Replace with your actual stream
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child:
                                    CircularProgressIndicator()); // or some other loading indicator
                          }
                          List<Map<String, dynamic>> dataList = snapshot
                              .data!.docs
                              .map((doc) => doc.data())
                              .toList();

                          return Container(
                            margin: EdgeInsets.only(left: 40.w),
                            width: 1050.w,
                            color: greyColor,
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              shrinkWrap: true,
                              itemCount: dataList.length,
                              //  < 10 ? dataList.length : 10,
                              itemBuilder: (context, index) {
                                var data = dataList[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Adjust the Text widgets based on your data structure
                                      Container(
                                        width: 100.w,
                                        color: Colors.red,
                                        child: Text(
                                          data['Name'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        color: Colors.red,
                                        child: Text(
                                          'Job Title',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        color: Colors.red,
                                        child: Text(
                                          data['Associated Company'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        color: Colors.red,
                                        child: Text(
                                          data['Phone Number'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        color: Colors.red,
                                        child: Text(
                                          data['Email'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        
                          );
                        },
                      )
                   */
                    : SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// DatabaseService databaseService = DatabaseService();
