import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';
import 'package:table_calendar/table_calendar.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

final List<BoxShadow>? shadow = [
  BoxShadow(
    color: blackColor.withOpacity(0.05),
    spreadRadius: 0,
    blurRadius: 5,
    offset: Offset(0, 4), // changes position of shadow
  ),
];
Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 50, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 50, kToday.day);




Future<void> storeData() async {
}






class upload extends StatefulWidget {
  const upload({super.key});

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  bool x = true;
  List<List<dynamic>> _data = [];

  FirebaseFirestore _db = FirebaseFirestore.instance;

  void _loadCSV() async {
    bool x = false;
    setState(() {});
    print('gffffffffffffffffffffffffff');
  
    // log('Length of the collection: ${querySnapshot.docs.length}');

   final _rawData = await rootBundle.loadString("assets/Result.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);

    for (int index = 0; index < _listData.length; index++) {
      List<dynamic> row = _listData[index];
      try {
        String title = row[0].toString();
        List<String> nameIndex = [];

        for (int i = 0; i < title.length; i++) {
          String substring = title.substring(0, i + 1);
          nameIndex.add(substring);
        }

        await _db.collection('Police_Records').doc((index+22321).toString()).set({
          'Record ID': row[0]?? '',
          'FirstName': row[1]?? '',
          'LastName': row[2]?? '',
          'Email': row[3]?? '',
          'Phone Number': row[4]?? '',
          'Contact owner': row[5]?? '',
          'TotalComplaints': row[6]??   '',
          'SubstantiatedComplaints': row[7]?? '',
          'Location': row[8]?? '',
          'PDF': row[9]?? '',
          'Error': row[10]?? '',
          'nameIndex': nameIndex,
        });

        log('Uploaded collection at index ${index+22321}');
      } catch (e) {
        // Handle any errors during the upload
        print('Error uploading data at index $index: $e');
      }
    }

    print('Data uploaded successfully!');
    print('hi');

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Testing"),
      ),
      body: Column(
        children: [x ? Container() : CircularProgressIndicator()],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: _loadCSV),
      // Display the contents from the CSV file
    );
  }
}