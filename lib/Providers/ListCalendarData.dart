import 'package:auditor/Definitions/ExternalDataCalendar.dart';
import 'package:auditor/Definitions/Site.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/Event.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/Definitions/siteColorTextColorLookup.dart';
import 'package:auditor/utilities/HourStringInt.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ListCalendarData with ChangeNotifier {
  String filterValue = "";
  String lastFilterValue = "";
  List<Map<String, String>> masterEvents;
  bool newEventAdded = false;
  bool filterTimeToggle = false;

  Box box;
  bool initialized = false;
  Box calendarBox;
  Box calEventToBeSent;

  ListCalendarData() {
    initializeApp();
    // initializeNewCalendar();
  }

  void initializeApp() {
    masterEvents = masterDayEvents;
    print("initialized CalendarData Provider... using Event");
    initHive();
  }

////////////////// Data Fetch, Data Save Operations

  void fetchData() {}

////////////////// Hive operations

  void initHive() {
    Future calendarFuture = Hive.openBox<CalendarResult>('calendarBox');
    Future calEventToBeSentFuture =
        Hive.openBox<CalendarResult>('calEventToBeSent');
    Future.wait<dynamic>([calendarFuture, calEventToBeSentFuture])
        .then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      calendarBox = Hive.box<CalendarResult>('calendarBox');
      calEventToBeSent = Hive.box<CalendarResult>('calEventToBeSent');

      var beer = calendarBox.values.toList() as List<CalendarResult>;
      print(beer);
      initialized = true;
      notifyListeners();
    });
  }

  void addCalendarItem(CalendarResult calendarItem) {
    calendarBox.add(calendarItem);
  }

  // if (initialized) {
  //     Box box = Hive.box<CalendarResult>('calendar');
  //     // var beer = box.get('results');
  //     var beer = box.get(0);

  //     if (beer != null) {
  //       results = box.values.toList();
  //     } else {
  //       for (var result in results) {
  //         box.add(result);
  //       }
  //     }
  //   }

////////////////// Calendar Operations
  void deleteCalendarResult(CalendarResult calendarResult) {
    calendarBox.delete(
        '${calendarResult.startTime}-${calendarResult.agency}-${calendarResult.programNum}-${calendarResult.auditor}');
    // for (var i = 0; i < calendarBox.values.length; i++) {
    //   CalendarResult value = calendarBox.get(i) as CalendarResult;
    //   if (value == null) {
    //     print("space in calendarBox at: $i");
    //   } else if (value.startTime == calendarResult.startTime &&
    //       value.agency == calendarResult.agency &&
    //       value.auditType == calendarResult.auditType &&
    //       value.programNum == calendarResult.programNum &&
    //       value.programType == calendarResult.programType &&
    //       value.auditor == calendarResult.auditor &&
    //       value.status == calendarResult.status) {
    //     calendarBox.delete(i);
    //   }
    // }
    newEventAdded = true;
    // calendarBox.compact();
    notifyListeners();
  }

  void updateFilterValue(String value) {
    filterValue = value;
    notifyListeners();
  }

  void toggleFilterTimeToggle() {
    filterTimeToggle = !filterTimeToggle;
    newEventAdded = true;
    notifyListeners();
  }

  // void initializeNewCalendar() {
  // initialized = true;
  // print("new notifying listeners");
  // notifyListeners();
  // }

  // void addEvent(Map<String, String> event) {
  //   masterEvents.add(event);
  //   newEventAdded = true;
  //   notifyListeners();
  // }

  void addBoxEvent(Map<String, String> event) {
    CalendarResult newEvent = convertMapToCalendarResult(event);
    CalendarResult anotherEvent = convertMapToCalendarResult(event);
    calendarBox.put(
        '${newEvent.startTime}-${newEvent.agency}-${newEvent.programNum}-${newEvent.auditor}',
        newEvent);
    calEventToBeSent.put(
        '${anotherEvent.startTime}-${anotherEvent.agency}-${anotherEvent.programNum}-${anotherEvent.auditor}',
        anotherEvent);
    newEventAdded = true;
    notifyListeners();
  }

  CalendarResult convertMapToCalendarResult(Map<String, String> result) {
    return CalendarResult(
      startTime: result['startTime'],
      agency: result['agency'],
      auditType: result['auditType'],
      programNum: result['programNum'],
      programType: result['programType'],
      auditor: result['auditor'],
      status: result['status'],
      message: result['message'],
    );
  }
}
