import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/dashboard.dart';
import 'package:rhinoapp/UI/Screens/LoginScreen/login_viewmodel.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences? prefs;
  bool? isloding = false;

  didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs!.getBool('isLogin') ?? false;

    setState(() {
      isloding = true;
    });

    //get chat id
    getChatId();

    Future.delayed(Duration(seconds: 2), () {
      if (isLogin) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashBoardScreen()));
      } else {
        setState(() {
          isloding = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewmodel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: isloding!
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      children: [
                        addVerticalSpace(20.sp),
                        Row(
                          children: [
                            addHorizontalSpace(20.sp),
                            Text(
                              "Welcome !",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 30.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        addVerticalSpace(20.h),
                        Image.asset(
                          "assets/images/logo.png",
                          width: 200.w,
                          height: 80,
                        ),
                        addVerticalSpace(40.h),
                        Container(
                          height: 800.h,
                          width: 600.w,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(72.r),
                              topRight: Radius.circular(72.r),
                              bottomLeft: Radius.circular(72.r),
                              bottomRight: Radius.circular(72.r),
                            ),
                            boxShadow: shadow,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 450.w,
                                child: TextFormField(
                                  controller: model.emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: greyColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    fillColor: lightGreyColor,
                                    filled: true,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    contentPadding:
                                        EdgeInsets.only(left: 30.sp),
                                  ),
                                ),
                              ),
                              addVerticalSpace(50.h),
                              SizedBox(
                                height: 50,
                                width: 450.w,
                                child: TextFormField(
                                  controller: model.passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: greyColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    fillColor: lightGreyColor,
                                    filled: true,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    contentPadding:
                                        EdgeInsets.only(left: 30.sp),
                                  ),
                                ),
                              ),
                              addVerticalSpace(30.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Forget Password",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: redColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  addHorizontalSpace(90.w)
                                ],
                              ),
                              addVerticalSpace(25.h),
                              GestureDetector(
                                onTap: () async {
                                  model.checkAdmin(context);
                                  // if (await model.checkAdmin()) {

                                  // } else {
                                  //   print("Admin not exist");
                                  // }
                                },
                                child: CustomContainer(
                                  width: 450.w,
                                  height: 82.h,
                                  boarderRadius: 15.r,
                                  widget: Center(
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
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
