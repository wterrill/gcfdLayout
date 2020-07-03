import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/PantryAuditData.dart';
import 'package:auditor/Definitions/CongregateAuditData.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/providers/SendAudit.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

import 'dart:typed_data';

import 'package:intl/intl.dart';

import 'BuildAuditFromIncoming.dart';
// import 'dart:typed_data';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;
  Section activeSection;
  Box auditBox;
  Box auditsToSendBox;
  Box auditOutBox;
  Audit retrievedAudit;
  CalendarResult activeCalendarResult;
  Uint8List foodDepositoryMonitorSignature;
  Uint8List siteRepresentativeSignature;
  String deviceidProvider;
  bool successfullySubmitted = false;
  List<Question> citations = [];
  // List<String> actionItemList = [];

  AuditData() {
    initialize();
    initHive();
  }
/////////////// HIVE STUFF ////////////////
  void initHive() {
    Future auditBoxFuture = Hive.openBox<Audit>('auditBox');
    Future auditToSendBoxFuture = Hive.openBox<Audit>('auditsToSendBox');
    Future auditOutBoxFuture = Hive.openBox<Audit>('auditOutBox');

    Future.wait<dynamic>([
      auditBoxFuture,
      auditToSendBoxFuture,
      auditOutBoxFuture,
    ]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditBox = Hive.box<Audit>('auditBox');
      auditsToSendBox = Hive.box<Audit>('auditsToSendBox');
      auditOutBox = Hive.box<Audit>('auditOutBox');
      notifyListeners();
    });
  }

  void saveAuditLocally(Audit incomingAudit) {
    if (incomingAudit != null) {
      auditBox.put(
          '${incomingAudit.calendarResult.startTime}-${incomingAudit.calendarResult.agencyName}-${incomingAudit.calendarResult.programNum}-${incomingAudit.calendarResult.auditor}',
          incomingAudit);
    }
  }

  Map<String, dynamic> getAuditCitationsObject(
      {CalendarResult newCalendarResult}) {
    Audit retrievedAudit = auditBox.get(
            '${newCalendarResult.startTime}-${newCalendarResult.agencyName}-${newCalendarResult.programNum}-${newCalendarResult.auditor}')
        as Audit;
    Map<String, dynamic> pantryCitations = <String, dynamic>{};

    for (Question citation in retrievedAudit.citations) {
      if (!citation.unflagged) {
        // followUpRequired = true;
        pantryCitations[
            (citation.questionMap['databaseVar'] as String) + 'Flag'] = 1;
        pantryCitations[(citation.questionMap['databaseVar'] as String) +
            'ActionItem'] = citation.actionItem;
      } else {
        String text = (citation.questionMap['databaseVar'] as String) + 'Flag';
        pantryCitations[text] = 0;
      }
    }
    return pantryCitations;
  }

  // void updateStatusOnExistingAudit(
  //     CalendarResult alreadyExistedCalendarResult) {
  //   Audit retrievedAudit = auditBox.get(
  //           '${alreadyExistedCalendarResult.startTime}-${alreadyExistedCalendarResult.agencyName}-${alreadyExistedCalendarResult.programNum}-${alreadyExistedCalendarResult.auditor}')
  //       as Audit;
  //   Audit retrievedAuditToSend = auditOutBox.get(
  //           '${alreadyExistedCalendarResult.startTime}-${alreadyExistedCalendarResult.agencyName}-${alreadyExistedCalendarResult.programNum}-${alreadyExistedCalendarResult.auditor}')
  //       as Audit;
  //   retrievedAudit.calendarResult.status = "Completed";
  //   try {
  //     retrievedAuditToSend.calendarResult.status = "Completed";
  //     auditOutBox.put(
  //         '${alreadyExistedCalendarResult.startTime}-${alreadyExistedCalendarResult.agencyName}-${alreadyExistedCalendarResult.programNum}-${alreadyExistedCalendarResult.auditor}',
  //         retrievedAuditToSend);
  //   } catch (err) {
  //     print("audit not waiting to be sent");
  //   }
  //   auditBox.put(
  //       '${alreadyExistedCalendarResult.startTime}-${alreadyExistedCalendarResult.agencyName}-${alreadyExistedCalendarResult.programNum}-${alreadyExistedCalendarResult.auditor}',
  //       retrievedAudit);
  // }

  void saveAuditToSend(Audit outgoingAudit) {
    Audit clonedOutgoingAudit = outgoingAudit.clone();

    auditsToSendBox.put(
        '${clonedOutgoingAudit.calendarResult.startTime}-${clonedOutgoingAudit.calendarResult.agencyName}-${clonedOutgoingAudit.calendarResult.programNum}-${clonedOutgoingAudit.calendarResult.auditor}',
        clonedOutgoingAudit);
  }

  bool auditExists(CalendarResult calendarResult) {
    retrievedAudit = auditBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}')
        as Audit;
    print(retrievedAudit);
    if (retrievedAudit == null) {
      return false;
    } else {
      return true;
    }
  }

