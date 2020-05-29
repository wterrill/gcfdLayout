import 'package:auditor/Definitions/ExternalDataCalendar.dart';
import 'package:auditor/Definitions/Site.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/Event.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/Definitions/siteColorTextColorLookup.dart';
import 'package:auditor/utilities/HourStringInt.dart';
import 'package:intl/intl.dart';

class ListCalendarData with ChangeNotifier {
  bool initialized = false;
  String filterValue = "";
  String lastFilterValue = "";
  List<Map<String, String>> masterEvents;
  bool newEventAdded = false;
  bool filterTimeToggle = false;

  void deleteCalendarResult(CalendarResult calendarResult) {
    for (var i = 0; i < masterEvents.length; i++) {
      if (masterEvents[i]['startTime'] == calendarResult.startTime &&
          masterEvents[i]['agency'] == calendarResult.agency &&
          masterEvents[i]['auditType'] == calendarResult.auditType &&
          masterEvents[i]['programNum'] == calendarResult.programNum &&
          masterEvents[i]['programType'] == calendarResult.programType &&
          masterEvents[i]['auditor'] == calendarResult.auditor &&
          masterEvents[i]['status'] == calendarResult.status) {
        masterEvents.removeAt(i);
      }
    }
    newEventAdded = true;
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

  ListCalendarData() {
    initializeApp();
    initializeNewCalendar();
  }

  void initializeNewCalendar() {
    initialized = true;
    print("new notifying listeners");
    notifyListeners();
  }

  void initializeApp() {
    masterEvents = masterDayEvents;
    print("initialized CalendarData Provider... using Event");
  }

  void addEvent(Map<String, String> event) {
    masterEvents.add(event);
    newEventAdded = true;
    notifyListeners();
  }
}
