import 'package:auditor/Definitions/AuditorClasses/Auditor.dart';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';
// import 'package:auditor/Definitions/Dialogs.dart';

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
import 'package:connectivity/connectivity.dart';

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

List<String> programTypes = ["Healthy Student Market", "Senior Adults Program", "Pantry", "Congregate"];

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
  Box calendarEditOutBox;
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

  void dataSync({BuildContext context, SiteList siteList, String deviceid, bool fullSync}) async {
    deviceidProvider = deviceid;

    await getAuditors();

    await deleteFromCloud(deviceid);

    await sendEditedScheduledToCloud(deviceid);

    await sendScheduledToCloud(deviceid);

    await getScheduledFromCloud(context: context, siteList: siteList, fullSync: fullSync);
  }

  void forceScheduleDataUpload({String deviceid}) {
    List<dynamic> dynKeys = calendarBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult preResult = calendarBox.get(toBeSentKeys[i]) as CalendarResult;
      CalendarResult anotherEvent = preResult.clone();

      DateTime temp = DateTime.parse(anotherEvent.startTime);
      calendarOutBox.put(
          '${temp.toString()}-${anotherEvent.agencyName}-${anotherEvent.programNum}-${anotherEvent.auditor}-${anotherEvent.auditType}',
          anotherEvent);
    }
    sendScheduledToCloud(deviceid);
  }

  void sendScheduledToCloud(String deviceid) async {
    List<dynamic> dynKeys = calendarOutBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult preResult = calendarOutBox.get(toBeSentKeys[i]) as CalendarResult;
      String jsonResult = buildScheduledToSend(preResult, "A", deviceid);
      dynamic successful = false;

      try {
        // import 'package:connectivity/connectivity.dart';
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED scheduleAudit list #########");
        } else {
          throw ("No internet connection found");
        }
        successful = await ScheduleAuditComms.scheduleAudit(jsonResult);
      } catch (err) {
        print(err);
        successful = false;
      }
      if (successful as bool) calendarOutBox.delete(toBeSentKeys[i]);
    }
  }

  void sendEditedScheduledToCloud(String deviceid) async {
    List<dynamic> dynKeys = calendarEditOutBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult preResult = calendarEditOutBox.get(toBeSentKeys[i]) as CalendarResult;
      String jsonResult = buildScheduledToSend(preResult, "E", deviceid);
      dynamic successful = false;

      try {
        // import 'package:connectivity/connectivity.dart';
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED schedul audit  list #########");
        } else {
          throw ("No internet connection found");
        }
        successful = await ScheduleAuditComms.scheduleAudit(jsonResult);
      } catch (err) {
        print(err);
        successful = false;
      }
      if (successful as bool) calendarEditOutBox.delete(toBeSentKeys[i]);
    }
  }

  void deleteFromCloud(String deviceid) async {
    List<dynamic> dynKeys = calendarDeleteBox.keys.toList();

    List<String> toBeSentKeys = List<String>.from(dynKeys);

    for (var i = 0; i < toBeSentKeys.length; i++) {
      // print(calToBeDeletedBox.keys);
      CalendarResult result = calendarDeleteBox.get(toBeSentKeys[i]) as CalendarResult;
      result.deviceid = deviceidProvider;
      String jsonResult = buildScheduledToSend(result, "D", deviceid);
      dynamic successful = false;

      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED schedule audit  #########");
        } else {
          throw ("No internet connection found");
        }

        successful = await ScheduleAuditComms.scheduleAudit(jsonResult);
      } catch (err) {
        print(err);
        successful = false;
      }
      // print(calToBeDeletedBox.keys);
      if (successful as bool) calendarDeleteBox.delete(toBeSentKeys[i]);
      // print(calToBeDeletedBox.keys);
    }
  }

  void getScheduledFromCloud({BuildContext context, SiteList siteList, bool fullSync}) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    print("### ### ### fullSync getScheduledFromCloud = $fullSync");
    if (calendarBox.keys.toList().length == 0 || fullSync == true) {
      allNotMe = 1;
    }

    print("### ### ### allNotMe getScheduledFromCloud = $allNotMe");
    dynamic dynResult = false;
    try {
      // import 'package:connectivity/connectivity.dart';
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a mobile network. or a wifi network
        print("######### CONNECTED get scheduled #########");
      } else {
        throw ("No internet connection found");
      }
      dynResult = await ScheduleAuditComms.getScheduled(allNotMe, deviceidProvider);
    } catch (err) {
      print(err);
      dynResult = false;
    }

    List<CalendarResult> downloadedCalendarResults = buildScheduledFromIncoming(dynResult, siteList);
    for (CalendarResult result in downloadedCalendarResults) {
      if (result.auditType == "Follow Up") {
        Map<String, dynamic> pastEvent = result.citationsToFollowUp['PreviousEvent'] as Map<String, dynamic>;
        List<String> oldEvent = [
          pastEvent["AgencyNumber"] as String,
          pastEvent['ProgramNumber'] as String,
          DateTime.parse(pastEvent['StartTime'] as String).toString()
        ];
        for (CalendarResult result in downloadedCalendarResults) {
          List<String> newEvent = [result.agencyNum, result.programNum, result.startDateTime.toString()];
          if (newEvent.toString().compareTo(oldEvent.toString()) == 0) {
            // we found a match, update status to complete
            result.status = "Completed";
            print("complete");
            // break;
          }
        }

        String programTypeString;
        String auditTypeString;
        try {
          int number = int.parse(pastEvent['AuditType'] as String);
          int number2 = int.parse(pastEvent['ProgramType'] as String);
          // it's a number as a string
          programTypeString = convertNumberToProgramType(number2);
          auditTypeString = convertNumberToAuditType(number);
        } catch (err) {
          // it's a string;
          programTypeString = pastEvent['ProgramType'] as String;
          auditTypeString = pastEvent['AuditType'] as String;
        }
        CalendarResult junkCalendarResult = CalendarResult(
          startTime: pastEvent['StartTime'] as String,
          agencyName: pastEvent['AgencyName'] as String,
          agencyNum: pastEvent['AgencyNumber'] as String,
          auditType: auditTypeString,
          programNum: pastEvent['ProgramNumber'] as String,
          programType: programTypeString,
          auditor: pastEvent['Auditor'] as String,
          status: null,
          message: null,
          deviceid: null,
          siteInfo: null,
          citationsToFollowUp: null,
        );
        updateStatusOnScheduleToCompleted(junkCalendarResult);

        print(pastEvent);
        notifyListeners();
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
    if (downloadedCalendarResults.length != 0) {
      newEventAdded = true;
      notifyListeners();
    }
  }

  void getAuditors() async {
    dynamic temp = null;

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a mobile network. or a wifi network
        print("######### CONNECTED get auditors #########");
      } else {
        throw ("No internet connection found");
      }
      temp = await ScheduleAuditComms.getAuditors();
    } catch (err) {
      print(err);
      temp = null;
    }
    if (temp != Null) {
      auditorList = temp as AuditorList;
      saveAuditors(auditorList);
      notifyListeners();
    }
  }

