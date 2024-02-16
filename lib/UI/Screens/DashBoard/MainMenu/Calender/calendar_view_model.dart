// ignore_for_file: unused_local_variable, avoid_web_libraries_in_flutter, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'package:calendar_view/calendar_view.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:rhinoapp/Model/base_model.dart';
import 'package:rhinoapp/service/firebase_database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../Utils/helper_widgets.dart';

class CalendarViewModel extends BaseViewModal {
  int _selectedDate = 0;
  bool isBusy = false;
  int startDay = 0;
  int endDay = 0;
  List<CalendarEventData<Event>> eventList = [];
  List<String> contactNameFromSiteList = [];
  List<String> serviceProviderNameList = [];
  List<String> serviceList = [];
  List<CalendarEventData<Event>> eventFilterList = [];
  final List<Appointment> meetings = <Appointment>[];

  final List<Appointment> dommyDateList = [];

  final dateList = List.generate(
      365,
      (index) => DateTime(DateTime.now().year, DateTime.now().month, 0)
          .add(Duration(days: index + 1)));

  List csvFileList = [];

  final databaseService = DatabaseService();

  CalendarViewModel() {
    log("CalendarViewModel");
    print("CalendarViewModel");
    getAllServices();
  }
  int get selectedDate => _selectedDate;
  changeValue(int value) {
    _selectedDate = value;
    notifyListeners();
  }

  // setDateRange

  void setDateRange(int start, int end) {
    startDay = start;
    endDay = end;

    print("start date:$startDay");
    print("end day:$endDay");

    notifyListeners();
  }

  //clear filter

  void clearFilter() {
    eventFilterList.clear();
    notifyListeners();
  }

