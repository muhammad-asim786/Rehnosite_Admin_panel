// ignore_for_file: must_be_immutable, unnecessary_statements

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

import 'notification_viewmodel.dart';

class NotificationAlerBox extends StatefulWidget {
  String? siteName;
  bool? isSite = false;
  NotificationAlerBox({super.key, this.siteName, this.isSite});

  @override
  State<NotificationAlerBox> createState() => _NotificationAlerBoxState();
}

class _NotificationAlerBoxState extends State<NotificationAlerBox> {
  // TextEditingController siteNameController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  Uint8List? image;

  // get image from gallery
  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        image = result.files.single.bytes;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    //siteNameController.text = widget.siteName == null ? "" : widget.siteName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationViewModel>(context);
    return StatefulBuilder(
      builder: (context, setState) => Dialog(
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.white,
        // shadowColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.sp),
          ),
        ),
        child: Container(
          width: 600.w,
          height: 900.h,
          color: whiteColor,
          // color: redColor,
          child: Column(
            children: [
              Container(
                width: 640.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(32.sp),
                  //   topRight: Radius.circular(32.sp),
                  // ),
                ),
                child: Center(
                  child: Text(
                    "SEND NOTIFICATIONS",
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
              addVerticalSpace(25.h),
              GestureDetector(
                onTap: () async {
                  // get image from gallery
                  await getImage();
                },
                child: CustomContainer(
                  height: 300.h,
                  width: 500.w,
                  boarderRadius: 15.r,
                  color: greyColor.withOpacity(0.2),
                  widget: Center(
                    child: image != null
                        ? Image.memory(
                            image!,
                            height: 300.h,
                            width: 500.w,
                            fit: BoxFit.fitWidth,
                          )
                        : Image.asset(
                            "assets/icons/camera.png",
                            height: 75.h,
                            width: 75.w,
                          ),
                  ),
                ),
              ),
              addVerticalSpace(25.h),
              SizedBox(
                width: 550.w,
                child: TextField(
                  controller: messageController,
                  maxLines: 4,
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    //  contentPadding: EdgeInsets.only(left: 23.w, bottom: 10.h),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      color: blackColor.withOpacity(0.2),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: "Write a message",
                    border: InputBorder.none,
                  ),
                ),
              ),
              addVerticalSpace(40.h),
              widget.isSite!
                  ? Container(
                      height: 60.h,
                      width: 550.w,
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 5.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: secondaryColor,
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.siteName.toString(),
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: blackColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                    )
                  : Container(
                      height: 60.h,
                      width: 550.w,
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 5.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: secondaryColor,
                        ),
                      ),
                      child: DropdownButton(
                        isDense: true,
                        isExpanded: true,
                        value: notificationProvider.selectSiteValue,
                        items:
                            notificationProvider.siteName.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text('Site name'),
                        onChanged: (value) {
                          setState(() {
                            notificationProvider.selectSiteValue =
                                value.toString();
                          });
                        },
                      ),
                    ),
              addVerticalSpace(30.h),
              GestureDetector(
                onTap: () {
                  //check if the text field is empty

                  widget.isSite!
                      ? notificationProvider.selectSiteValue =
                          widget.siteName.toString()
                      : null;

                  if (notificationProvider.selectSiteValue != null &&
                      messageController.text.isNotEmpty) {
                    notificationProvider.sendingNotificationToUser(
                        notificationProvider.selectSiteValue!,
                        messageController.text.trim(),
                        "newFeed",
                        image ?? "");
                    // siteNameController.clear();
                    messageController.clear();
                    Fluttertoast.showToast(
                        msg: "Notification sent successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.black,
                        textColor: whiteColor,
                        webBgColor: "#e74c3c",
                        webPosition: "center",
                        fontSize: 16.0);

                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please fill all the fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        //  webBgColor: "linear-gradient(to right, #ff4b2b, #ff416c)",
                        backgroundColor: Colors.black,
                        textColor: whiteColor,
                        webPosition: "center",
                        fontSize: 16.0);

                    Navigator.pop(context);
                  }
                },
                child: CustomContainer(
                  width: 200.w,
                  height: 70.h,
                  boarderRadius: 17.sp,
                  widget: Center(
                    child: Text(
                      "Send",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: whiteColor,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
