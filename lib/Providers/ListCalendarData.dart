import 'package:auditor/Definitions/AuditorClasses/Auditor.dart';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';

import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/main.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'SiteData.dart';

List<String> auditTypes = [
  //'Select'
  "Annual",
  "Food Rescue",
  "CEDA",
  "Bi-Annual",
  "Complaint",
  "Follow Up",
  "Grant"
];

List<String> programTypes = [
  "Healthy Student Market",
  "Senior Adults Program",
  "Pantry Audit",
  "Congregate Audit"
];

class ListCalendarData with ChangeNotifier {
  String filterValue = "";
  String lastFilterValue = "";
  List<Map<String, String>> masterEvents;
  bool newEventAdded = false;
  bool filterTimeToggle = false;

  Box box;
  bool initializedx = false;
  Box calendarBox;
  Box calToBeSentBox;
  Box calToBeDeletedBox;
  Box auditorsListBox;
  String deviceidProvider;

  AuditorList auditorList;

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
    deviceidProvider = deviceid;
    await getAuditors();
    await deleteFromCloud();
    // await Future.delayed(Duration(milliseconds: 3000), () => true);
    await sendScheduledToCloud();
    await getScheduledFromCloud(context, siteList);
  }

  void sendScheduledToCloud() async {
    List<dynamic> dynKeys = calToBeSentBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult result =
          calToBeSentBox.get(toBeSentKeys[i]) as CalendarResult;

      dynamic successful = await ScheduleAuditComms.scheduleAudit(result, "A");
      // print(calToBeSentBox.keys);
      if (successful as bool) calToBeSentBox.delete(toBeSentKeys[i]);
      // print(calToBeSentBox.keys);
    }
  }

  void deleteFromCloud() async {
    List<dynamic> dynKeys = calToBeDeletedBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      // print(calToBeDeletedBox.keys);
      CalendarResult result =
          calToBeDeletedBox.get(toBeSentKeys[i]) as CalendarResult;
      result.deviceid = deviceidProvider;
      // print(calToBeDeletedBox.keys);
      dynamic successful = await ScheduleAuditComms.scheduleAudit(result, "D");
      // print(calToBeDeletedBox.keys);
      if (successful as bool) calToBeDeletedBox.delete(toBeSentKeys[i]);
      // print(calToBeDeletedBox.keys);
    }
  }

  void getScheduledFromCloud(BuildContext context, SiteList siteList) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    if (calendarBox.keys.toList().length == 0) {
      allNotMe = 1;
    }
    dynamic result = await ScheduleAuditComms.getScheduled(
        allNotMe, siteList, deviceidProvider);
    List<CalendarResult> downloadedCalendarResults =
        result as List<CalendarResult>;
    if (result != null) {
      for (CalendarResult result in downloadedCalendarResults) {
        // TODO handle if result == null
        if (result.status != -1 && result.status != "Deleted") {
          addCalendarItem(result);
        } else {
          deleteCalendarItem(result);
        }
      }
    }
    newEventAdded = true;
    notifyListeners();
  }

  void getAuditors() async {
    dynamic temp = await ScheduleAuditComms.getAuditors();
    auditorList = temp as AuditorList;
    saveAuditors(auditorList);
  }

