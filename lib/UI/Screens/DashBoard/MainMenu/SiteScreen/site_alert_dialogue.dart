import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

class SiteAlertDialogue extends StatefulWidget {
  const SiteAlertDialogue({super.key});

  @override
  State<SiteAlertDialogue> createState() => _SiteAlertDialogueState();
}

class _SiteAlertDialogueState extends State<SiteAlertDialogue> {
  TextEditingController siteNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SiteViewmodel>(
      builder: (context, model, child) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.sp),
          ),
        ),
        child: Container(
          width: 500.w,
          height: 400.h,
          child: Column(
            children: [
              Container(
                width: 630.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.sp),
                    topRight: Radius.circular(32.sp),
                  ),
                ),
                child: Center(
                  child: Text(
                    "ADD SITE",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 27.sp,
                      color: whiteColor,
                      letterSpacing: 0.5,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              addVerticalSpace(60.h),
              SizedBox(
                height: 53.h,
                width: 400.w,
                child: TextField(
                  controller: siteNameController,
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    contentPadding: EdgeInsets.only(left: 23.w, bottom: 10.h),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      color: blackColor.withOpacity(0.5),
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: "Enter Site Here",
                    border: InputBorder.none,
                  ),
                ),
              ),
              addVerticalSpace(100.h),
              GestureDetector(
                onTap: () {
                  if (siteNameController.text.isNotEmpty) {
                    model.addSite(siteNameController.text.trim());
                    siteNameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: CustomContainer(
                  width: 150.w,
                  height: 60.h,
                  boarderRadius: 17.sp,
                  widget: Center(
                    child: Text(
                      "Add",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25.sp,
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