  void getAllServices() async {
    setState(ViewState.busy);
    isBusy = true;
    eventList.clear();
    meetings.clear();
    csvFileList.clear();
    dommyDateList.clear();
    meetings.clear();
    notifyListeners();
    try {
      final snapshot = await databaseService.userSiteDB.get();

      snapshot.docs.forEach((element) async {
        final contacts = await databaseService.userSiteDB
            .doc(element.id)
            .collection("Contacts")
            .get();

        contacts.docs.forEach((element1) async {
          final services = await databaseService.userSiteDB
              .doc(element.id)
              .collection("Contacts")
              .doc(element1.id)
              .collection("Services")
              .get();

          services.docs.forEach((element2) {
            // for linear calendar logic start from here

            List<String> serviceLevelList =
                (element2.data()["service level"].toString())
                    .split('/')
                    .where((s) => s.isNotEmpty)
                    .toList();

            DateTime dateTime = DateTime.parse(element2.data()["start date"]);

            for (var i = 0; i < dateList.length; i++) {
              if (dateList[i] ==
                  DateTime.parse(element2.data()["start date"])) {
                setMeetingDate(
                  startData: element2.data()["start date"],
                  color: element2.data()["color"],
                  subject: element2.data()["service"],
                  serviceLevel: element2.data()["service level"],
                  SiteName: element2.data()["Site Name"],
                  serviceProvider: element2.data()["service provider"],
                );
              } else if (serviceLevelList.contains("Weekly")) {
                dateTime = dateTime.add(Duration(days: 7));

                dommyDateList.add(Appointment(
                  startTime: dateTime,
                  endTimeZone: '',
                  startTimeZone: '',
                  notes: "domy",
                  // isAllDay: true,
                  location:
                      "${element2.data()["Site Name"]}/${element2.data()["service provider"]}",
                  // isAllDay: true,

                  // isAllDay: true,
                  endTime: dateTime,
                  subject: element2.data()["service"],
                  color: Color(int.parse(element2.data()["color"])),
                ));
              } else if (serviceLevelList.contains("Monthly")) {
                dateTime = dateTime.add(Duration(days: 30));

                dommyDateList.add(Appointment(
                  startTime: dateTime,
                  endTimeZone: '',
                  startTimeZone: '',
                  notes: "domy",
                  // isAllDay: true,
                  location:
                      "${element2.data()["Site Name"]}/${element2.data()["service provider"]}",
                  // isAllDay: true,

                  // isAllDay: true,
                  endTime: dateTime,
                  subject: element2.data()["service"],
                  color: Color(int.parse(element2.data()["color"])),
                ));
              } else if (serviceLevelList.contains("Fortnightly")) {
                dateTime = dateTime.add(Duration(days: 14));

                dommyDateList.add(Appointment(
                  startTime: dateTime,
                  endTimeZone: '',
                  startTimeZone: '',
                  notes: "domy",
                  // isAllDay: true,
                  location:
                      "${element2.data()["Site Name"]}/${element2.data()["service provider"]}",
                  // isAllDay: true,

                  // isAllDay: true,
                  endTime: dateTime,
                  subject: element2.data()["service"],
                  color: Color(int.parse(element2.data()["color"])),
                ));
              } else if (serviceLevelList.contains("Monday") ||
                  serviceLevelList.contains("Tuesday") ||
                  serviceLevelList.contains("Wednesday") ||
                  serviceLevelList.contains("Thursday") ||
                  serviceLevelList.contains("Friday") ||
                  serviceLevelList.contains("Saturday") ||
                  serviceLevelList.contains("Sunday")) {
                dateTime = dateTime.add(Duration(days: 7));

                dommyDateList.add(Appointment(
                  startTime: dateTime,
                  endTimeZone: '',
                  startTimeZone: '',
                  notes: "domy",
                  // isAllDay: true,
                  location:
                      "${element2.data()["Site Name"]}/${element2.data()["service provider"]}",
                  // isAllDay: true,

                  // isAllDay: true,
                  endTime: dateTime,
                  subject: element2.data()["service"],
                  color: Color(int.parse(element2.data()["color"])),
                ));
              } else {
                dommyDateList.add(Appointment(
                  startTime: dateList[i],
                  endTimeZone: '',
                  startTimeZone: '',
                  notes: "domy",
                  // isAllDay: true,
                  location:
                      "${element2.data()["Site Name"]}/${element2.data()["service provider"]}",
                  // isAllDay: true,

                  // isAllDay: true,
                  endTime: dateList[i],
                  subject: "",
                  color: Colors.white,
                ));
              }
            }

            calculateDateAndStoreInEventList(
              element2.data()["start date"],
              element2.data()["next date"],
              element2.data()["service"],
              element2.data()["color"],
              element2.data()["service level"],
              element2.data()["Site Name"],
              element2.data()["service provider"],
            );
          });
        });
      });
      setState(ViewState.idle);
      isBusy = false;
      notifyListeners();
    } catch (e) {
      isBusy = false;
      print("e $e");
      setState(ViewState.idle);
    }
  }

