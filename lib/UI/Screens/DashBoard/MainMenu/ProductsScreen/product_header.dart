import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/product_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';

class ProductHeader extends StatefulWidget {
  const ProductHeader({super.key});

  @override
  State<ProductHeader> createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  TextEditingController productController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context, listen: true);
    return Consumer<ProductViewModel>(
      builder: (context, model, child) => Column(
        children: [
          addVerticalSpace(60.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addHorizontalSpace(10.w),
              Text(
                "PRODUCTS",
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
                    model.searchProductByName(value);
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
                      borderRadius: BorderRadius.circular(25.sp),
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
                      color: blackColor.withOpacity(0.5),
                      fontSize: 25.sp,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                ),
              ),
              addHorizontalSpace(40.w),
            ],
          ),
          addVerticalSpace(50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  orderProvider.setOrderScreen(1);
                  print(",,,,,,,,,,,,,,,,");
                },
                child: CustomContainer(
                  width: 218.w,
                  height: 70.h,
                  color: secondaryColor,
                  boarderRadius: 17.r,
                  widget: Center(
                    child: Text(
                      "SEE ORDERS",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: whiteColor,
                        letterSpacing: 0.5,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              addHorizontalSpace(20.w),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0)), //this right here
                            child: Container(
                              height: 400.h,
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
                                      child: Text("IMPORT PRODUCT",
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 37.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 52.h,
                                          width: 300,
                                          child: TextFormField(
                                            controller: productController,
                                            decoration: InputDecoration(
                                              hintText: "Enter Shopify Link",
                                              hintStyle: TextStyle(
                                                color: secondaryColor
                                                    .withOpacity(0.5),
                                                fontSize: 20.sp,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: secondaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Image.asset(
                                                  "assets/images/dollar.png",
                                                  height: 40.h,
                                                  width: 40.w,
                                                ),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  left: 23.w, top: 14.h),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: secondaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                          ),
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
                                        if (productController.text.isNotEmpty) {
                                          model.addProduct();
                                          productController.clear();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        height: 60.h,
                                        width: 212.w,
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Import",
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
                child: CustomContainer(
                  width: 218.w,
                  height: 70.h,
                  color: secondaryColor,
                  boarderRadius: 17.r,
                  widget: Center(
                    child: Text(
                      "IMPORT PRODUCT",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 0.5,
                        color: whiteColor,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              addHorizontalSpace(25.w),
            ],
          ),
        ],
      ),
    );
  }
}
