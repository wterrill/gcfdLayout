import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/Event.dart';
// import 'package:gcfdlayout2/definitions/colorDefs.dart';
import 'package:gcfdlayout2/definitions/siteColorTextColorLookup.dart';
import 'package:gcfdlayout2/utilities/HourStringInt.dart';
import 'package:intl/intl.dart';

// This is meant to be the data that is coming in from CERES
List<List<Map<String, String>>> masterDayEvents = [
  [
    {
      'date': '04-11-2020',
      'startTime': '2020-04-11 08:00:00.000',
      'endTime': '2020-04-11 09:30:00.000',
      'message': "Manna",
      'siteName': "Manna",
      'auditType': "Audit 1",
    },
    {
      'date': '04-11-2020',
      'startTime': '2020-04-11 12:00:00.000',
      'endTime': '2020-04-11 14:45:00.000',
      'message': "Marillac House",
      'siteName': "Marillac House",
      'auditType': "Audit 2",
    }
  ],
  [
    {
      'date': '04-14-2020',
      'startTime': '2020-04-14 08:00:00.000',
      'endTime': '2020-04-14 09:30:00.000',
      'message': "Manna",
      'siteName': "Manna",
      'auditType': "Audit 1",
    },
    {
      'date': '04-14-2020',
      'startTime': '2020-04-14 12:00:00.000',
      'endTime': '2020-04-14 14:45:00.000',
      'message': "Irving Park",
      'siteName': "Irving Park",
      'auditType': "Audit 3",
    }
  ]
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
      );
      print('event:$event');
      daysEvents.add(event);
    }
    print('daysEvents:$daysEvents');
    return daysEvents;
  }
}