  void calculateDateAndStoreInEventList(
    String startDate,
    String endDate,
    String value,
    String color,
    String serviceLevel,
    String siteName,
    String serviceProvider,
  ) async {
    // List<String> serviceLevelList = serviceLevel.split("/");
    List<String> serviceLevelList =
        serviceLevel.split('/').where((s) => s.isNotEmpty).toList();

    DateTime start = DateTime.parse(startDate);

    // DateTime end = DateTime.parse(endDate);
    // DateTime start = DateTime.now();

    // List<DateTime> datesBetween = [];

    if (serviceLevelList.contains("On Demand")) {
    } else {
      // when select only weekend
      if (serviceLevelList.contains("Weekly")) {
        eventList.add(CalendarEventData(
          date: start,
          event: Event(serviceProvider),
          title: siteName,
          description: value,
          color: Color(int.parse(color)),
          startTime: DateTime(
            start.add(Duration(days: 1)).year,
            start.add(Duration(days: 1)).month,
            start.add(Duration(days: 7)).day,
          ),
          endTime: DateTime(
            start.add(Duration(days: 1)).year,
            start.add(Duration(days: 1)).month,
            start.add(Duration(days: 1)).day + 2,
          ),
        ));
      } else if (serviceLevelList.contains("Fortnightly")) {
        eventList.add(CalendarEventData(
          date: start.add(Duration(days: 14)),
          event: Event(serviceProvider),
          title: siteName,
          description: value,
          color: Color(int.parse(color)),
          startTime: DateTime(
            start.add(Duration(days: 1)).year,
            start.add(Duration(days: 1)).month,
            start.add(Duration(days: 1)).day,
          ),
          endTime: DateTime(
            start.add(Duration(days: 1)).year,
            start.add(Duration(days: 1)).month,
            start.add(Duration(days: 1)).day + 2,
          ),
        ));
      } else if (serviceLevelList.contains("Monthly")) {
        // for (var i = 0; i < 365; i++) {
        //   eventList.add(CalendarEventData(
        //     date: start.add(Duration(days: 30)),
        //     event: Event(serviceProvider),
        //     title: siteName,
        //     description: value,
        //     color: Color(int.parse(color)),
        //     startTime: DateTime(
        //       start.add(Duration(days: 1)).year,
        //       start.add(Duration(days: 1)).month,
        //       start.add(Duration(days: 1)).day,
        //     ),
        //     endTime: DateTime(
        //       start.add(Duration(days: 1)).year,
        //       start.add(Duration(days: 1)).month,
        //       start.add(Duration(days: 1)).day + 2,
        //     ),
        //   ));

        // }
      } else {
        for (var i = 0; i < serviceLevelList.length; i++) {
          print("-------------------");
          log("start.weekday ${start.weekday}");
          log("CheckData(serviceLevelList[i]) ${CheckData(serviceLevelList[i])}");

          log("next date ${start.day + int.parse((CheckData(serviceLevelList[i]) - start.weekday).toString())}");

          start = DateTime(
              start.year,
              start.month,
              start.day +
                  int.parse((CheckData(serviceLevelList[i]) - start.weekday)
                      .toString()));

          eventList.add(
            CalendarEventData(
              date: start,
              event: Event(serviceProvider),
              title: siteName,
              description: value,
              color: Color(int.parse(color)),
              startTime: DateTime(
                start.add(Duration(days: i)).year,
                start.add(Duration(days: i)).month,
                start.add(Duration(days: i)).day,
              ),
              endTime: DateTime(
                start.add(Duration(days: i)).year,
                start.add(Duration(days: i)).month,
                start.add(Duration(days: i)).day + 2,
              ),
            ),
          );
        }
      }
    }

    // for (var i = start; i.isBefore(end); i = i.add(Duration(days: 1))) {
    //   datesBetween.add(i);
    // }

    // if (serviceLevel.contains("Fortnightly")) {
    //   for (var i = 0; i < 14; i++) {
    // eventList.add(
    //   CalendarEventData(
    //     date: start.add(Duration(days: i)),
    //     event: Event("Joe's Birthday"),
    //     title: value,
    //     description: "Today is project meeting.",
    //     color: Color(int.parse(color)),
    //     startTime: DateTime(
    //       start.add(Duration(days: i)).year,
    //       start.add(Duration(days: i)).month,
    //       start.add(Duration(days: i)).day,
    //     ),
    //     endTime: DateTime(
    //       start.add(Duration(days: i)).year,
    //       start.add(Duration(days: i)).month,
    //       start.add(Duration(days: i)).day + 2,
    //     ),
    //   ),
    // );
    //   }
    // } else if (serviceLevel.contains("Weekly")) {
    //   for (var i = 0; i < 7; i++) {
    //     eventList.add(
    //       CalendarEventData(
    //         date: start.add(Duration(days: i)),
    //         event: Event("Joe's Birthday"),
    //         title: value,
    //         description: "Today is project meeting.",
    //         color: Color(int.parse(color)),
    //         startTime: DateTime(
    //           start.add(Duration(days: i)).year,
    //           start.add(Duration(days: i)).month,
    //           start.add(Duration(days: i)).day,
    //         ),
    //         endTime: DateTime(
    //           start.add(Duration(days: i)).year,
    //           start.add(Duration(days: i)).month,
    //           start.add(Duration(days: i)).day + 2,
    //         ),
    //       ),
    //     );
    //   }
    // } else if (serviceLevel.contains("Monthly")) {
    //   for (var i = start.day; i < 30; i++) {
    //     eventList.add(
    //       CalendarEventData(
    //         date: start.add(Duration(days: i)),
    //         event: Event("Joe's Birthday"),
    //         title: value,
    //         description: "Today is project meeting.",
    //         color: Color(int.parse(color)),
    //         startTime: DateTime(
    //           start.add(Duration(days: i)).year,
    //           start.add(Duration(days: i)).month,
    //           start.add(Duration(days: i)).day,
    //         ),
    //         endTime: DateTime(
    //           start.add(Duration(days: i)).year,
    //           start.add(Duration(days: i)).month,
    //           start.add(Duration(days: i)).day + 2,
    //         ),
    //       ),
    //     );
    //   }
    // }
    // //
    // else {
    //   for (var i = 0; i < datesBetween.length; i++) {
    //     if (serviceLevelList.contains(CheckData(datesBetween[i].weekday))) {
    //       eventList.add(
    //         CalendarEventData(
    //           date: datesBetween[i],
    //           event: Event("Joe's Birthday"),
    //           title: value,
    //           description: "Today is project meeting.",
    //           color: Color(int.parse(color)),
    //           startTime: DateTime(
    //             datesBetween[i].year,
    //             datesBetween[i].month,
    //             datesBetween[i].day,
    //           ),
    //           endTime: DateTime(
    //             datesBetween[i].year,
    //             datesBetween[i].month,
    //             datesBetween[i].day + 2,
    //           ),
    //         ),
    //       );
    //     }
    //   }

    // }

    notifyListeners();
  }

