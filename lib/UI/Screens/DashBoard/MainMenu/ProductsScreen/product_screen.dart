// ignore_for_file: must_be_immutable, duplicate_ignore

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/product_header.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/product_viewmodel.dart';

import '../../../../../Utils/colors.dart/colors.dart';
import '../../../../../Utils/helper_widgets.dart';
import '../../../../CustomeWidgets/custom_container.dart';
import '../../../Providers/side_bar_provider.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int value = 0;
  changeValue(int value) {
    setState(() {
      this.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context, listen: true);
    final prodcutProvider =
        Provider.of<ProductViewModel>(context, listen: true);
    print(orderProvider.order);
    return orderProvider.order == 1
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(60.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ORDERS",
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
                        cursorColor: secondaryColor,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: secondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(25.r),
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
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset(
                              "assets/images/search.png",
                              height: 44.h,
                              width: 44.w,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: blackColor.withOpacity(0.5),
                            fontSize: 25.sp,
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
                addVerticalSpace(117.h),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              changeValue(0);
                            },
                            child: Text("All Orders",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontFamily: 'Sofia',
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Container(
                            height: 3.h,
                            width: 80.w,
                            color: value == 0
                                ? secondaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              changeValue(1);
                            },
                            child: Text("Pending Orders",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Sofia',
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Container(
                            height: 3.h,
                            width: 100.w,
                            color: value == 1
                                ? secondaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              changeValue(2);
                            },
                            child: Text("Delivered Orders",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Sofia',
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Container(
                            height: 3.h,
                            width: 100.w,
                            color: value == 2
                                ? secondaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  width: 1300.w,
                  height: 65.h,
                  color: lightGreyColor,
                  widget: Row(
                    children: [
                      addHorizontalSpace(30.w),
                      ProductCustomTextWiget(title: "IMAGE", width: 170),
                      ProductCustomTextWiget(title: " NAME", width: 220),
                      addHorizontalSpace(8.w),
                      ProductCustomTextWiget(title: "Products", width: 220),
                      addHorizontalSpace(40.w),
                      ProductCustomTextWiget(title: "PRICE", width: 200),
                      ProductCustomTextWiget(title: "Date", width: 200),
                      ProductCustomTextWiget(title: "Status", width: 200),
                    ],
                  ),
                ),

                //
                Expanded(
                  child: value == 0
                      ? AllOrderwidget()
                      : value == 1
                          ? PendingWidget()
                          : DeliveredWidget(),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductHeader(),
                addVerticalSpace(30.h),
                CustomContainer(
                  width: 1300.w,
                  height: 65.h,
                  color: lightGreyColor,
                  widget: Row(
                    children: [
                      addHorizontalSpace(30.w),
                      ProductCustomTextWiget(title: "IMAGE", width: 170),
                      ProductCustomTextWiget(title: "ITEM NAME", width: 220),
                      addHorizontalSpace(8.w),
                      ProductCustomTextWiget(title: "PRICE", width: 220),
                      addHorizontalSpace(40.w),
                      ProductCustomTextWiget(title: "DESCRIPTION", width: 400),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream:
                        prodcutProvider.databaseService.productsDB.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = snapshot.data!.docs[index];
                            if (prodcutProvider.searchProduct!.isEmpty) {
                              return Container(
                                width: 1300.w,
                                child: Column(
                                  children: [
                                    addVerticalSpace(20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        addHorizontalSpace(13.w),
                                        Container(
                                          height: 80.h,
                                          width: 220.h,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/p1.png",
                                                height: 80.h,
                                                width: 80.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                        addHorizontalSpace(50.w),
                                        ProductCustomTextWiget2(
                                            title: data['item name'],
                                            width: 220.w),
                                        addHorizontalSpace(46.w),
                                        ProductCustomTextWiget2(
                                          title: '\$${data['price']}',
                                          width: 220.w,
                                        ),
                                        addHorizontalSpace(83.w),
                                        ProductCustomTextWiget2(
                                            title: data['description'],
                                            width: 500),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else if (data["item name"]
                                .toString()
                                .toLowerCase()
                                .contains(prodcutProvider.searchProduct!
                                    .toLowerCase())) {
                              return Container(
                                width: 1300.w,
                                child: Column(
                                  children: [
                                    addVerticalSpace(20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        addHorizontalSpace(13.w),
                                        Container(
                                          height: 80.h,
                                          width: 220.h,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/p1.png",
                                                height: 80.h,
                                                width: 80.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                        addHorizontalSpace(50.w),
                                        ProductCustomTextWiget2(
                                            title: data['item name'],
                                            width: 220.w),
                                        addHorizontalSpace(46.w),
                                        ProductCustomTextWiget2(
                                          title: '\$${data['price']}',
                                          width: 220.w,
                                        ),
                                        addHorizontalSpace(83.w),
                                        ProductCustomTextWiget2(
                                            title: data['description'],
                                            width: 500),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
  }
}

// All order widget

class AllOrderwidget extends StatelessWidget {
  const AllOrderwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Orders")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () async {
                  Map<String, dynamic> order =
                      data.data() as Map<String, dynamic>;

                  List<dynamic> productList = data["products"];
                  log(productList.toString());

                  showDialog(
                    context: context,
                    builder: (context) => ProductDetailsWidget(
                      productList: productList,
                      data: order,
                      docId: (data.id).toString(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHorizontalSpace(25.w),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                AssetImage('assets/images/picture.png'),
                          ),
                          addHorizontalSpace(140.w),
                          SizedBox(
                            height: 50.h,
                            width: 90.w,
                            child: Text(
                              data["contact name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(140.w),
                          SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: Text(
                              data["products"][0]["item name"] +
                                  "${data["products"].length > 1 ? "\n${data["products"].length - 1} more" : ""}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(160.w),
                          SizedBox(
                            height: 50.h,
                            width: 100.w,
                            child: Text(
                              '\$${data["order total price"]}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(100.w),
                          SizedBox(
                            height: 50.h,
                            width: 120.w,
                            child: Text(
                              data["order date"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(80.w),
                          data['status'] == "pending"
                              ? Icon(
                                  Icons.history,
                                  size: 30.sp,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.history,
                                  color: Colors.green,
                                  size: 30.sp,
                                ),
                          addHorizontalSpace(10.w),
                          Text(
                            data['status'].toString()[0].toUpperCase() +
                                data['status'].toString().substring(1),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 30.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Container(
                        height: 1.h,
                        color: secondaryColor.withOpacity(0.2),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class ProductDetailsWidget extends StatelessWidget {
  List<dynamic> productList = [];
  Map<String, dynamic> data = {};
  String? docId;
  ProductDetailsWidget({
    required this.productList,
    required this.data,
    this.docId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductViewModel>(context, listen: false);
    log(productList.toString());
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.sp),
        ),
      ),
      child: Container(
        width: 1000.w,
        height: 1100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(14.sp),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(40.h),
              Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9).withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 70.r,
                          backgroundImage:
                              AssetImage('assets/images/picture.png'),
                        ),
                        addHorizontalSpace(20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(data["contact name"],
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w700,
                                )),
                            addVerticalSpace(10.h),
                            Text(data["contact phone"],
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ],
                    ),
                    addVerticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Site Name: ",
                          style: TextStyle(
                            fontSize: 30.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        addVerticalSpace(30.h),
                        Text(
                          data["contact site"],
                          style: TextStyle(
                            fontSize: 30.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Phone No: ",
                          style: TextStyle(
                            fontSize: 30.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        addVerticalSpace(30.h),
                        Text(
                          data["contact phone"],
                          style: TextStyle(
                            fontSize: 30.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              addVerticalSpace(40.h),

              Text("Products",
                  style: TextStyle(
                    fontSize: 40.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700,
                  )),
              addVerticalSpace(30.h),

              Container(
                height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 190.w,
                        child: Text(
                          "Image",
                          style: TextStyle(
                            fontSize: 25.sp,
                            letterSpacing: 0.5,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                        width: 190.w,
                        child: Text(
                          "ITEM NAME",
                          style: TextStyle(
                            fontSize: 25.sp,
                            letterSpacing: 0.5,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                        width: 190.w,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 25.sp,
                            letterSpacing: 0.5,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                        width: 190.w,
                        child: Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 25.sp,
                            letterSpacing: 0.5,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                        width: 190.w,
                        child: Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 25.sp,
                            letterSpacing: 0.5,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              addVerticalSpace(20.h),
              Container(
                  height: 300.h,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: data["products"].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.sp),
                              child: Image.network(
                                data["products"][index]["item image"],
                                height: 50.h,
                                width: 50.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            addHorizontalSpace(
                              160.w,
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 190.w,
                              child: Text(
                                data["products"][index]["item name"],
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  letterSpacing: 0.5,
                                  color: Color(0xff0E1626),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 190.w,
                              child: Text(
                                data["products"][index]["item quantity"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  letterSpacing: 0.5,
                                  color: Color(0xff0E1626),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 190.w,
                              child: Text(
                                data["order date"].toString(),
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  letterSpacing: 0.5,
                                  color: Color(0xff0E1626),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 180.w,
                              child: Text(
                                data["products"][index]["item total price"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  letterSpacing: 0.5,
                                  color: Color(0xff0E1626),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
              addVerticalSpace(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Total \n\$${data["order total price"]} ",
                      style: TextStyle(
                        fontSize: 35.sp,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
              addVerticalSpace(20.h),
              data["status"] != "pending"
                  ? SizedBox()
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          model.updateTheProductStatus(docId!);
                          Navigator.pop(context);
                        },
                        child: CustomContainer(
                          height: 80.h,
                          width: 548.w,
                          boarderRadius: 10,
                          color: secondaryColor,
                          widget: Center(
                            child: Text("Deliver Now",
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ),
                      ),
                    ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: productList.length,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding:
              //             EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(10.sp),
              //                   child: Image.network(
              //                     productList[index]["item image"],
              //                     height: 250.h,
              //                     width: 200.w,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 addHorizontalSpace(20.w),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Text(productList[index]["item name"],
              //                         style: TextStyle(
              //                             fontSize: 30.sp,
              //                             fontWeight: FontWeight.bold)),
              //                     addVerticalSpace(20.h),
              //                     Container(
              //                       height: 1.h,
              //                       width: 600.w,
              //                       color: secondaryColor.withOpacity(0.2),
              //                     ),
              //                     addVerticalSpace(20.h),
              //                     Text(
              //                         'Quantity: ${productList[index]["item quantity"]}',
              //                         style: TextStyle(
              //                             fontSize: 30.sp,
              //                             fontWeight: FontWeight.w600)),
              //                     addVerticalSpace(20.h),
              //                     Text(
              //                         'Per Product Price: ${productList[index]["item price"]}\$',
              //                         style: TextStyle(
              //                             fontSize: 30.sp,
              //                             fontWeight: FontWeight.w600)),
              //                     addVerticalSpace(20.h),
              //                     Text(
              //                         'Total Price: ${productList[index]["item total price"]}\$',
              //                         style: TextStyle(
              //                             fontSize: 30.sp,
              //                             fontWeight: FontWeight.w600)),
              //                     addVerticalSpace(20.h),
              //                     Container(
              //                       height: 1.h,
              //                       width: 600.w,
              //                       color: secondaryColor.withOpacity(0.2),
              //                     ),
              //                     addVerticalSpace(10.h),
              //                     Container(
              //                       height: 100,
              //                       width: 600.w,
              //                       child: Text(
              //                           productList[index]["item description"],
              //                           style: TextStyle(
              //                               fontSize: 25.sp,
              //                               fontWeight: FontWeight.w600)),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
//pending widget

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Orders")
          .where("status", isEqualTo: "pending")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () async {
                  Map<String, dynamic> order =
                      data.data() as Map<String, dynamic>;
                  List<dynamic> productList = data["products"];
                  log(productList.toString());

                  showDialog(
                    context: context,
                    builder: (context) => ProductDetailsWidget(
                      productList: productList,
                      data: order,
                      docId: (data.id).toString(),
                    ),
                  );
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHorizontalSpace(25.w),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                AssetImage('assets/images/picture.png'),
                          ),
                          addHorizontalSpace(140.w),
                          SizedBox(
                            height: 50.h,
                            width: 90.w,
                            child: Text(
                              data["contact name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(140.w),
                          SizedBox(
                            height: 50.h,
                            width: 100.w,
                            child: Text(
                              data["products"][0]["item name"].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(160.w),
                          SizedBox(
                            height: 50.h,
                            width: 100.w,
                            child: Text(
                              '\$${data["order total price"]}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(100.w),
                          SizedBox(
                            height: 50.h,
                            width: 120.w,
                            child: Text(
                              data["order date"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(80.w),
                          data['status'] == "pending"
                              ? Icon(
                                  Icons.history,
                                  size: 30.sp,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.history,
                                  color: Colors.green,
                                  size: 30.sp,
                                ),
                          addHorizontalSpace(10.w),
                          Text(
                            data['status'].toString()[0].toUpperCase() +
                                data['status'].toString().substring(1),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 30.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Container(
                        height: 1.h,
                        color: secondaryColor.withOpacity(0.2),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

//
class DeliveredWidget extends StatefulWidget {
  const DeliveredWidget({super.key});

  @override
  State<DeliveredWidget> createState() => _DeliveredWidgetState();
}

class _DeliveredWidgetState extends State<DeliveredWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Orders")
          .where("status", isEqualTo: "delivered")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () async {
                  Map<String, dynamic> order =
                      data.data() as Map<String, dynamic>;
                  List<dynamic> productList = data["products"];
                  log(productList.toString());

                  showDialog(
                    context: context,
                    builder: (context) => ProductDetailsWidget(
                      productList: productList,
                      data: order,
                      docId: (data.id).toString(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHorizontalSpace(25.w),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                AssetImage('assets/images/picture.png'),
                          ),
                          addHorizontalSpace(140.w),
                          SizedBox(
                            height: 50.h,
                            width: 90.w,
                            child: Text(
                              data["contact name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(140.w),
                          SizedBox(
                            height: 50.h,
                            width: 100.w,
                            child: Text(
                              data["products"][0]["item name"].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(160.w),
                          SizedBox(
                            height: 50.h,
                            width: 100.w,
                            child: Text(
                              '\$${data["order total price"]}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(100.w),
                          SizedBox(
                            height: 50.h,
                            width: 120.w,
                            child: Text(
                              data["order date"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          addHorizontalSpace(80.w),
                          data['status'] == "pending"
                              ? Icon(
                                  Icons.history,
                                  size: 30.sp,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.history,
                                  color: Colors.green,
                                  size: 30.sp,
                                ),
                          addHorizontalSpace(10.w),
                          Text(
                            data['status'].toString()[0].toUpperCase() +
                                data['status'].toString().substring(1),
                            style: TextStyle(
                              fontSize: 30.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Container(
                        height: 1.h,
                        color: secondaryColor.withOpacity(0.2),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

//
class ProductCustomTextWiget extends StatelessWidget {
  double width;
  String title;
  ProductCustomTextWiget({super.key, required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      // alignment: Alignment.centerRight,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 30.sp,
          fontFamily: "Sofia",
          letterSpacing: 0.5,
          color: greyColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProductCustomTextWiget2 extends StatelessWidget {
  double width;
  String title;
  ProductCustomTextWiget2(
      {super.key, required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      // alignment: Alignment.topLeft,
      width: width.w,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 27.sp,
          letterSpacing: 0.5,
          fontFamily: "Sofia",
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