////////////////// Hive operations

  void initHive() {
    Future calendarFuture = Hive.openBox<CalendarResult>('calendarBox');
    Future calToBeSentBoxFuture =
        Hive.openBox<CalendarResult>('calToBeSentBox');
    Future calEventToBeDeletedFuture =
        Hive.openBox<CalendarResult>('calToBeDeletedBox');
    Future auditorsListBoxFuture = Hive.openBox<AuditorList>('auditorsListBox');
    Future.wait<dynamic>([
      calendarFuture,
      calToBeSentBoxFuture,
      calEventToBeDeletedFuture,
      auditorsListBoxFuture
    ]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      calendarBox = Hive.box<CalendarResult>('calendarBox');
      calToBeSentBox = Hive.box<CalendarResult>('calToBeSentBox');
      calToBeDeletedBox = Hive.box<CalendarResult>('calToBeDeletedBox');
      auditorsListBox = Hive.box<AuditorList>('auditorsListBox');
      loadAuditorsFromBox();
      initializedx = true;
      notifyListeners();
    });
  }

  void addCalendarItem(CalendarResult calendarItem) {
    // print(calendarBox.keys);
    calendarBox.put(
        '${calendarItem.startTime}-${calendarItem.agencyName}-${calendarItem.programNum}-${calendarItem.auditor}',
        calendarItem);
    // print(calendarBox.keys);
    newEventAdded = true;
    notifyListeners();
  }

  void saveAuditors(AuditorList auditorsList) {
    auditorsListBox.put("auditorsList", auditorsList);
  }

  void loadAuditorsFromBox() {
    auditorList =
        auditorsListBox.get("auditorsList") as AuditorList; // RESTORE AUDITORS
  }

////////////////// Calendar Operations

  void deleteCalendarItem(CalendarResult calendarResult) {
    calendarBox.delete(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}');
    // print(calendarBox.keys);
    // print(calToBeSentBox.keys);
    calToBeSentBox.delete(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}');
    // print(calToBeSentBox.keys);
    // print(calToBeDeletedBox.keys);
    calToBeDeletedBox.put(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}',
        calendarResult);
    newEventAdded = true;
    // print(calToBeDeletedBox.keys);
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
    // print(calendarBox.keys);
    calendarBox.put(
        '${newEvent.startTime}-${newEvent.agencyName}-${newEvent.programNum}-${newEvent.auditor}',
        newEvent);
    // print(calendarBox.keys);
    // print(calToBeSentBox.keys);
    calToBeSentBox.put(
        '${anotherEvent.startTime}-${anotherEvent.agencyName}-${anotherEvent.programNum}-${anotherEvent.auditor}',
        anotherEvent);
    // print(calToBeSentBox.keys);
    newEventAdded = true;
    if (notify) notifyListeners();
  }

  CalendarResult convertMapToCalendarResult(Map<String, String> result) {
    if (result['startTime'] == null) {
      print("here it is");
    }
    // Site siteInfo =
    //     Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
    //             .siteList
    //             .getSiteFromAgencyNumber(agencyNumber: result['agencyNum']) ??
    //         Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
    //             .siteList
    //             .getSiteFromAgencyNumber(agencyNumber: "A00020");
    // String deviceid = deviceidProvider;
    // Provider.of<GeneralData>(navigatorKey.currentContext, listen: false)
    //     .deviceid;
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
      deviceid: deviceidProvider,
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
    SiteList siteList =
        Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
            .siteList;
    // Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
    //     .rowsAsListOfValues;
    for (var i = 0; i < value; i++) {
      int randomNumber = random.nextInt(365 * 24 * 60);
      DateTime randomDate = pastTime.add(Duration(minutes: randomNumber));
      String startTime = DateFormat('yyyy-MM-dd kk:mm:ss.000')
          .format(DateTime.parse(randomDate.toString()));
      print(startTime);
      Site randomSite = siteList.getRandom();
      String agency = randomSite.agencyName;
      String agencyNum = randomSite.agencyNumber;
      List<String> programlist = randomSite.programDisplayName.split(" - ");
      String programNum = programlist[programlist.length - 1];

      String auditType = auditTypes[random.nextInt(auditTypes.length)];
      print(auditType);

      String programType = programTypes[random.nextInt(programTypes.length)];
      print(programType);
      Auditor auditor =
          Provider.of<ListCalendarData>(navigatorKey.currentContext)
              .auditorList
              .getRandom();

      print(auditor);
      String status =
          randomDate.isBefore(DateTime.now()) ? "Completed" : "Scheduled";
      print(status);
      addBoxEvent(event: {
        'startTime': startTime,
        'agencyName': agency,
        'agencyNum': agencyNum,
        'auditType': auditType,
        'programNum': programNum,
        'programType': programType,
        'auditor': auditor.toString(),
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
      deleteCalendarItem(result);
    }
    notifyListeners();
  }
}