  CheckData(dayofWeek) {
    switch (dayofWeek) {
      case "Monday":
        return 1;

      case "Tuesday":
        return 2;

      case "Wednesday":
        return 3;

      case "Thursday":
        return 4;

      case "Friday":
        return 5;

      case "Saturday":
        return 6;

      case "Sunday":
        return 7;

      default:
        return 0;
    }
  }

  // get all contacts name from the given siteName

  void contactNameFromSite(String siteName) async {
    try {
      setState(ViewState.busy);
      notifyListeners();
      contactNameFromSiteList.clear();
      final siteSnapshot = await databaseService.userSiteDB.get();
      String siteNameId = "";

      siteSnapshot.docs.forEach((element) {
        if (element.data()["Site Name"] == siteName) {
          siteNameId = element.id;
        }
      });

      await databaseService.userSiteDB
          .doc(siteNameId)
          .collection("Contacts")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          contactNameFromSiteList.add(element["name"]);
        });
      });

      log('--->> contactSiteNameList');
      log("list====>>$contactNameFromSiteList");
      setState(ViewState.idle);
      notifyListeners();
    } catch (_) {
      setState(ViewState.idle);
      notifyListeners();
      print("Error in contactNameFromSite");
    }
  }

  // get all serviceProviders name from the given siteName

  void getServiceProviderNameAndService() async {
    try {
      serviceProviderNameList.clear();
      serviceList.clear();
      await databaseService.serviceDB.get().then((value) {
        value.docs.forEach((element) {
          serviceProviderNameList.add(element["Service name"]);
          serviceList.add(element["Service provider name"]);
        });
      });

      log('--->> serviceProviderNameList');
      log("list====>>$serviceProviderNameList");
      log("list====>>$serviceList");

      notifyListeners();
    } catch (e) {
      print('Error in getServiceProviderNameAndService');
    }
  }

  //
  void setFilter(String name) {
    print("name====>>$name");
    isBusy = true;
    notifyListeners();

    // bool containsBob = eventList.any((person) => person.description == name);

    var data = eventFilterList.where((element) => element.description == name);

    if (data.isEmpty) {
      var data1 = eventList.where((element) => element.description == name);
      if (data1.isNotEmpty) {
        // eventFilterList.clear();
        // print("data1====>>${data1.toList()}");
        List list = data1.toList();
        eventFilterList.add(list[0]);

        // log("eventFilterList====>>${eventFilterList[0]}");
        notifyListeners();
      } else {
        print("Nothing in the list");
        eventFilterList.add(CalendarEventData(
          date: DateTime(0, 0, 0),
          event: Event(""),
          title: "title",
          description: name,
          color: Colors.white,
          startTime: DateTime(0, 0, 0),
          endTime: DateTime(0, 0, 0),
        ));
        notifyListeners();

        // if (eventFilterList.length > 0) {
        //   eventFilterList.clear();
        //   notifyListeners();
        // } else {

        // }
      }
    } else {
      eventFilterList.removeWhere((element) => element.description == name);
      print("else part call-->>");
      // eventFilterList.clear();

      notifyListeners();
    }

    // print("eventFilterList====>>${eventFilterList.length}");
    // print(eventList[0]);
    isBusy = false;
    notifyListeners();

    //convert to map

    // print(eventList);
  }

  void setFilterByServiceProvider(String name) async {
    print("name====setFilterByServiceProvider >>$name");
    isBusy = true;

    var data = eventFilterList.where((element) => element.event!.title == name);
    // log("data====>>${data.toList()}");
    if (data.isEmpty) {
      var data1 = eventList.where((element) => element.event!.title == name);
      if (data1.isNotEmpty) {
        // eventFilterList.clear();
        List list = data1.toList();
        // log("list====>>${list[0]}");

        eventFilterList.add(list[0]);
        notifyListeners();
      } else {
        print("Nothing in the list");
        eventFilterList.add(CalendarEventData(
          date: DateTime(0, 0, 0),
          event: Event(name),
          title: name,
          description: "",
          color: Colors.white,
          startTime: DateTime(0, 0, 0),
          endTime: DateTime(0, 0, 0),
        ));
        notifyListeners();

        // if (eventFilterList.length > 0) {
        //   eventFilterList.clear();
        //   notifyListeners();
        // } else {
        //   eventFilterList.add(CalendarEventData(
        //     date: DateTime(0, 0, 0),
        //     event: Event(""),
        //     title: "title",
        //     description: name,
        //     color: Colors.white,
        //     startTime: DateTime(0, 0, 0),
        //     endTime: DateTime(0, 0, 0),
        //   ));
        //   notifyListeners();
        // }
      }
    } else {
      eventFilterList.removeWhere((element) => element.event!.title == name);
      // eventFilterList.clear();
      notifyListeners();
    }
    print("eventFilterList====>>${eventFilterList.length}");

    isBusy = false;
    notifyListeners();
  }

  //set for linear

  void setMeetingDate(
      {required String startData,
      required String subject,
      required String color,
      required String serviceLevel,
      required String SiteName,
      required String serviceProvider}) async {
    DateTime dateTime = DateTime.parse(startData);

    csvFileList.add("${dateTime.year}-${dateTime.month}-${dateTime.day}");

    meetings.add(
      Appointment(
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0),
        endTimeZone: '',
        startTimeZone: '',
        notes: serviceLevel,
        // isAllDay: true,
        location: "$SiteName/$serviceProvider",
        // isAllDay: true,

        // isAllDay: true,
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0),
        subject: subject,
        color: Color(
          int.parse(color),
        ),
      ),
    );