////////////////// Hive operations

  void initHive() {
    Future calendarFuture = Hive.openBox<CalendarResult>('calendarBox');
    Future calToBeSentBoxFuture = Hive.openBox<CalendarResult>('calToBeSentBox');
    Future calEventToBeDeletedFuture = Hive.openBox<CalendarResult>('calToBeDeletedBox');
    Future auditorsListBoxFuture = Hive.openBox<AuditorList>('auditorsListBox');
    Future calendarEditOutBoxFuture = Hive.openBox<CalendarResult>('calendarEditOutBox');
    Future.wait<dynamic>([
      calendarFuture,
      calToBeSentBoxFuture,
      calEventToBeDeletedFuture,
      auditorsListBoxFuture,
      calendarEditOutBoxFuture
    ]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      calendarBox = Hive.box<CalendarResult>('calendarBox');
      calendarOutBox = Hive.box<CalendarResult>('calToBeSentBox');
      calendarDeleteBox = Hive.box<CalendarResult>('calToBeDeletedBox');
      auditorsListBox = Hive.box<AuditorList>('auditorsListBox');
      calendarEditOutBox = Hive.box<CalendarResult>('calendarEditOutBox');
      loadAuditorsFromBox();
      initializedx = true;
      notifyListeners();
    });
  }

  void addCalendarItem(CalendarResult calendarItem) {
    // print(calendarBox.keys);
    CalendarResult clonedCalendarResult = calendarItem.clone();
    CalendarResult retrievedCalendarItem = calendarBox.get(
            '${clonedCalendarResult.startTime}-${clonedCalendarResult.agencyName}-${clonedCalendarResult.programNum}-${clonedCalendarResult.auditor}-${clonedCalendarResult.auditType}')
        as CalendarResult;
    if (retrievedCalendarItem != null) {
      if (convertStatusToNumber(retrievedCalendarItem.status) <= convertStatusToNumber(clonedCalendarResult.status)) {
        //this gets rid of the "T"
        DateTime temp = DateTime.parse(clonedCalendarResult.startTime);
        // calendarBox.delete(
        //     '${temp.toString()}-${clonedCalendarResult.agencyName}-${clonedCalendarResult.programNum}-${clonedCalendarResult.auditor}-${clonedCalendarResult.auditType}');
        calendarBox.put(
            '${temp.toString()}-${clonedCalendarResult.agencyName}-${clonedCalendarResult.programNum}-${clonedCalendarResult.auditor}-${clonedCalendarResult.auditType}',
            clonedCalendarResult);
        // print(calendarBox.keys);
        newEventAdded = true;
        notifyListeners();
      }
    } else {
      //temp gets rid of the "T"
      DateTime temp = DateTime.parse(calendarItem.startTime);
      calendarBox.put(
          '${temp.toString()}-${calendarItem.agencyName}-${calendarItem.programNum}-${calendarItem.auditor}-${calendarItem.auditType}',
          calendarItem);
      // print(calendarBox.keys);
      newEventAdded = true;
      notifyListeners();
    }
  }

  void addCalendarEditItem(CalendarResult calendarItem) {
    CalendarResult calendarResult = calendarItem.clone();
    //temp gets rid of the "T"
    DateTime temp = DateTime.parse(calendarItem.startTime);
    calendarEditOutBox.put(
        '${temp.toString()}-${calendarItem.agencyName}-${calendarItem.programNum}-${calendarItem.auditor}-${calendarItem.auditType}',
        calendarResult);
  }

  void saveAuditors(AuditorList auditorsList) {
    auditorsListBox.put("auditorsList", auditorsList);
  }

  void loadAuditorsFromBox() {
    auditorList = auditorsListBox.get("auditorsList") as AuditorList; // RESTORE AUDITORS
  }