//////////////////////////// END OF HIVE STUFF ////////////////

  void toggleFlag(int index) {
    citations[index].unflagged = !citations[index].unflagged;
    notifyListeners();
  }

  bool notHappyPath(Question question) {
    bool isHappy = true;
    if (question.happyPathResponse != null) {
      if (!question.happyPathResponse.contains(question.userResponse)) {
        isHappy = false;
      }
    }
    return !isHappy;
  }

  void makeCitations() {
    if (activeAudit.calendarResult.status == "Scheduled") {
      for (Section section in activeAudit.sections) {
        List<String> avoid =
            []; //["Photos", "Intro", "Review", "Verification"];
        if (!avoid.contains(section.name)) {
          for (Question question in section.questions) {
            if (question.userResponse != null) {
              int indexToCitation = citationExists(question);
              if (notHappyPath(question)) {
                if (indexToCitation == -1) {
                  question.fromSectionName = section.name;
                  // question.optionalComment =
                  //     question.questionMap['actionItem'] as String;
                  citations.add(question);
                }
              } else {
                if (indexToCitation != -1) {
                  citations.removeAt(indexToCitation);
                }
              }
            }
          }
        }
      }
      // makeActionItems();
      activeAudit.citations = citations;
    }
  }

  // void makeActionItems() {
  //   for (Question citation in citations) {
  //     if (!citation.unflagged) {
  //       actionItems.add(citation.questionMap['actionItem'] as String);
  //     }
  //   }
  // }

  int citationExists(Question question) {
    int index = -1;
    for (Question citation in citations) {
      index++;
      if (citation.text == question.text) {
        return index;
      }
    }
    return -1;
  }

  void notifyTheListeners() {
    notifyListeners();
  }

  void saveLastSectionStatus() {
    if (activeSection.status != Status.selected) {
      activeSection.lastStatus = activeSection.status;
    }
  }

  void updateSectionStatus(Status status) {
    print("in updateSectionStatus");
    if (status != activeSection.status) {
      // activeSection.status = status;
      activeSection.lastStatus = status;
      notifyListeners();
    }
  }

  void initialize() {
    print("initialized AuditData");
  }

  void toggleStartAudit() {
    auditStarted = !auditStarted;
    notifyListeners();
  }

  void resetAudit() {
    foodDepositoryMonitorSignature = null;
    siteRepresentativeSignature = null;
    activeAudit = null;
    auditStarted = false;
    activeSection = null;
    activeCalendarResult = null;
    successfullySubmitted = false;
    citations = [];
    // actionItemList = [];
  }

  void loadExisting(CalendarResult calendarResult) {
    activeAudit = retrievedAudit;
    activeSection = activeAudit.sections[0];
    activeCalendarResult = calendarResult;
  }

  void createAuditClass(CalendarResult calendarResult) {
    if (calendarResult.programType.toLowerCase() == "pantry audit") {
      activeAudit = Audit(
          questionnaire: pantryAuditSectionsQuestions,
          calendarResult: calendarResult);
      activeSection = activeAudit.sections[0];
      activeCalendarResult = calendarResult;
    }
    if (calendarResult.programType.toLowerCase() == "congregate audit") {
      activeAudit = Audit(
          questionnaire: congregateAuditSectionsQuestions,
          calendarResult: calendarResult);
      activeSection = activeAudit.sections[0];
      activeCalendarResult = calendarResult;
    }
  }

  void updateActiveSection(Section newSection) {
    if (['Photos', 'Review', 'Verification'].contains(activeSection.name)) {
      activeSection.status = Status.completed;
    } else {
      activeSection.status = activeSection.lastStatus;
    }
    activeSection = newSection;
    activeSection.lastStatus = activeSection.status;
    activeSection.status = Status.selected;
    notifyListeners();
  }

  void saveActiveAudit() {
    saveAuditLocally(activeAudit);
  }

  void createNewAudit(CalendarResult calendarResult) {
    createAuditClass(calendarResult);
  }

  /////////////////////// sync stuff //////////////////////////
  void dataSync(
      BuildContext context, SiteList siteList, String deviceid) async {
    deviceidProvider = deviceid;
    await sendAuditsToCloud();
    await getAuditsFromCloud(context, siteList, deviceid);
  }

  void sendAuditsToCloud() async {
    List<dynamic> dynKeys = auditsToSendBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      Audit result = auditsToSendBox.get(toBeSentKeys[i]) as Audit;
      bool successful = await sendAudit(result, deviceidProvider) as bool;
      if (successful) auditsToSendBox.delete(toBeSentKeys[i]);
    }
  }

  void getAuditsFromCloud(
      BuildContext context, SiteList siteList, String deviceid) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    if (auditBox.keys.toList().length == 0) {
      allNotMe = 1;
    }

    dynamic fromServer = await FullAuditComms.getFullAudit(allNotMe, deviceid);
    if (fromServer != null) {
      List<Audit> newAudits = buildAuditFromIncoming(fromServer, siteList);
      print(newAudits);
      for (Audit audit in newAudits) {
        print(audit);

        saveAuditLocally(audit);
      }
      notifyListeners();
    }
  }
}