// add appointment domy data
    dommyDateList.add(
      Appointment(
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0),
        endTimeZone: '',
        startTimeZone: '',
        notes: serviceLevel,
        // isAllDay: true,
        location: "$SiteName/$serviceProvider",
        // isAllDay: true,

        // isAllDay: true,
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0),
        subject: subject,
        color: Color(
          int.parse(color),
        ),
      ),
    );
  }

  void storeDataInCSV() {
    DateTime yearStartDate =
        DateTime(DateTime.now().year, DateTime.now().month, 0);
    DateTime yearEndDate = DateTime.now().add(Duration(days: 365));
    // rows
    List<List<dynamic>> rows = [];
    //for header of csv
    List<String> rowHeader = [];

    // get all dates of year
    for (var i = 0; yearStartDate.isBefore(yearEndDate); i++) {
      if (i == 0) {
        rowHeader.add("Date");
      } else {
        rowHeader.add(
            "${yearStartDate.day} / ${yearStartDate.month} / ${yearStartDate.year}");
      }

      yearStartDate = yearStartDate.add(Duration(days: 1));
    }

    rows.add(rowHeader);

    //end of header
    // for loop for all service provider

    for (var i = 0; i < meetings.length; i++) {
      List<String> temServiceList =
          meetings[i].notes!.split('/').where((s) => s.isNotEmpty).toList();
      List<String> domyServiceList =
          meetings[i].location!.split('/').where((s) => s.isNotEmpty).toList();

      // DateTime endDate = meetings[i].startTime!.add(Duration(days: 365));
      DateTime endDate = DateTime.now().add(Duration(days: 365));
      DateTime startDate = DateTime.now();

      if (temServiceList.contains("Monthly")) {
        List<String> dataRaw = [];

        dataRaw.add("${domyServiceList[1]} (${meetings[i].subject})");

        startDate = meetings[i].startTime;

        DateTime dateTime =
            DateTime(DateTime.now().year, DateTime.now().month, 1);

        for (var j = 0; dateTime.isBefore(yearEndDate); j++) {
          if (dateTime == startDate) {
            dataRaw.add(domyServiceList[0]);
            startDate = startDate.add(Duration(days: 30));
          } else {
            dataRaw.add("");
          }

          dateTime = dateTime.add(Duration(days: 1));
        }

        rows.add(dataRaw);
      } else if (temServiceList.contains("Weekly")) {
        List<String> dataRaw = [];
        dataRaw.add("${domyServiceList[1]} (${meetings[i].subject})");

        startDate = meetings[i].startTime;

        print(startDate);
        print('-----------');

        print(yearStartDate);

        DateTime dateTime =
            DateTime(DateTime.now().year, DateTime.now().month, 1);

        for (var j = 1; dateTime.isBefore(yearEndDate); j++) {
          if (dateTime == startDate) {
            dataRaw.add(domyServiceList[0]);
            startDate = startDate.add(Duration(days: 7));
          } else {
            dataRaw.add("");
          }

          dateTime = dateTime.add(Duration(days: 1));
        }
        print(dataRaw);

        rows.add(dataRaw);
      } else if (temServiceList.contains("Fortnightly")) {
        List<String> dataRaw = [];
        dataRaw.add("${domyServiceList[1]} (${meetings[i].subject})");

        startDate = meetings[i].startTime;

        print(startDate);
        print('-----------');

        print(yearStartDate);

        DateTime dateTime =
            DateTime(DateTime.now().year, DateTime.now().month, 1);

        for (var j = 0; dateTime.isBefore(yearEndDate); j++) {
          if (dateTime == startDate) {
            dataRaw.add(domyServiceList[0]);
            startDate = startDate.add(Duration(days: 14));
          } else {
            dataRaw.add("");
          }

          dateTime = dateTime.add(Duration(days: 1));
        }
        // print(dataRaw);

        rows.add(dataRaw);
      } else if (temServiceList.contains("On Demand")) {
      } else {
        print(temServiceList[0]);
        print(meetings[i].startTime);
        print(meetings[i].subject);
        List<String> dataRaw = [];

        dataRaw.add("${domyServiceList[1]} (${meetings[i].subject})");

        startDate = meetings[i].startTime;

        print(startDate);
        print('-----------');

        print(yearStartDate);

        DateTime dateTime =
            DateTime(DateTime.now().year, DateTime.now().month, 0);

        for (var j = 0; dateTime.isBefore(yearEndDate); j++) {
          if (dateTime == startDate) {
            dataRaw.add(domyServiceList[0]);
            startDate = startDate.add(Duration(days: 7));
          } else {
            dataRaw.add("");
          }

          dateTime = dateTime.add(Duration(days: 1));
        }
        print(dataRaw);
        rows.add(dataRaw);
      }

//       String csv = const ListToCsvConverter().convert(rows);
// //this csv variable holds entire csv data
// //Now Convert or encode this csv string into utf8
//       final bytes = utf8.encode(csv);
// //NOTE THAT HERE WE USED HTML PACKAGE
//       final blob = html.Blob([bytes]);
// //It will create downloadable object
//       final url = html.Url.createObjectUrlFromBlob(blob);
// //It will create anchor to download the file
//       final anchor = html.document.createElement('a') as html.AnchorElement
//         ..href = url
//         ..style.display = 'none'
//         ..download = 'rhnosite.csv';
// //finally add the csv anchor to body
//       html.document.body?.children.add(anchor);
// // Cause download by calling this function
//       anchor.click();
// //revoke the object
//       html.Url.revokeObjectUrl(url);
//       // DateTime start = DateTime.parse(startDate);
//     }
    }

    String csv = const ListToCsvConverter().convert(rows);
//this csv variable holds entire csv data
//Now Convert or encode this csv string into utf8
    final bytes = utf8.encode(csv);
//NOTE THAT HERE WE USED HTML PACKAGE
    final blob = html.Blob([bytes]);
//It will create downloadable object
    final url = html.Url.createObjectUrlFromBlob(blob);
//It will create anchor to download the file
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'rhnosite.csv';
//finally add the csv anchor to body
    html.document.body?.children.add(anchor);
// Cause download by calling this function
    anchor.click();
//revoke the object
    html.Url.revokeObjectUrl(url);

    print("----------------------");
    print(rows.length);

    print(rows);
  }
}

