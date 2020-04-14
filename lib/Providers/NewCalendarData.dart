import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/NewEvent.dart';
import 'package:gcfdlayout2/definitions/colorDefs.dart';
import 'package:gcfdlayout2/utilities/HourStringInt.dart';
// import 'package:intl/intl.dart';

class NewCalendarData with ChangeNotifier {
  List<String> days = [];
  List<String> hours = [];
  List<List<NewEvent>> dayNewEvents = [];
  double rowHeight;
  bool initialized = false;

  NewCalendarData() {
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

    days = [
      "Monday 03-09-2002",
      "Tuesday 03-10-2002",
      "Wednesday 03-11-2002",
      "Thursday 03-12-2002",
      "Friday 03-13-2002",
      "Saturday 03-14-2002",
      "Sunday 03-15-2002",
    ];

    dayNewEvents = [
      [
        NewEvent(
            earliestTime: TimeOfDay(
                hour: HourStringInt(hours[0]).hour,
                minute: HourStringInt(hours[0]).minute),
            startTime: DateTime.parse('2020-04-11 08:00:00.000'),
            duration: Duration(hours: 1, minutes: 30),
            message: "I'm alive",
            siteName: "Manna",
            color: ColorDefs.colorAudit1,
            auditType: "Audit 1",
            rowHeight: rowHeight),
        NewEvent(
            earliestTime: TimeOfDay(
                hour: HourStringInt(hours[0]).hour,
                minute: HourStringInt(hours[0]).minute),
            startTime: DateTime.parse('2020-04-11 12:00:00.000'),
            duration: Duration(hours: 1, minutes: 45),
            message: "I'm alive",
            siteName: "Manna",
            color: ColorDefs.colorAudit2,
            auditType: "Audit 2",
            rowHeight: rowHeight)
      ],
      [],
      [],
      [
        NewEvent(
            earliestTime: TimeOfDay(
                hour: HourStringInt(hours[0]).hour,
                minute: HourStringInt(hours[0]).minute),
            startTime: DateTime.parse('2020-04-14 08:00:00.000'),
            duration: Duration(hours: 1, minutes: 30),
            message: "I'm alive",
            siteName: "Manna",
            color: ColorDefs.colorAudit3,
            auditType: "Audit 3",
            rowHeight: rowHeight),
        NewEvent(
            earliestTime: TimeOfDay(
                hour: HourStringInt(hours[0]).hour,
                minute: HourStringInt(hours[0]).minute),
            startTime: DateTime.parse('2020-04-14 12:00:00.000'),
            duration: Duration(hours: 1, minutes: 45),
            message: "I'm alive",
            siteName: "Manna",
            auditType: "Audit 4",
            color: ColorDefs.colorAudit4,
            rowHeight: rowHeight)
      ],
      [],
      [],
      [],
    ];

    initialized = true;
    print(dayNewEvents);
    print("new notifying listeners");
    notifyListeners();
  }

  void initializeApp() {
    print("initialized NewCalendarData Provider... using NewEvent");
  }
}
