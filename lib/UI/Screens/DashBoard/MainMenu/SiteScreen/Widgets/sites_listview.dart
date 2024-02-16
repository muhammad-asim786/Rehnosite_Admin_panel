// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notification_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/Widgets/add_contact_alert.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/Widgets/services_container.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';

import '../../../../../../Utils/colors.dart/colors.dart';
import '../../../../../../Utils/helper_widgets.dart';
import '../../../../../CustomeWidgets/custom_container.dart';
import '../../Notifications/notification_alert_box.dart';

class MainListView extends StatefulWidget {
  final int index;
  DocumentSnapshot? site;
  MainListView({required this.index, required this.site});

  @override
  State<MainListView> createState() => _MainListViewState();
}

class _MainListViewState extends State<MainListView> {
  bool selected = false;
  bool check = false;
  int? selectIndex = -1;
  String? contactName = '';
  String? id;
  List<dynamic> ContactId = [];
  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<SideBarCount>(context, listen: false);
    final siteProvider = Provider.of<SiteViewmodel>(context);

    final notificationModel = Provider.of<NotificationViewModel>(context);

    return Column(
      children: [
        addVerticalSpace(20.h),
        InkWell(
          borderRadius: BorderRadius.circular(16.sp),
          onTap: () {
            siteProvider.selectData(widget.index.toString());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomContainer(
              height: 80.h,
              choseshadow: true,
              color: whiteColor,
              // color: Colors.cyanAccent,
              boarderRadius: 16.sp,
              width: double.infinity,
              widget: Row(
                children: [
                  addHorizontalSpace(10.w),
                  Text(
                    widget.site!["Site Name"],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sofia",
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      notificationModel.getSiteName();
                      showDialog(
                        barrierColor: Colors.black.withOpacity(0.2),
                        context: context,
                        builder: (context) => NotificationAlerBox(
                          siteName: widget.site!["Site Name"],
                          isSite: true,
                        ),
                      );
                    },
                    child: Image.asset(
                      "assets/icons/notifications.png",
                      height: 45.h,
                      color: secondaryColor,
                      width: 45.h,
                    ),
                  ),
                  addHorizontalSpace(20.w),
                  !siteProvider.selectedMap.containsKey(widget.index.toString())
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: blackColor,
                          size: 30,
                        )
                      : Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                            size: 30,
                          ),
                        ),
                  addHorizontalSpace(20.w),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible:
              siteProvider.selectedMap.containsKey(widget.index.toString()),
          child: Column(
            children: [
              addVerticalSpace(20.h),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 23.w),
                    child: CustomContainer(
                      height: 350.h,
                      width: 330.w,
                      choseshadow: true,
                      color: Color(0xffF8F8F8),
                      widget: Column(
                        children: [
                          Row(
                            children: [
                              addHorizontalSpace(4.w),
                              Text(
                                "CONTACTS",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  letterSpacing: 0.5,
                                  fontFamily: "Sofia",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  //countProvider.setIndex(5);
                                },
                                child: Image.asset(
                                  "assets/icons/doublechat.png",
                                  height: 40.h,
                                  width: 40.h,
                                ),
                              ),
                              addHorizontalSpace(38.w)
                            ],
                          ),
                          addVerticalSpace(25.h),
                          Expanded(
                            child: StreamBuilder(
                              stream: siteProvider.databaseService.userSiteDB
                                  .doc(widget.site!.id)
                                  .collection("Contacts")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text(""),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          addVerticalSpace(15.h),
                                          Row(
                                            children: [
                                              addHorizontalSpace(8.w),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    siteProvider.storeValue =
                                                        index;
                                                    selectIndex = index;
                                                    contactName = snapshot.data!
                                                        .docs[index]["name"]
                                                        .toString();
                                                    id = widget.site!.id;
                                                  });

                                                  //get all services
                                                  siteProvider.getService(
                                                      widget.site!.id,
                                                      snapshot.data!.docs[index]
                                                          .id);
                                                  print(snapshot
                                                      .data!.docs[index]["name"]
                                                      .toString());

                                                  // set the collection and doc id

                                                  siteProvider
                                                      .setCollectionAndDocId(
                                                    widget.site!.id.toString(),
                                                    snapshot
                                                        .data!.docs[index].id
                                                        .toString(),
                                                  );
                                                },
                                                child: Text(
                                                  snapshot
                                                      .data!.docs[index]["name"]
                                                      .toString(),
                                                  // contactNames[index],
                                                  style: TextStyle(
                                                      color: selectIndex ==
                                                              index
                                                          ? blackColor
                                                          : blackColor
                                                              .withOpacity(0.5),
                                                      fontSize: 25.sp,
                                                      letterSpacing: 0.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Sofia"),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 100.w,
                                                height: 30.h,
                                                //color: redColor,
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    //!
                                                    //! to create the chat room to the specific user
                                                    //![1] get the chat id
                                                    //![2] get the name of the contact
                                                    GestureDetector(
                                                      onTap: () async {
                                                        // name of the contact
                                                        siteProvider
                                                            .setContactName(
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                        ["name"]
                                                                    .toString());
                                                        String docId = snapshot
                                                            .data!
                                                            .docs[index]
                                                            .id;
                                                        log('this is the docID: $docId');
                                                        // chatRoomId
                                                        String chatRoomId = siteProvider
                                                            .createChatRoomIdnew(
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                        [
                                                                        "email"]
                                                                    .toString(),
                                                                'Admin');
                                                        log('this is the docID: $chatRoomId');
                                                        // chatRoom
                                                        siteProvider.chatRoom(
                                                            chatRoomId,
                                                            snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ["name"]
                                                                .toString(),
                                                            snapshot.data!
                                                                .docs[index].id,
                                                            widget.site!.id,
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ["email"]);
                                                        //get message
                                                        siteProvider
                                                            .getMetaData();
                                                        siteProvider.getMessage(
                                                            chatRoomId);
                                                        //get Metadata
                                                        //change the screen
                                                        countProvider
                                                            .setIndex(5);
                                                        log('This is the final and 88');
                                                      },
                                                      child: Image.asset(
                                                        "assets/icons/message.png",
                                                        height: 30.h,
                                                        width: 30.w,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        // print(nameofContact);
                                                        print(index);
                                                        //delete chate
                                                        String chatRoomId = siteProvider
                                                            .createChatRoomIdnew(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["email"],
                                                                'Admin');

                                                        // List<dynamic> contact =
                                                        //     nameofContact.toList();

                                                        // contact.removeAt(index);

                                                        //delete chat
                                                        siteProvider.deleteChat(
                                                            chatRoomId);

                                                        siteProvider
                                                            .deleteContactName(
                                                                widget.site!.id,
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id
                                                                    .toString());
                                                        //update the list
                                                        siteProvider.messageList
                                                            .clear();

                                                        siteProvider
                                                            .deleteSiteContact(
                                                                widget.site!.id,
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["email"],
                                                                snapshot.data!
                                                                            .docs[
                                                                        index][
                                                                    "password"]);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            redColor,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: whiteColor,
                                                          size: 20.sp,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              addHorizontalSpace(18.w),
                                            ],
                                          ),
                                          addVerticalSpace(15.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.sp),
                                            child: CustomContainer(
                                              height: 1.h,
                                              color: Color(0xffA1A1A1),
                                              width: double.infinity,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          addVerticalSpace(15.h),
                          Row(
                            children: [
                              // addHorizontalSpace(20),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(14.sp),
                                        ),
                                      ),
                                      child: AddContactAlert(
                                        site: widget.site!.id,
                                        index: widget.index,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  color: secondaryColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpace(30.h),
                        ],
                      ),
                    ),
                  ),
                  addHorizontalSpace(20.w),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: CustomContainer(
                      height: 350.h,
                      width: 902.w,
                      choseshadow: true,
                      color: Color(0xffF8F8F8),
                      // widget: Container(child: Text("arshad")),
                      widget: ServicesConatainer(
                        index: selectIndex,
                        contactName: contactName,
                        id: id,
                        asignServiceList: ContactId,
                      ),
                    ),
                  )
                ],
              ),
              addVerticalSpace(20.h)
            ],
          ),
        ),
      ],
    );
  }
}
