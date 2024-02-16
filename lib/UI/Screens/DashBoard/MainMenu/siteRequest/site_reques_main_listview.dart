// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
// import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ReportFaults/report_main_listView.dart';
// import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/siteRequest/site_request_viewmodel.dart';
// import 'package:rhinoapp/Utils/colors.dart/colors.dart';
// import 'package:rhinoapp/Utils/flutter_toast.dart';
// import 'package:rhinoapp/Utils/helper_widgets.dart';

// class SiteRequestMainView extends StatefulWidget {
//   final DocumentSnapshot? siteRequest;
//   final SiteRequestViewModel? valuee;
//   final String? isApprove;
//   final id;
//   final int? index;
//   int? expandeTile;

//   SiteRequestMainView(
//       {super.key,
//       this.siteRequest,
//       this.valuee,
//       this.isApprove,
//       this.id,
//       this.index,
//       this.expandeTile});

//   @override
//   State<SiteRequestMainView> createState() => _SiteRequestMainViewState();
// }

// class _SiteRequestMainViewState extends State<SiteRequestMainView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20.h),
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: blackColor.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 1,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       child: ExpansionTile(
//         onExpansionChanged: (value) {
//           if (value) {
//             widget.valuee!.setCurrentlyExpandedIndex(widget.index);
//           } else {
//             widget.valuee!.setCurrentlyExpandedIndex(null);
//           }
//           // setState(() {});
//         },
//         initiallyExpanded: widget.expandeTile == widget.index,
//         iconColor: blackColor,
//         backgroundColor: whiteColor,
//         childrenPadding: EdgeInsets.only(bottom: 20.h),
//         title: Row(
//           children: [
//             Container(
//               width: 300.h,
//               child: Text(
//                 widget.siteRequest!["Contact name"],
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                   fontSize: 35.sp,
//                   letterSpacing: 0.5,
//                   fontFamily: "Sofia",
//                   color: secondaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             addHorizontalSpace(230.w),
//             Container(
//               width: 300.h,
//               child: Text(
//                 widget.siteRequest!["Site name"],
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                   fontSize: 35.sp,
//                   letterSpacing: 0.5,
//                   fontFamily: "Sofia",
//                   color: secondaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         children: [
//           Container(
//             padding: EdgeInsets.only(bottom: 20.h),
//             child: Column(
//               children: [
//                 SizedBox(
//                     height: 20.h,
//                     child: Divider(
//                       color: blackColor.withOpacity(0.2),
//                       thickness: 0.5.sp,
//                     )),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 10.w),
//                       child: CustomContainer(
//                         height: 350.h,
//                         width: 330.w,
//                         choseshadow: true,
//                         // color: Color.fromRGBO(
//                         //     248, 248, 248, 1),
//                         color: Colors.white,
//                         widget: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             addHorizontalSpace(4.w),
//                             addVerticalSpace(40.h),
//                             Padding(
//                               padding: EdgeInsets.only(left: 30.w, right: 10.w),
//                               child: Column(
//                                 children: [
//                                   CustomNameContainer(
//                                     // name: widget.site!["Contact name"],
//                                     name: widget.siteRequest!["Contact name"],
//                                   ),
//                                   addVerticalSpace(20.h),
//                                   CustomNameContainer(
//                                     // name: widget.site!["Contact email"],
//                                     name: widget.siteRequest!["Contact email"],
//                                   ),
//                                   addVerticalSpace(20.h),
//                                   CustomNameContainer(
//                                     // name: widget.site!["Contact phone"],
//                                     name: widget.siteRequest!["Contact phone"],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     addHorizontalSpace(100.w),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             CustomContainer(
//                               height: 350.h,
//                               width: 700.w,
//                               choseshadow: true,
//                               color: Colors.white,
//                               widget: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(16.sp),
//                                   child: Container(
//                                     height: 350.h,
//                                     width: 700.w,
//                                     child: SingleChildScrollView(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 10.h),
//                                         child: Text(
//                                           widget.siteRequest!["Site message"],
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(
//                                             letterSpacing: 0.5,
//                                             fontSize: 30.sp,
//                                             fontWeight: FontWeight.normal,
//                                             fontFamily: "Sofia",
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10.w),
//                             widget.isApprove!.isNotEmpty
//                                 ? Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       widget.isApprove != 'Approve'
//                                           ? SizedBox(
//                                               width: 60.w,
//                                               height: 40.h,
//                                               child: ElevatedButton(
//                                                 onPressed: () {
//                                                   widget.valuee!
//                                                       .reqSiteAproveOrReject(
//                                                           widget.siteRequest![
//                                                               "ContadId"],
//                                                           widget.siteRequest![
//                                                               "Contact name"],
//                                                           widget.siteRequest![
//                                                               "Contact email"],
//                                                           widget.siteRequest![
//                                                               "Contact phone"],
//                                                           widget.siteRequest![
//                                                               "token"],
//                                                           'Confirmation, you have now been added to the ${widget.siteRequest!["Contact name"]} site',
//                                                           widget.siteRequest![
//                                                               'siteId'],
//                                                           widget.siteRequest![
//                                                               'ContadId']);
//                                                   widget.valuee!.databaseService
//                                                       .siteRequestDB
//                                                       .doc(widget.id)
//                                                       .update({
//                                                     'isApproveOrNot': 'Approve'
//                                                   });
//                                                   FlutterTost.customToast(
//                                                       "You are Approve This Site");
//                                                 },
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor: Colors.green,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20.r),
//                                                   ),
//                                                 ),
//                                                 child: Text(
//                                                   'Approve',
//                                                   style: TextStyle(
//                                                       fontSize: 11.sp),
//                                                 ),
//                                               ),
//                                             )
//                                           : Icon(Icons.check),
//                                       SizedBox(width: 20.w),
//                                       widget.isApprove != 'Reject'
//                                           ? SizedBox(
//                                               width: 60.w,
//                                               height: 40.h,
//                                               child: ElevatedButton(
//                                                 onPressed: () {
//                                                   widget.valuee!
//                                                       .reqSiteAproveOrReject(
//                                                           widget.siteRequest![
//                                                               "ContadId"],
//                                                           widget.siteRequest![
//                                                               "Contact name"],
//                                                           widget.siteRequest![
//                                                               "Contact email"],
//                                                           widget.siteRequest![
//                                                               "Contact phone"],
//                                                           widget.siteRequest![
//                                                               "token"],
//                                                           'Confirmation, Your site change request has been rejected',
//                                                           widget.siteRequest![
//                                                               'siteId'],
//                                                           widget.siteRequest![
//                                                               'ContadId']);
//                                                   widget.valuee!.databaseService
//                                                       .siteRequestDB
//                                                       .doc(widget.id)
//                                                       .update({
//                                                     'isApproveOrNot': 'Reject'
//                                                   });
//                                                   FlutterTost.customToast(
//                                                       "You are Reject This Site");
//                                                 },
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor: Colors.red,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20.r),
//                                                   ),
//                                                 ),
//                                                 child: Text(
//                                                   'Reject',
//                                                   style: TextStyle(
//                                                       fontSize: 12.sp),
//                                                 ),
//                                               ),
//                                             )
//                                           : Icon(Icons.cancel),
//                                     ],
//                                   )
//                                 : SizedBox.shrink()
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
