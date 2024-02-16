// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/CustomeWidgets/custom_container.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '../../../../CustomeWidgets/converstation_list.dart';
import '../SiteScreen/site_viewmodel.dart';
import 'chat_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  FocusNode messagetextFieldNode = FocusNode();
  int selectIndex = -1;
  // DateFormat dateFormat = DateFormat("yyyyMM-dd HH:mm:ss");
  @override
  Widget build(BuildContext context) {
    final siteProvider = Provider.of<SiteViewmodel>(
      context,
    );

    DateFormat timeFormat = DateFormat('hh:mm a');
    DateFormat dateFormat = DateFormat('dd/MM/yy');
    return SingleChildScrollView(
      child: Column(
        children: [
          addVerticalSpace(60.h),
          Row(
            children: [
              addHorizontalSpace(20.w),
              Text(
                "CHATS",
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
                child: TextFormField(
                  onChanged: (value) {
                    siteProvider.searchByName(value);
                  },
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(30.sp),
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
              addHorizontalSpace(20.w),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context, builder: (context) => ChatWidget());
                },
                child: Image.asset(
                  "assets/images/add.png",
                  height: 35,
                  width: 35,
                ),
              ),
              addHorizontalSpace(30.w)
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  addVerticalSpace(40.h),
                  Container(
                    width: 380.w,
                    height: 980.h,
                    // color: greyColor,
                    child: Column(
                      children: [
                        // addHorizontalSpace(40.w),

                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            children: [
                              Text(
                                "Workers",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  letterSpacing: 0.5,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Divider(
                            thickness: 1.sp,
                            color: greyColor,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: siteProvider.metaDataList.length,
                            shrinkWrap: true,

                            // padding: EdgeInsets.only(top: 10),
                            //physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final time = timeAgo.format(siteProvider
                                  .metaDataList[index].time!
                                  .toDate());
                              log(time);
                              log("MetaData Length====>>${siteProvider.metaDataList.length}");

                              if (siteProvider.searchName.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectIndex = index;
                                    });
                                    siteProvider.getMessage(siteProvider
                                        .metaDataList[index].chatRoomId
                                        .toString());
                                    siteProvider.updateUnreadMessageByAdmin(
                                        siteProvider
                                            .metaDataList[index].chatRoomId
                                            .toString());
                                    siteProvider.setContactName(siteProvider
                                        .metaDataList[index].contactName
                                        .toString());
                                    siteProvider.setTheCurrentSite(siteProvider
                                        .metaDataList[index].currentSite
                                        .toString());
                                  },
                                  child: ConversationList(
                                    selectInex: selectIndex,
                                    index: index,
                                    currentSite: siteProvider
                                        .metaDataList[index].currentSite
                                        .toString(),
                                    name: siteProvider
                                        .metaDataList[index].contactName
                                        .toString(),
                                    messageText: siteProvider
                                                .metaDataList[index].lastMessage
                                                .toString()
                                                .length <
                                            10
                                        ? siteProvider
                                            .metaDataList[index].lastMessage
                                            .toString()
                                        : siteProvider
                                                .metaDataList[index].lastMessage
                                                .toString()
                                                .substring(0, 10) +
                                            "...",
                                    time: time,
                                    chatId: siteProvider
                                        .metaDataList[index].chatRoomId
                                        .toString(),
                                    isRead: siteProvider
                                        .metaDataList[index].unreadByAdmin,
                                  ),
                                );
                              } else if (siteProvider
                                  .metaDataList[index].contactName
                                  .toString()
                                  .toLowerCase()
                                  .contains(
                                      siteProvider.searchName.toLowerCase())) {
                                return ConversationList(
                                  selectInex: selectIndex,
                                  index: index,
                                  currentSite: siteProvider
                                      .metaDataList[index].currentSite
                                      .toString(),
                                  name: siteProvider
                                      .metaDataList[index].contactName
                                      .toString(),
                                  messageText: siteProvider
                                              .metaDataList[index].lastMessage
                                              .toString()
                                              .length <
                                          10
                                      ? siteProvider
                                          .metaDataList[index].lastMessage
                                          .toString()
                                      : siteProvider
                                              .metaDataList[index].lastMessage
                                              .toString()
                                              .substring(0, 10) +
                                          "...",
                                  time: time,
                                  chatId: siteProvider
                                      .metaDataList[index].chatRoomId
                                      .toString(),
                                  isRead: siteProvider
                                      .metaDataList[index].unreadByAdmin,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addHorizontalSpace(50.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 900.h,
                    width: 6.w,
                    color: Color(0xffF5F5F5),
                  ),
                  Container(
                      width: 850.w,
                      height: 1000.h,
                      // color: redColor,
                      child: Column(
                        children: [
                          addVerticalSpace(40.h),
                          CustomContainer(
                            width: 850.w,
                            height: 65.h,
                            boarderRadius: 0,
                            color: Color(0xffF5F5F5),
                            widget: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          siteProvider.contactName.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 25.sp,
                                            letterSpacing: 0.5,
                                            fontFamily: "Sofia",
                                            color: secondaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: siteProvider.messageList.length,
                              shrinkWrap: true,
                              reverse: true,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                String dateTime = (dateFormat.format(
                                            siteProvider
                                                .messageList[index].time!
                                                .toDate()) +
                                        "  " +
                                        timeFormat.format(siteProvider
                                            .messageList[index].time!
                                            .toDate()))
                                    .toString();

                                bool isMe =
                                    siteProvider.messageList[index].sendBy ==
                                            "Admin"
                                        ? false
                                        : true;

                                log(isMe.toString());

                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 14, right: 14, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      isMe
                                          ? SizedBox()
                                          : CircleAvatar(
                                              radius: 15,
                                              backgroundColor: secondaryColor
                                                  .withOpacity(0.4),
                                              child: Icon(
                                                Icons.person,
                                                color: whiteColor,
                                                size: 20,
                                              ),
                                            ),
                                      addHorizontalSpace(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 500.w,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: isMe
                                                  ? BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(9.r),
                                                      topRight:
                                                          Radius.circular(9.r),
                                                      bottomLeft:
                                                          Radius.circular(9.r),
                                                      bottomRight:
                                                          Radius.circular(0.r),
                                                    )
                                                  : BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0.r),
                                                      topRight:
                                                          Radius.circular(9.r),
                                                      bottomLeft:
                                                          Radius.circular(9.r),
                                                      bottomRight:
                                                          Radius.circular(9.r),
                                                    ),
                                              color: (isMe
                                                  ? lightGreyColor
                                                  : secondaryColor),
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Text(
                                              siteProvider
                                                  .messageList[index].message
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 25.sp,
                                                  letterSpacing: 0.5,
                                                  color: isMe
                                                      ? blackColor
                                                      : whiteColor),
                                            ),
                                          ),
                                          addVerticalSpace(5),
                                          Text(
                                            dateTime,
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                letterSpacing: 0.5,
                                                color: blackColor),
                                          ),
                                        ],
                                      ),
                                      isMe
                                          ? CircleAvatar(
                                              radius: 15,
                                              backgroundColor: secondaryColor
                                                  .withOpacity(0.4),
                                              child: Icon(
                                                Icons.person,
                                                color: whiteColor,
                                                size: 20,
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          // Spacer(),
                          CustomContainer(
                            width: 850.w,
                            height: 70.h,
                            boarderRadius: 11.r,
                            borderColor: secondaryColor,
                            widget: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    autofocus: true,
                                    focusNode: messagetextFieldNode,
                                    onFieldSubmitted: (value) {
                                      if (messageController.text.isNotEmpty) {
                                        siteProvider.sendMessage(
                                            messageController.text.trim());
                                        messageController.clear();
                                        messagetextFieldNode.requestFocus();
                                      }
                                    },
                                    controller: messageController,
                                    style: TextStyle(color: whiteColor),
                                    decoration: InputDecoration(
                                      hintText: "Type your message ...",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      hintStyle: TextStyle(
                                        color: whiteColor,
                                        fontFamily: "Sofia",
                                        fontSize: 25.sp,
                                        letterSpacing: 0.5,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //check condition if message is not empty

                                    if (messageController.text.isNotEmpty) {
                                      siteProvider.sendMessage(
                                          messageController.text.trim());
                                      messageController.clear();
                                      messagetextFieldNode.requestFocus();
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/icons/chat.png",
                                    height: 50.h,
                                    width: 50.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  ChatWidget({
    super.key,
  });
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  @override
  Widget build(BuildContext context) {
    final siteProvider = Provider.of<SiteViewmodel>(context);
    return Consumer<ChatViewModel>(
      builder: (context, model, child) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 1000.h,
            width: 900.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60.h,
                  width: 900.w,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 0.5,
                        fontFamily: "Sofia",
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: StreamBuilder(
                      stream: model.databaseService.userSiteDB.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(""),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  ExpansionTile(
                                    expandedAlignment: Alignment.topLeft,
                                    title: Text(
                                      data["Site Name"],
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        letterSpacing: 0.5,
                                        fontFamily: "Sofia",
                                        color: blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    childrenPadding:
                                        EdgeInsets.only(left: 20, bottom: 15),
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //collapsedIconColor: Colors.black,
                                    collapsedTextColor: Colors.black,
                                    iconColor: Colors.black,
                                    textColor: Colors.black,
                                    children: [
                                      SizedBox(
                                        height: 200.h,
                                        child: StreamBuilder(
                                            stream: model
                                                .databaseService.userSiteDB
                                                .doc(data.id)
                                                .collection("Contacts")
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot1) {
                                              if (!snapshot1.hasData) {
                                                return Center(
                                                  child: Text(""),
                                                );
                                              } else if (snapshot1
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                return ListView.builder(
                                                  itemCount: snapshot1
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final contactData =
                                                        snapshot1
                                                            .data!.docs[index];

                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20.w),
                                                      child: Card(
                                                        child: ListTile(
                                                            leading: Text(
                                                                contactData[
                                                                    "name"]),
                                                            trailing:
                                                                IconButton(
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    chatRoomId =
                                                                    siteProvider.createChatRoomIdnew(
                                                                        contactData["email"]
                                                                            .toString(),
                                                                        'Admin');

                                                                // chatRoom

                                                                siteProvider.chatRoom(
                                                                    chatRoomId,
                                                                    contactData[
                                                                            "name"]
                                                                        .toString(),
                                                                    contactData
                                                                        .id,
                                                                    data.id,
                                                                    contactData[
                                                                            "email"]
                                                                        .toString());
                                                                //get message
                                                                // siteProvider
                                                                //     .getMetaData();
                                                                // siteProvider
                                                                //     .getMessage(
                                                                //         chatRoomId);

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: Icon(
                                                                Icons.chat,
                                                                color:
                                                                    secondaryColor,
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    width: 900.w,
                                    color: Colors.grey,
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }),
                )),
              ],
            ),
          )),
    );
  }
}