//----------------------------->>

// class MyDataModel {
//   String title;
//   String description;
//   String location;
//   String startDate;
//   String endDate;

//   MyDataModel({
//     required this.title,
//     required this.description,
//     required this.location,
//     required this.startDate,
//     required this.endDate,
//   });
// }

// final List<MyDataModel> dataModels = [
//   MyDataModel(
//     title: "Meeting 1",
//     description: "Discuss project requirements",
//     location: "Conference Room A",
//     startDate: "2023-06-21T10:00:00",
//     endDate: "2023-06-21T11:00:00",
//   ),
//   MyDataModel(
//     title: "Event 1",
//     description: "Annual company party",
//     location: "Banquet Hall",
//     startDate: "2023-07-15T18:00:00",
//     endDate: "2023-07-15T23:00:00",
//   ),
//   // Add more instances of MyDataModel as needed
// ];

// class MyCustomCalendarDataSource extends CalendarDataSource {
//   final List<MyDataModel> dataModels;

//   MyCustomCalendarDataSource(this.dataModels) {
//     appointments = dataModels.map((dataModel) {
//       return CustomAppointment(
//         startTime: DateTime.parse(dataModel.startDate),
//         endTime: DateTime.parse(dataModel.endDate),
//         title: dataModel.title,
//         description: dataModel.description,
//         location: dataModel.location,
//       );
//     }).toList();
//   }
// }

// class CustomAppointment extends Appointment {
//   final String title;
//   final String description;
//   final String location;

//   CustomAppointment({
//     required DateTime startTime,
//     required DateTime endTime,
//     required this.title,
//     required this.description,
//     required this.location,
//   }) : super(startTime: startTime, endTime: endTime);
// }