////////////////// Calendar Operations

  void deleteCalendarItem(CalendarResult calendarResult) {
    //temp gets rid of the "T"
    CalendarResult clonedCalendarResult = calendarResult.clone();
    DateTime temp = DateTime.parse(clonedCalendarResult.startTime);
    calendarBox.delete(
        '${temp.toString()}-${clonedCalendarResult.agencyName}-${clonedCalendarResult.programNum}-${clonedCalendarResult.auditor}-${clonedCalendarResult.auditType}');
    calendarOutBox.delete(
        '${temp.toString()}-${clonedCalendarResult.agencyName}-${clonedCalendarResult.programNum}-${clonedCalendarResult.auditor}-${clonedCalendarResult.auditType}');
    calendarDeleteBox.put(
        '${temp.toString()}-${clonedCalendarResult.agencyName}-${clonedCalendarResult.programNum}-${clonedCalendarResult.auditor}-${clonedCalendarResult.auditType}',
        clonedCalendarResult);
    newEventAdded = true;
    notifyListeners();
  }

  void updateFilterValue(String value) {
    filterValue = value;
    notifyListeners();
  }

  void updateStatusOnScheduleToCompleted(CalendarResult calendarResult) {
    CalendarResult retrievedSchedule = calendarBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}')
        as CalendarResult;
    // CalendarResult retrievedScheduleToSend = retrievedSchedule.clone();
    if (retrievedSchedule != null) {
      CalendarResult retrievedScheduleToSend = calendarOutBox.get(
              '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}')
          as CalendarResult;
      if (retrievedSchedule.status != "Completed") {
        retrievedSchedule.status = "Completed";
        addCalendarEditItem(retrievedSchedule);

        //temp gets rid of the "T"
        DateTime temp = DateTime.parse(calendarResult.startTime);

        calendarBox.put(
            '${temp.toString()}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}',
            retrievedSchedule);
        notifyListeners();
      }
      try {
        retrievedScheduleToSend.status = "Completed";

        //temp gets rid of the "T"
        DateTime temp = DateTime.parse(calendarResult.startTime);

        calendarOutBox.put(
            '${temp.toString()}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}',
            retrievedScheduleToSend);
      } catch (err) {
        print("audit not waiting to be sent");
      }
    }
  }

  void toggleFilterTimeToggle() {
    filterTimeToggle = !filterTimeToggle;
    newEventAdded = true;
    notifyListeners();
  }

  bool checkBoxEvent({
    Map<String, dynamic> event,
  }) {
    bool exists = false;

    CalendarResult newEvent = convertMapToCalendarResult(event);
    CalendarResult retrievedEvent = calendarBox.get(
            '${newEvent.startTime}-${newEvent.agencyName}-${newEvent.programNum}-${newEvent.auditor}-${newEvent.auditType}')
        as CalendarResult;
    if (retrievedEvent != null) {
      exists = true;
    }
    return exists;
  }

  void addBoxEvent({
    Map<String, dynamic> event,
    bool notify,
  }) {
    CalendarResult newEvent = convertMapToCalendarResult(event);
    CalendarResult anotherEvent = convertMapToCalendarResult(event);
    // Map<String,dynamic> anotherEvent = JSON.decode(JSON.encode(newEvent));
    CalendarResult retrievedEvent = calendarBox.get(
            '${newEvent.startTime}-${newEvent.agencyName}-${newEvent.programNum}-${newEvent.auditor}-${newEvent.auditType}')
        as CalendarResult;
    if (retrievedEvent == null) {
      //temp gets rid of the "T"
      DateTime temp = DateTime.parse(newEvent.startTime);

      calendarBox.put(
          '${temp.toString()}-${newEvent.agencyName}-${newEvent.programNum}-${newEvent.auditor}-${newEvent.auditType}',
          newEvent);
      calendarOutBox.put(
          '${temp.toString()}-${anotherEvent.agencyName}-${anotherEvent.programNum}-${anotherEvent.auditor}-${anotherEvent.auditType}',
          anotherEvent);
      newEventAdded = true;
      if (notify) notifyListeners();
    }
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
      siteInfo: Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
          .siteList
          .getSiteFromAgencyNumber(agencyNumber: result['agencyNum'] as String),
      citationsToFollowUp: result['citationsToFollowUp'] as Map<String, dynamic>,
    );
    return created;
  }

  void generateAppointments(int value) {
    toggleGenerateApointments != toggleGenerateApointments;
    DateTime now = DateTime.now();
    DateTime pastTime = now.subtract(Duration(days: 325));
    Random random = Random();
    SiteList siteList = Provider.of<SiteData>(navigatorKey.currentContext, listen: false).siteList;
    // Provider.of<SiteData>(navigatorKey.currentContext, listen: false)
    //     .rowsAsListOfValues;
    for (var i = 0; i < value; i++) {
      int randomNumber = random.nextInt(365 * 24 * 60);
      DateTime randomDate = pastTime.add(Duration(minutes: randomNumber));
      String startTime = DateFormat('yyyy-MM-dd kk:mm:ss.000').format(DateTime.parse(randomDate.toString()));
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
          Provider.of<ListCalendarData>(navigatorKey.currentContext, listen: false).auditorList.getRandom();

      print(auditor);
      String status = randomDate.isBefore(DateTime.now()) ? "Completed" : "Scheduled";
      print(status);
      addBoxEvent(event: <String, dynamic>{
        'startTime': startTime,
        'agencyName': agency,
        'agencyNum': agencyNum,
        'auditType': auditType,
        'programNum': programNum,
        'programType': programType,
        'auditor': auditor.username,
        'status': status,
      }, notify: false);
    }
    notifyListeners();
  }

  void deleteAllAppointments() {
    List<dynamic> calendarDynKeys = calendarBox.keys.toList();
    List<String> calendarKeys = List<String>.from(calendarDynKeys);
    for (var i = 0; i < calendarKeys.length; i++) {
      CalendarResult result = calendarBox.get(calendarKeys[i]) as CalendarResult;
      print(result);
      deleteCalendarItem(result);
    }
    notifyListeners();
  }
}
