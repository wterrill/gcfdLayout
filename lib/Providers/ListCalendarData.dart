import 'package:auditor/Definitions/ExternalDataCalendar.dart';
import 'package:auditor/Definitions/Site.dart';
import 'package:auditor/main.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:auditor/pages/ListSchedulingPage/NewAuditDialog.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/Event.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/Definitions/siteColorTextColorLookup.dart';
import 'package:auditor/utilities/HourStringInt.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'SiteData.dart';

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

  bool toggleGenerateApointments = false;

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

////////////////// Calendar Operations
  void deleteCalendarResult(CalendarResult calendarResult) {
    calendarBox.delete(
        '${calendarResult.startTime}-${calendarResult.agency}-${calendarResult.programNum}-${calendarResult.auditor}');
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

  void generateAppointments() {
    toggleGenerateApointments != toggleGenerateApointments;
    DateTime now = DateTime.now();
    DateTime pastTime = now.subtract(Duration(days: 365));
    Random random = Random();
    List<List<dynamic>> agencies =
        Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
            .rowsAsListOfValues;
    for (var i = 0; i < 800; i++) {
      int randomNumber = random.nextInt(365 * 24 * 60);
      DateTime randomDate = pastTime.add(Duration(minutes: randomNumber));
      String startTime = randomDate.toString();
      print(startTime);
      String agencyprogram =
          agencies[random.nextInt(agencies.length)][3].toString();
      print(agencyprogram);
      String agency = agencyprogram.split(" - ")[0];
      print(agency);
      String auditType = auditTypes[random.nextInt(auditTypes.length)];
      print(auditType);
      String programNum = agencyprogram.split(" - ")[1];
      print(programNum);
      String programType = programTypes[random.nextInt(programTypes.length)];
      print(programType);
      String auditor = auditors[random.nextInt(auditors.length)];
      print(auditor);
      String status =
          randomDate.isBefore(DateTime.now()) ? "Completed" : "Scheduled";
      print(status);
      addBoxEvent({
        'startTime': startTime,
        'agency': agency,
        'auditType': auditType,
        'programNum': programNum,
        'programType': programType,
        'auditor': auditor,
        'status': status
      });
    }
  }

  void deleteAllAppointments() {
    List<dynamic> calendarDynKeys = calendarBox.keys.toList();
    List<String> calendarKeys = List<String>.from(calendarDynKeys);
    for (var i = 0; i < calendarKeys.length; i++) {
      CalendarResult result =
          calendarBox.get(calendarKeys[i]) as CalendarResult;
      print(result);
      deleteCalendarResult(result);
    }
  }
}
