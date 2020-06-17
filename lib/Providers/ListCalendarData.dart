import 'package:auditor/Definitions/ExternalDataCalendar.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/main.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  bool initializedx = false;
  Box calendarBox;
  Box calEventToBeSent;
  String deviceid;

  List<String> auditorsList;

  bool toggleGenerateApointments = false;

  ListCalendarData() {
    initializeApp();
  }

  void initializeApp() {
    print("initialized CalendarData Provider... using Event");
    initHive();
  }

////////////////// Data Fetch, Data Save Operations

  void dataSync(
      BuildContext context, SiteList siteList, String deviceid) async {
    deviceid = deviceid;
    await getAuditors();
    await sendScheduledToCloud();
    await getScheduledFromCloud(context, siteList);
  }

  void sendScheduledToCloud() async {
    List<dynamic> dynKeys = calEventToBeSent.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult result =
          calEventToBeSent.get(toBeSentKeys[i]) as CalendarResult;

      dynamic successful =
          await ScheduleAuditComms.scheduleAudit(result, deviceid);
      if (successful as bool) calEventToBeSent.delete(toBeSentKeys[i]);
    }
  }

  void getScheduledFromCloud(BuildContext context, SiteList siteList) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    if (calendarBox.keys.toList().length == 0) {
      allNotMe = 1;
    }
    dynamic result =
        await ScheduleAuditComms.getScheduled(allNotMe, siteList, deviceid);
    List<CalendarResult> downloadedCalendarResults =
        result as List<CalendarResult>;
    if (result != null) {
      for (CalendarResult result in downloadedCalendarResults) {
        // TODO handle if result == null
        addCalendarItem(result);
      }
    }
    newEventAdded = true;
    notifyListeners();
  }

  void getAuditors() async {
    dynamic temp = await ScheduleAuditComms.getAuditors();
    auditorsList = List<String>.from(temp as List<dynamic>);
  }

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
      initializedx = true;
      notifyListeners();
    });
  }

  void addCalendarItem(CalendarResult calendarItem) {
    calendarBox.put(
        '${calendarItem.startTime}-${calendarItem.agencyName}-${calendarItem.programNum}-${calendarItem.auditor}',
        calendarItem);
  }

////////////////// Calendar Operations
  void deleteCalendarResult(CalendarResult calendarResult) {
    calendarBox.delete(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}');
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

  void addBoxEvent({Map<String, String> event, bool notify}) {
    CalendarResult newEvent = convertMapToCalendarResult(event);
    CalendarResult anotherEvent = convertMapToCalendarResult(event);

    calendarBox.put(
        '${newEvent.startTime}-${newEvent.agencyName}-${newEvent.programNum}-${newEvent.auditor}',
        newEvent);
    calEventToBeSent.put(
        '${anotherEvent.startTime}-${anotherEvent.agencyName}-${anotherEvent.programNum}-${anotherEvent.auditor}',
        anotherEvent);
    newEventAdded = true;
    if (notify) notifyListeners();
  }

  CalendarResult convertMapToCalendarResult(Map<String, String> result) {
    if (result['startTime'] == null) {
      print("here it is");
    }
    Site siteInfo =
        Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
                .siteList
                .getSiteFromAgencyNumber(agencyNumber: result['agencyNum']) ??
            Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
                .siteList
                .getSiteFromAgencyNumber(agencyNumber: "A00020");
    //TODO this try catch needs to be taken out of here... specifically the catch

    CalendarResult created = CalendarResult(
      startTime: result['startTime'],
      agencyName: result['agencyName'],
      agencyNum: result['agencyNum'],
      auditType: result['auditType'],
      programNum: result['programNum'],
      programType: result['programType'],
      auditor: result['auditor'],
      status: result['status'],
      message: result['message'],
      siteInfo:
          Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
              .siteList
              .getSiteFromAgencyNumber(agencyNumber: result['agencyNum']),
    );
    return created;
  }

  void generateAppointments(int value) {
    toggleGenerateApointments != toggleGenerateApointments;
    DateTime now = DateTime.now();
    DateTime pastTime = now.subtract(Duration(days: 325));
    Random random = Random();
    List<List<dynamic>> agencies =
        Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
            .rowsAsListOfValues;
    for (var i = 0; i < value; i++) {
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
      addBoxEvent(event: {
        'startTime': startTime,
        'agencyName': agency,
        'auditType': auditType,
        'programNum': programNum,
        'programType': programType,
        'auditor': auditor,
        'status': status
      }, notify: false);
    }
    notifyListeners();
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
    notifyListeners();
  }
}
