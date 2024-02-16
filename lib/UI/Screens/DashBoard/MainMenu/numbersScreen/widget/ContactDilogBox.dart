import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

class ContactAlertDilogBox extends StatefulWidget {
  final Function(List<String>)? onAdd;
  const ContactAlertDilogBox({super.key, required this.onAdd});

  @override
  State<ContactAlertDilogBox> createState() => _ContactAlertDilogBoxState();
}

class _ContactAlertDilogBoxState extends State<ContactAlertDilogBox> {
  Future<String>? validatePhoneNumber(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return 'Please enter a valid phone number';
    }
    return '';
  }

  TextEditingController addContactController = TextEditingController();
  String contact = '';
  String name = '';
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
          height: 500.h,
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
                    "Add Contact",
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
              Container(
                width: 400.w,
                // height: 50,
                child: Column(
                  children: [
                    IntlPhoneField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        labelText: 'Enter Contact Here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                      initialCountryCode:
                          'AU', // Initial country code, optional
                      onChanged: (phone) {
                        setState(() {
                          contact = phone.completeNumber;
                        });
                      },
                      validator: (val) {
                        validatePhoneNumber(contact);
                        return null;
                      },
                    ),
                    addVerticalSpace(20.h),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      cursorColor: secondaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        hintText: "Enter Name Here",
                        hintStyle: TextStyle(
                          fontSize: 25.sp,
                          color: secondaryColor.withOpacity(0.5),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(50.h),
              GestureDetector(
                onTap: () {
                  if (widget.onAdd != null) {
                    widget.onAdd!([contact, name]);
                  }
                  Navigator.pop(
                      context); // Close the dialog after adding contact
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
