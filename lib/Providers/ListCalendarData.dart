import 'package:auditor/Definitions/Site.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/Event.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/siteColorTextColorLookup.dart';
import 'package:auditor/utilities/HourStringInt.dart';
import 'package:intl/intl.dart';
import 'ExternalDataCalendar.dart';

class ListCalendarData with ChangeNotifier {
  bool initialized = false;
  String filterValue = "";
  String lastFilterValue = "";

  void updateFilterValue(String value) {
    filterValue = value;
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
    print("initialized CalendarData Provider... using Event");
  }
}
