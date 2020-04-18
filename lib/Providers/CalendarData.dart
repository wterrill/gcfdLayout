import 'package:auditor/definitions/Site.dart';
import 'package:flutter/material.dart';
import 'package:auditor/definitions/Event.dart';
// import 'package:auditor/definitions/colorDefs.dart';
import 'package:auditor/definitions/siteColorTextColorLookup.dart';
import 'package:auditor/utilities/HourStringInt.dart';
import 'package:intl/intl.dart';

// This is meant to be the data that is coming in from CERES
List<List<Map<String, String>>> masterDayEvents = [
  [
    {
      'date': '04-10-2020',
      'startTime': '2020-04-10 11:00:00.000',
      'endTime': '2020-04-10 13:30:00.000',
      'message': sites[0],
      'siteName': sites[0],
      'auditType': "Audit 1",
    },
  ],
  [
    {
      'date': '04-11-2020',
      'startTime': '2020-04-11 08:00:00.000',
      'endTime': '2020-04-11 09:30:00.000',
      'message': sites[1],
      'siteName': sites[1],
      'auditType': "Audit 1",
    },
    {
      'date': '04-11-2020',
      'startTime': '2020-04-11 12:00:00.000',
      'endTime': '2020-04-11 14:45:00.000',
      'message': sites[2],
      'siteName': sites[2],
      'auditType': "Audit 2",
    }
  ],
  [
    {
      'date': '04-14-2020',
      'startTime': '2020-04-14 10:00:00.000',
      'endTime': '2020-04-14 11:30:00.000',
      'message': sites[3],
      'siteName': sites[3],
      'auditType': "Audit 3",
    },
    {
      'date': '04-14-2020',
      'startTime': '2020-04-14 12:00:00.000',
      'endTime': '2020-04-14 14:45:00.000',
      'message': sites[4],
      'siteName': sites[4],
      'auditType': "Audit 4",
    },
  ],
  [
    {
      'date': '04-15-2020',
      'startTime': '2020-04-15 12:00:00.000',
      'endTime': '2020-04-15 15:45:00.000',
      'message': sites[5],
      'siteName': sites[5],
      'auditType': auditTypes[0],
    },
  ],
  [
    {
      'date': '04-16-2020',
      'startTime': '2020-04-16 07:00:00.000',
      'endTime': '2020-04-16 08:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[1],
    },
    {
      'date': '04-16-2020',
      'startTime': '2020-04-16 09:00:00.000',
      'endTime': '2020-04-16 13:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[2],
    },
    {
      'date': '04-16-2020',
      'startTime': '2020-04-16 14:00:00.000',
      'endTime': '2020-04-16 14:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[3],
    },
    {
      'date': '04-16-2020',
      'startTime': '2020-04-16 15:00:00.000',
      'endTime': '2020-04-16 19:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[4],
    },
  ],
  [
    {
      'date': '04-17-2020',
      'startTime': '2020-04-17 08:00:00.000',
      'endTime': '2020-04-17 19:30:00.000',
      'message': sites[7],
      'siteName': sites[7],
      'auditType': auditTypes[0],
    },
    {
      'date': '04-17-2020',
      'startTime': '2020-04-17 20:00:00.000',
      'endTime': '2020-04-17 20:30:00.000',
      'message': sites[8],
      'siteName': sites[8],
      'auditType': auditTypes[1],
    },
  ],
  [
    {
      'date': '04-18-2020',
      'startTime': '2020-04-18 08:00:00.000',
      'endTime': '2020-04-18 13:30:00.000',
      'message': sites[9],
      'siteName': sites[9],
      'auditType': auditTypes[2],
    },
    {
      'date': '04-18-2020',
      'startTime': '2020-04-18 20:00:00.000',
      'endTime': '2020-04-18 20:30:00.000',
      'message': sites[10],
      'siteName': sites[10],
      'auditType': auditTypes[3],
    },
  ],
  [
    {
      'date': '04-20-2020',
      'startTime': '2020-04-20 08:00:00.000',
      'endTime': '2020-04-20 13:30:00.000',
      'message': sites[11],
      'siteName': sites[11],
      'auditType': auditTypes[4],
    },
    {
      'date': '04-20-2020',
      'startTime': '2020-04-20 19:00:00.000',
      'endTime': '2020-04-20 20:30:00.000',
      'message': sites[0],
      'siteName': sites[0],
      'auditType': auditTypes[0],
    },
  ],
  [
    {
      'date': '04-21-2020',
      'startTime': '2020-04-21 11:00:00.000',
      'endTime': '2020-04-21 13:30:00.000',
      'message': sites[0],
      'siteName': sites[0],
      'auditType': "Audit 1",
    },
  ],
  [
    {
      'date': '04-22-2020',
      'startTime': '2020-04-22 08:00:00.000',
      'endTime': '2020-04-22 09:30:00.000',
      'message': sites[1],
      'siteName': sites[1],
      'auditType': "Audit 1",
    },
    {
      'date': '04-22-2020',
      'startTime': '2020-04-22 12:00:00.000',
      'endTime': '2020-04-22 14:45:00.000',
      'message': sites[2],
      'siteName': sites[2],
      'auditType': "Audit 2",
    }
  ],
  [
    {
      'date': '04-23-2020',
      'startTime': '2020-04-23 10:00:00.000',
      'endTime': '2020-04-23 11:30:00.000',
      'message': sites[3],
      'siteName': sites[3],
      'auditType': "Audit 3",
    },
    {
      'date': '04-23-2020',
      'startTime': '2020-04-23 12:00:00.000',
      'endTime': '2020-04-23 14:45:00.000',
      'message': sites[4],
      'siteName': sites[4],
      'auditType': "Audit 4",
    },
  ],
  [
    {
      'date': '04-24-2020',
      'startTime': '2020-04-24 12:00:00.000',
      'endTime': '2020-04-24 15:45:00.000',
      'message': sites[5],
      'siteName': sites[5],
      'auditType': auditTypes[0],
    },
  ],
  [
    {
      'date': '04-25-2020',
      'startTime': '2020-04-25 07:00:00.000',
      'endTime': '2020-04-25 08:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[1],
    },
    {
      'date': '04-25-2020',
      'startTime': '2020-04-25 09:00:00.000',
      'endTime': '2020-04-25 13:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[2],
    },
    {
      'date': '04-25-2020',
      'startTime': '2020-04-25 14:00:00.000',
      'endTime': '2020-04-25 14:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[3],
    },
    {
      'date': '04-25-2020',
      'startTime': '2020-04-25 15:00:00.000',
      'endTime': '2020-04-25 19:30:00.000',
      'message': sites[6],
      'siteName': sites[6],
      'auditType': auditTypes[4],
    },
  ],
  [
    {
      'date': '04-26-2020',
      'startTime': '2020-04-26 08:00:00.000',
      'endTime': '2020-04-26 19:30:00.000',
      'message': sites[7],
      'siteName': sites[7],
      'auditType': auditTypes[0],
    },
    {
      'date': '04-26-2020',
      'startTime': '2020-04-26 20:00:00.000',
      'endTime': '2020-04-26 20:30:00.000',
      'message': sites[8],
      'siteName': sites[8],
      'auditType': auditTypes[1],
    },
  ],
  [
    {
      'date': '04-27-2020',
      'startTime': '2020-04-27 08:00:00.000',
      'endTime': '2020-04-27 13:30:00.000',
      'message': sites[9],
      'siteName': sites[9],
      'auditType': auditTypes[2],
    },
    {
      'date': '04-27-2020',
      'startTime': '2020-04-27 20:00:00.000',
      'endTime': '2020-04-27 20:30:00.000',
      'message': sites[10],
      'siteName': sites[10],
      'auditType': auditTypes[3],
    },
  ],
  [
    {
      'date': '04-28-2020',
      'startTime': '2020-04-28 08:00:00.000',
      'endTime': '2020-04-28 13:30:00.000',
      'message': sites[11],
      'siteName': sites[11],
      'auditType': auditTypes[4],
    },
    {
      'date': '04-28-2020',
      'startTime': '2020-04-28 19:00:00.000',
      'endTime': '2020-04-28 20:30:00.000',
      'message': sites[0],
      'siteName': sites[0],
      'auditType': auditTypes[0],
    },
  ],
];

