import 'package:auditor/Definitions/AuditorClasses/Auditor.dart';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';

import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/main.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'BuildScheduledFromIncoming.dart';
import 'BuildScheduledToSend.dart';
import 'SiteData.dart';
import 'package:collection/collection.dart';

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
  Box calendarOutBox;
  Box calendarDeleteBox;
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
    List<dynamic> dynKeys = calendarOutBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult preResult =
          calendarOutBox.get(toBeSentKeys[i]) as CalendarResult;
      String jsonResult = buildScheduledToSend(preResult, "A");
      dynamic successful = await ScheduleAuditComms.scheduleAudit(jsonResult);
      if (successful as bool) calendarOutBox.delete(toBeSentKeys[i]);
    }
  }

  void deleteFromCloud() async {
    List<dynamic> dynKeys = calendarDeleteBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      // print(calToBeDeletedBox.keys);
      CalendarResult result =
          calendarDeleteBox.get(toBeSentKeys[i]) as CalendarResult;
      result.deviceid = deviceidProvider;
      String jsonResult = buildScheduledToSend(result, "D");
      dynamic successful = await ScheduleAuditComms.scheduleAudit(jsonResult);
      // print(calToBeDeletedBox.keys);
      if (successful as bool) calendarDeleteBox.delete(toBeSentKeys[i]);
      // print(calToBeDeletedBox.keys);
    }
  }

  void getScheduledFromCloud(BuildContext context, SiteList siteList) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    if (calendarBox.keys.toList().length == 0) {
      allNotMe = 1;
    }

    dynamic dynResult =
        await ScheduleAuditComms.getScheduled(allNotMe, deviceidProvider);

    List<CalendarResult> downloadedCalendarResults =
        buildScheduledFromIncoming(dynResult, siteList);
    // TODO update old followup to Complete, if followup scheduled.
    for (CalendarResult result in downloadedCalendarResults) {
      if (result.auditType == "Follow Up") {
        Map<String, dynamic> pastEvent =
            result.citationsToFollowUp['PreviousEvent'] as Map<String, dynamic>;
        List<String> oldEvent = [
          pastEvent["AgencyNumber"] as String,
          pastEvent['ProgramNumber'] as String,
          DateTime.parse(pastEvent['StartTime'] as String).toString()
        ];
        for (CalendarResult result in downloadedCalendarResults) {
          List<String> newEvent = [
            result.agencyNum,
            result.programNum,
            result.startDateTime.toString()
          ];
          if (newEvent.toString().compareTo(oldEvent.toString()) == 0) {
            // we found a match, update status to complete
            result.status = "Completed";
            print("complete");
            // break;
          }
        }
        CalendarResult junkCalendarResult = CalendarResult(
          startTime: pastEvent['StartTime'] as String,
          agencyName: pastEvent['AgencyName'] as String,
          agencyNum: pastEvent['AgencyNumber'] as String,
          auditType: convertNumberToAuditType(
              int.parse(pastEvent['AuditType'] as String)),
          programNum: pastEvent['ProgramNumber'] as String,
          programType: convertNumberToProgramType(
              int.parse(pastEvent['ProgramType'] as String)),
          auditor: pastEvent['Auditor'] as String,
          status: null,
          message: null,
          deviceid: null,
          siteInfo: null,
          citationsToFollowUp: null,
        );
        updateStatusOnScheduleToCompleted(junkCalendarResult);

        print(pastEvent);
      }
    }

    if (dynResult != null) {
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
      calendarOutBox = Hive.box<CalendarResult>('calToBeSentBox');
      calendarDeleteBox = Hive.box<CalendarResult>('calToBeDeletedBox');
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
    calendarOutBox.delete(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}');
    calendarDeleteBox.put(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}',
        calendarResult);
    newEventAdded = true;
    notifyListeners();
  }

  void updateFilterValue(String value) {
    filterValue = value;
    notifyListeners();
  }

  void updateStatusOnScheduleToCompleted(CalendarResult calendarResult) {
    CalendarResult retrievedSchedule = calendarBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}')
        as CalendarResult;
    // CalendarResult retrievedScheduleToSend = retrievedSchedule.clone();
    CalendarResult retrievedScheduleToSend = calendarOutBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}')
        as CalendarResult;
    retrievedSchedule.status = "Completed";
    try {
      retrievedScheduleToSend.status = "Completed";
      calendarOutBox.put(
          '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}',
          retrievedScheduleToSend);
    } catch (err) {
      print("audit not waiting to be sent");
    }
    calendarBox.put(
        '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}',
        retrievedSchedule);
    notifyListeners();
  }

  void toggleFilterTimeToggle() {
    filterTimeToggle = !filterTimeToggle;
    newEventAdded = true;
    notifyListeners();
  }

  void addBoxEvent({
    Map<String, dynamic> event,
    bool notify,
  }) {
    CalendarResult newEvent = convertMapToCalendarResult(event);
    CalendarResult anotherEvent = convertMapToCalendarResult(event);
    // Map<String,dynamic> anotherEvent = JSON.decode(JSON.encode(newEvent));
    calendarBox.put(
        '${newEvent.startTime}-${newEvent.agencyName}-${newEvent.programNum}-${newEvent.auditor}',
        newEvent);
    calendarOutBox.put(
        '${anotherEvent.startTime}-${anotherEvent.agencyName}-${anotherEvent.programNum}-${anotherEvent.auditor}',
        anotherEvent);
    newEventAdded = true;
    if (notify) notifyListeners();
  }

  CalendarResult convertMapToCalendarResult(Map<String, dynamic> result) {
    if (result['startTime'] == null) {
      print("here it is");
    }

    CalendarResult created = CalendarResult(
      startTime: result['startTime'] as String,
      agencyName: result['agencyName'] as String,
      agencyNum: result['agencyNum'] as String,
      auditType: result['auditType'] as String,
      programNum: result['programNum'] as String,
      programType: result['programType'] as String,
      auditor: result['auditor'] as String,
      status: result['status'] as String,
      message: result['message'] as String,
      deviceid: deviceidProvider,
      siteInfo: Provider.of<SiteData>(navigatorKey.currentContext,
              listen: false)
          .siteList
          .getSiteFromAgencyNumber(agencyNumber: result['agencyNum'] as String),
      citationsToFollowUp:
          result['citationsToFollowUp'] as Map<String, dynamic>,
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
          randomDate.isBefore(DateTime.now()) ? "Submitted" : "Scheduled";
      print(status);
      addBoxEvent(event: <String, dynamic>{
        'startTime': startTime,
        'agencyName': agency,
        'agencyNum': agencyNum,
        'auditType': auditType,
        'programNum': programNum,
        'programType': programType,
        'auditor': auditor.toString(),
        'status': status,
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
