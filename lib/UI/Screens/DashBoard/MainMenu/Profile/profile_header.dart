// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/profile_viewmodel.dart';

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';

class ProfileHeader extends StatefulWidget {
  ProfileViewmodel? model;
  ProfileHeader({super.key, required this.model});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
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

      widget.model!.uploadImageToFirebase(image!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(60.h),
        Padding(
          padding: EdgeInsets.only(
            left: 0.w,
          ),
          child: Text(
            "PROFILE",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 50.sp,
              letterSpacing: 0.5,
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        addVerticalSpace(20.h),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                getImage();
                print("kdlklkalkdlk");
              },
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey,
                child: widget.model!.imgeUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          widget.model!.imgeUrl!,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
                      )
                    : image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.memory(
                              image!,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            ),
                          ),
              ),
            ),
            addHorizontalSpace(60.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model!.nameController.text,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 40.sp,
                    letterSpacing: 0.5,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(25.h),
                Row(
                  children: [
                    Text(
                      widget.model!.emailController.text,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 0.5,
                        color: redColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "- ${widget.model!.titleController.text}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 0.5,
                        color: greyColor.withOpacity(0.85),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        addHorizontalSpace(15.w),
      ],
    );
  }
}