List<String> sites = [
  "Manna",
  "Marillac House",
  "Irving Park",
  "Ravenswood",
  "LakeView",
  "Casa Catalina",
  "St Cyprian's",
  "Chicago Hope",
  "Care for Real",
  "Common",
  "Care for Friends",
  "New Morning Star"
];
List<String> auditTypes = [
  "Audit 1",
  "Audit 2",
  "Audit 3",
  "Audit 4",
  "Audit 5"
];

class CalendarData with ChangeNotifier {
  int todayOverlaySpot;
  List<String> days = [];
  List<String> hours = [];
  List<List<Event>> dayEvents = [];
  double rowHeight;
  bool initialized = false;

  CalendarData() {
    initializeApp();
    initializeNewCalendar();
  }

  void initializeNewCalendar() {
    rowHeight = 50.0;

    hours = [
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

    days = generateInitialWeek();
    print("days:$days");

    dayEvents = updateAppointments();
    print("dayEvents:$dayEvents");

    updateTodayOverlay();

    initialized = true;
    print(dayEvents);
    print("new notifying listeners");
    notifyListeners();
  }

  void initializeApp() {
    print("initialized CalendarData Provider... using Event");
  }

  List<String> generateInitialWeek() {
    DateTime today = DateTime.now();
    List<String> initializedWeek = createWeekFromDate(today);
    return initializedWeek;
  }

  List<String> createWeekFromDate(DateTime startingDate) {
    //take the date, find the previous Monday, and create the array from that date.
// The format for date is:  "Monday 03-09-2002",
    String dayOfWeek = DateFormat('EEEE').format(startingDate).toString();
    List<String> daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    int daysToSubtract = daysOfWeek.indexOf(dayOfWeek);
    DateTime beginningDate =
        startingDate.subtract(Duration(days: daysToSubtract));
    List<String> daysArray = [];
    for (var i = 0; i < 7; i++) {
      daysArray.add(DateFormat('EEEE MM-dd-yyyy')
          .format(beginningDate.add(Duration(days: i)))
          .toString());
    }
    return daysArray;
  }

  void changeWeek(String direction) {
    DateTime mondayDateTime = convertStringDateToDateTime(days[0]);
    DateTime differentMonday;
    if (direction == "forward")
      differentMonday = mondayDateTime.add(Duration(days: 7));
    if (direction == "backward")
      differentMonday = mondayDateTime.subtract(Duration(days: 7));
    List<String> newDaysArray = createWeekFromDate(differentMonday);
    print(newDaysArray);
    days = newDaysArray;
    dayEvents = updateAppointments();
    print('changeWeek dayEvents:$dayEvents');
    updateTodayOverlay();
    notifyListeners();
  }

  DateTime convertStringDateToDateTime(String dayDateString) {
    // Get the string in the correct format for conversion, then convert:
    String dateString = dayDateString.split(" ")[1];
    List<String> dateArray = dateString.split("-");
    String correctFormat = '${dateArray[2]}-${dateArray[0]}-${dateArray[1]}';
    print(correctFormat);
    DateTime result = DateTime.parse(correctFormat);
    return result;
  }

  void updateTodayOverlay() {
    // This places the white rectangle on the correct day column
    todayOverlaySpot = -1;
    String todayFormatted =
        DateFormat('EEEE MM-dd-yyyy').format(DateTime.now());
    print('todayFormatted: $todayFormatted');
    for (var i = 0; i < days.length; i++) {
      if (days[i] == todayFormatted) todayOverlaySpot = i + 1;
    }
    print('todayOverlaySpot: $todayOverlaySpot');
  }

  List<List<Event>> updateAppointments() {
    List<List<Event>> thisWeeksEvents = [];

    for (String dayDate in days) {
      print('dayDate:$dayDate');

      String day = dayDate.split(" ")[1];
      print('day:$day');

      List<Map<String, String>> daysRawMatch = masterDayEvents
          .firstWhere((element) => element[0]['date'] == day, orElse: () => []);
      print('daysRawMatch:$daysRawMatch');

      List<Event> daysEventMatch = convertRawToEvents(daysRawMatch);
      print('daysEventMatch:$daysEventMatch');

      if (daysEventMatch.isNotEmpty)
        thisWeeksEvents.add(daysEventMatch);
      else
        thisWeeksEvents.add([]);
    }
    return thisWeeksEvents;
  }

  // var beer = [
  //   [
  //     Event(
  //         earliestTime: TimeOfDay(
  //             hour: HourStringInt(hours[0]).hour,
  //             minute: HourStringInt(hours[0]).minute),
  //         startTime: DateTime.parse('2020-04-11 08:00:00.000'),
  //         duration: Duration(hours: 1, minutes: 30),
  //         message: "Manna",
  //         siteName: "Manna",
  //         color: ColorDefs.colorAudit1,
  //         auditType: "Audit 1",
  //         rowHeight: rowHeight),
  //     Event(
  //         earliestTime: TimeOfDay(
  //             hour: HourStringInt(hours[0]).hour,
  //             minute: HourStringInt(hours[0]).minute),
  //         startTime: DateTime.parse('2020-04-11 12:00:00.000'),
  //         duration: Duration(hours: 1, minutes: 45),
  //         message: "Marillac House",
  //         siteName: "Marillac House",
  //         color: ColorDefs.colorAudit2,
  //         auditType: "Audit 2",
  //         rowHeight: rowHeight)
  //   ],
  //   <Event>[],
  //   <Event>[],
  //   [
  //     Event(
  //         earliestTime: TimeOfDay(
  //             hour: HourStringInt(hours[0]).hour,
  //             minute: HourStringInt(hours[0]).minute),
  //         startTime: DateTime.parse('2020-04-14 08:00:00.000'),
  //         duration: Duration(hours: 1, minutes: 30),
  //         message: "Irving Park",
  //         siteName: "Irving Park",
  //         color: ColorDefs.colorAudit3,
  //         auditType: "Audit 3",
  //         rowHeight: rowHeight),
  //     Event(
  //         earliestTime: TimeOfDay(
  //             hour: HourStringInt(hours[0]).hour,
  //             minute: HourStringInt(hours[0]).minute),
  //         startTime: DateTime.parse('2020-04-14 12:00:00.000'),
  //         duration: Duration(hours: 1, minutes: 45),
  //         message: "Ravenswood",
  //         siteName: "Ravenswood",
  //         auditType: "Audit 4",
  //         color: ColorDefs.colorAudit4,
  //         rowHeight: rowHeight)
  //   ],
  //   <Event>[],
  //   <Event>[],
  //   <Event>[],
  // ];

  List<Event> convertRawToEvents(List<Map<String, String>> daysRawMatch) {
    List<Event> daysEvents = [];
    for (Map<String, String> appointment in daysRawMatch) {
      print('appointment:$appointment');
      Event event = Event(
          earliestTime: TimeOfDay(
              hour: HourStringInt(hours[0]).hour,
              minute: HourStringInt(hours[0]).minute),
          startTime: DateTime.parse(appointment['startTime']),
          duration: DateTime.parse(appointment['endTime'])
              .difference(DateTime.parse(appointment['startTime'])),
          message: appointment['message'],
          siteName: appointment['siteName'],
          auditType: appointment['auditType'],
          color: siteColorTextColorLookup(appointment['auditType'])['color']
              as Color,
          textStyle: siteColorTextColorLookup(appointment['auditType'])['text']
              as TextStyle,
          rowHeight: rowHeight,
          siteInfo: Site(siteName: appointment['siteName']));
      print('event:$event');
      daysEvents.add(event);
    }
    print('daysEvents:$daysEvents');
    return daysEvents;
  }
}
