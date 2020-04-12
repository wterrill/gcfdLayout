import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/EventNew.dart';
import 'package:gcfdlayout2/Utilities/HourStringInt.dart';
import 'package:gcfdlayout2/definitions/EventOld.dart';
import 'package:intl/intl.dart';
// import 'dart:async';

class CalendarData with ChangeNotifier {
  String working;
  static double rowHeight = 50.0;

  List<String> hours = [
    "6:00 am",
    "7:00 am",
    "8:00 am",
    "9:00 am",
    "10:00 am",
    "11:00 am",
    "12:00 pm",
    "1:00 pm",
    "2:00 pm",
    "3:00 pm",
    "4:00 pm",
    "5:00 pm",
    "6:00 pm",
    "7:00 pm",
    "8:00 pm",
    "9:00 pm",
    "10:00 pm",
  ];

  final List<String> days = [
    "Monday 03-09-2002",
    "Tuesday 03-10-2002",
    "Wednesday 03-11-2002",
    "Thursday 03-12-2002",
    "Friday 03-13-2002",
    "Saturday 03-14-2002",
    "Sunday 03-15-2002",
  ];

  List<List<EventNew>> dayEventsNew = [
    // [
    //   EventNew(
    //       earliestTime: TimeOfDay(
    //           hour: HourStringInt(hoursOut[0]).hour,
    //           minute: HourStringInt(hoursOut[0]).minute),
    //       startTime: DateTime.parse('2020-04-11 08:00:00.000'),
    //       duration: Duration(hours: 1, minutes: 30),
    //       siteName: "Manna",
    //       auditType: "Audit 1",
    //       rowHeight: rowHeightOut),
    //   EventNew(
    //       earliestTime: TimeOfDay(
    //           hour: HourStringInt(hoursOut[0]).hour,
    //           minute: HourStringInt(hoursOut[0]).minute),
    //       startTime: DateTime.parse('2020-04-11 12:00:00.000'),
    //       duration: Duration(hours: 1, minutes: 45),
    //       siteName: "Manna",
    //       auditType: "Audit 1",
    //       rowHeight: rowHeightOut)
    // ],
    [],
    [],
    // [
    //   EventNew(
    //       earliestTime: TimeOfDay(
    //           hour: HourStringInt(hoursOut[0]).hour,
    //           minute: HourStringInt(hoursOut[0]).minute),
    //       startTime: DateTime.parse('2020-04-14 08:00:00.000'),
    //       duration: Duration(hours: 1, minutes: 30),
    //       siteName: "Manna",
    //       auditType: "Audit 1",
    //       rowHeight: rowHeightOut),
    //   EventNew(
    //       earliestTime: TimeOfDay(
    //           hour: HourStringInt(hoursOut[0]).hour,
    //           minute: HourStringInt(hoursOut[0]).minute),
    //       startTime: DateTime.parse('2020-04-14 12:00:00.000'),
    //       duration: Duration(hours: 1, minutes: 45),
    //       siteName: "Manna",
    //       auditType: "Audit 1",
    //       rowHeight: rowHeightOut)
    // ]
  ];
  // final String message;
  // final double rowHeight;
  // // Calculated/Obtained
  // String formattedDate;
  // DateTime endTime;
  // Color color;
  // double yTop;
  // double yHeight;
  // String addressStreet;
  // String cityStateZip;
  // String phone;
  // bool visible = true;

  // @required this.earliestTime,
  //     @required this.startTime,
  //     @required this.duration,
  //     @required this.siteName,
  //     @required this.auditType,
  //     @required this.rowHeight,
  //     this.addressStreet,
  //     this.cityStateZip,
  //     this.phone,
  //     this.message

  //  )], // "Monday 03-09-2002",
  //   [], // "Tuesday 03-10-2002",
  //   [], // "Wednesday 03-11-2002",
  //   [], // "Thursday 03-12-2002",
  //   [], // "Friday 03-13-2002",
  //   [], // "Saturday 03-14-2002",
  //   [], // "Sunday 03-15-2002",

  List<List<EventOld>> dayEventsOld = [
    [], // "Monday 03-09-2002",
    [
      EventOld(
        2.5,
        4.5,
        rowHeight,
        Colors.green,
        'long green',
      )
    ], // "Tuesday 03-10-2002",
    [
      EventOld(4.25, 4.75, rowHeight, Colors.orange, 'orange'),
      EventOld(4.85, 6.0, rowHeight, Colors.blue, 'blue')
    ], // "Wednesday 03-11-2002",
    [
      EventOld(3.2, 3.7, rowHeight, Colors.indigo, 'short indigo')
    ], // "Thursday 03-12-2002",
    [], // "Friday 03-13-2002",
    [], // "Saturday 03-14-2002",
    [], // "Sunday 03-15-2002",
  ];

  // CalendarData(){

  // }

  CalendarData() {
    print("started CalendarData");
  }

///////////////////////////////////////////////////////////////////

  // List<Map<String, Object>> testArray = [
  //   {
  //     'DOW': 'Monday',
  //     'date': '03-09-2020',
  //     'appointments': [
  //       {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #1'},
  //       {'start': 8, 'color': 'yellow', 'duration': 5, 'text': 'Place #2'},
  //       {'start': 15, 'color': 'green', 'duration': 7, 'text': 'Place #3'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Tuesday',
  //     'date': '03-10-2020',
  //     'appointments': [
  //       {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #4'},
  //       // {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #5'},
  //       {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #6'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Thursday',
  //     'date': '03-12-2020',
  //     'appointments': [
  //       {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #10'},
  //       {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #11'},
  //       // {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #12'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Friday',
  //     'date': '03-13-2020',
  //     'appointments': [
  //       // {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #13'},
  //       {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #14'},
  //       {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #15'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Monday',
  //     'date': '03-16-2020',
  //     'appointments': [
  //       {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #1'},
  //       {'start': 8, 'color': 'yellow', 'duration': 5, 'text': 'Place #2'},
  //       {'start': 15, 'color': 'green', 'duration': 7, 'text': 'Place #3'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Tuesday',
  //     'date': '03-17-2020',
  //     'appointments': [
  //       {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #4'},
  //       // {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #5'},
  //       {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #6'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Thursday',
  //     'date': '03-19-2020',
  //     'appointments': [
  //       {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #10'},
  //       {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #11'},
  //       // {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #12'},
  //     ]
  //   },
  //   {
  //     'DOW': 'Friday',
  //     'date': '03-20-2020',
  //     'appointments': [
  //       // {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #13'},
  //       {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #14'},
  //       {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #15'},
  //     ]
  //   },
  // ];

}
