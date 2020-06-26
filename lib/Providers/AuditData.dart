import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/PantryAuditData.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'dart:typed_data';
import 'dart:convert';

import 'package:intl/intl.dart';
// import 'dart:typed_data';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;
  Section activeSection;
  Box auditBox;
  Box auditsToSendBox;
  Audit retrievedAudit;
  CalendarResult activeCalendarResult;
  Uint8List foodDepositoryMonitorSignature;
  Uint8List siteRepresentativeSignature;
  String deviceidProvider;
  bool successfullySubmitted = false;

  AuditData() {
    initialize();
    initHive();
  }
/////////////// HIVE STUFF ////////////////
  void initHive() {
    Future auditBoxFuture = Hive.openBox<Audit>('auditBox');
    Future auditToSendBoxFuture = Hive.openBox<Audit>('auditsToSendBox');

    Future.wait<dynamic>([auditToSendBoxFuture]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditsToSendBox = Hive.box<Audit>('auditsToSendBox');
      notifyListeners();
    });

    Future.wait<dynamic>([auditBoxFuture]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditBox = Hive.box<Audit>('auditBox');
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

  void saveAuditToSend(Audit outgoingAudit) {
    // auditsToSendBox.add(outgoingAudit);
    auditsToSendBox.put(
        '${outgoingAudit.calendarResult.startTime}-${outgoingAudit.calendarResult.agencyName}-${outgoingAudit.calendarResult.programNum}-${outgoingAudit.calendarResult.auditor}',
        outgoingAudit);
    print("testing");
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
  }

  void updateActiveSection(Section newSection) {
    activeSection.status = activeSection.lastStatus;
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
      bool successful = await sendAudit(result) as bool;
      // dynamic successful = await FullAuditComms.sendFullAudit(result);
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
    List<Audit> newAudits = buildAuditFromIncoming(fromServer, siteList);
    print(newAudits);
    for (Audit audit in newAudits) {
      print(audit);

      saveAuditLocally(audit);
    }
    notifyListeners();
  }

  List<Audit> buildAuditFromIncoming(dynamic fromServer, SiteList siteList) {
    List<Audit> newAudits = [];
    Audit newAudit;
    for (dynamic event in fromServer) {
      Map<String, dynamic> receivedAudit = event as Map<String, dynamic>;
      Map<String, dynamic> incomingPantryAudit =
          receivedAudit['PantryDetail'] as Map<String, dynamic>;

      if (incomingPantryAudit != null && receivedAudit['StartTime'] != null) {
        CalendarResult newCalendarResult = CalendarResult(
          programType: convertNumberToProgramType(event['ProgramType'] as int),
          message: "",
          siteInfo: siteList.getSiteFromAgencyNumber(
              //TODO handle first time spin up... siteList is null.
              agencyNumber: event['AgencyNumber'] as String),
          agencyNum: event['AgencyNumber'] as String,
          programNum: event['ProgramNumber'] as String,
          agencyName: siteList
              .agencyNameFromAgencyNumber(event['AgencyNumber'] as String),
          auditType: convertNumberToAuditType(event['AuditType'] as int),
          startTime:
              DateTime.parse(receivedAudit['StartTime'] as String).toString(),
          status: convertNumberToStatus(receivedAudit['Status'] as int),
          auditor: event['Auditor'] as String,
          deviceid: event['DeviceId'] as String,
        );
        print(event['DeviceId']);

        newAudit = Audit(
            calendarResult: newCalendarResult,
            questionnaire: pantryAuditSectionsQuestions);

        List<String> missingDBVar = [];

        // Sections
        for (Section section in newAudit.sections) {
          print("-------------------" + section.name + "-------------------");

          //Questions
          for (Question question in section.questions) {
            // get database variable
            String databaseVar = question.questionMap['databaseVar'] as String;

            if (databaseVar != null) {
              dynamic value = incomingPantryAudit[databaseVar];
              if (value == null) {
                print("Missing: $databaseVar");
                missingDBVar.add(databaseVar);
              } else {
                switch (question.typeOfQuestion) {
                  case ("display"):
                    print(question.text);
                    print('display');
                    print(incomingPantryAudit[databaseVar]);
                    break;

                  case ("yesNo"):
                    print(question.text);
                    print('yesNo');
                    print(incomingPantryAudit[databaseVar]);
                    try {
                      question.userResponse =
                          incomingPantryAudit[databaseVar] as bool
                              ? "Yes"
                              : "No";
                    } catch (err) {
                      question.userResponse =
                          incomingPantryAudit[databaseVar] as String;
                    }

                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;

                    break;
                  case ("issuesNoIssues"):
                    print(question.text);
                    print('issuesNoIssues');
                    print(incomingPantryAudit[databaseVar]);
                    question.userResponse =
                        incomingPantryAudit[databaseVar] as bool
                            ? "No Issues"
                            : "Issues";
                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;

                    break;

                  case ("fillIn"):
                    print(question.text);
                    print('fillIn');
                    print(incomingPantryAudit[databaseVar]);
                    question.userResponse =
                        incomingPantryAudit[databaseVar] as String;
                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;

                    break;

                  case ("fillInNum"):
                    print(question.text);
                    print('fillInNum');
                    print(incomingPantryAudit[databaseVar]);
                    question.userResponse =
                        incomingPantryAudit[databaseVar] as int;
                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;
                    break;

                  case ("dropDown"):
                    print(question.text);
                    print('dropDown');
                    print(incomingPantryAudit[databaseVar]);
                    try {
                      question.userResponse =
                          incomingPantryAudit[databaseVar] as String;
                    } catch (err) {
                      //TODO get rid of try / catches in this file
                      question.userResponse = question.dropDownMenu[
                          incomingPantryAudit[databaseVar] as int];
                    }
                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;
                    break;

                  case ("yesNoNa"):
                    print(question.text);
                    print('yesNoNa');
                    print(incomingPantryAudit[databaseVar]);
                    if (incomingPantryAudit[databaseVar] != null) {
                      question.userResponse =
                          incomingPantryAudit[databaseVar] as bool
                              ? "Yes"
                              : "No";
                    } else {
                      question.userResponse = "NA";
                    }
                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;
                    break;

                  case ("date"):
                    print(question.text);
                    print('date');
                    print(incomingPantryAudit[databaseVar]);
                    question.userResponse =
                        incomingPantryAudit[databaseVar] as String;
                    question.optionalComment =
                        incomingPantryAudit[databaseVar + "Comments"] as String;
                    break;
                }
              }
            }

            //               'databaseVar': 'HowOftenGuestsReceiveFood',
            // 'databaseVarType': 'string',
            // 'databaseOptCom': 'HowOftenGuestsReceiveFoodComments'

          }
          if (incomingPantryAudit['SiteRepresentativeSignature'] != null)
            newAudit.photoSig['siteRepresentativeSignature'] = Base64Decoder()
                .convert(incomingPantryAudit['SiteRepresentativeSignature']
                    as String);
          if (incomingPantryAudit['FoodDepositoryMonitorSignature'] != null)
            newAudit.photoSig['foodDepositoryMonitorSignature'] =
                Base64Decoder().convert(
                    incomingPantryAudit['FoodDepositoryMonitorSignature']
                        as String);

          if (incomingPantryAudit['CorrectiveActionPlanDueDate'] != null) {
            newAudit.correctiveActionPlanDueDate = DateTime.parse(
                incomingPantryAudit['CorrectiveActionPlanDueDate'] as String);
          }
          if (incomingPantryAudit['ImmediateHold'] != null) {
            newAudit.putProgramOnImmediateHold =
                incomingPantryAudit['ImmediateHold'] as bool;
          }
        }

        print(missingDBVar);
        for (Section section in newAudit.sections) {
          section.status = Status.completed;
        }
        if (incomingPantryAudit != null) {
          newAudits.add(newAudit);
        }
      }
      // if (incomingPantryAudit != null) {
      //   newAudits.add(newAudit);
      // }
    }
    return newAudits;
  }

  Future<dynamic> sendAudit(Audit outgoingAudit) async {
    Map<String, dynamic> resultMap = <String, dynamic>{};
    for (Section section in outgoingAudit.sections) {
      for (Question question in section.questions) {
        if (section.name != "Photos") {
          print('------- ${section.name} -------');
          String name = question.questionMap['databaseVar'] as String;
          if (name != null) {
            print(name);
          }
          String qtype = question.questionMap['databaseVarType'] as String;
          String comment = question.questionMap['databaseOptCom'] as String;

          if (qtype == "int") {
            resultMap[name] = question.userResponse as int;
            try {
              resultMap[comment] = question.optionalComment;
            } catch (err) {
              print(err);
              print("moving on");
            }
          }

          if (qtype == "bool") {
            if (question.userResponse == "Yes") {
              resultMap[name] = 1;
            } else if (question.userResponse == "No") {
              resultMap[name] = 0;
            } else if (question.userResponse == "Issues") {
              resultMap[name] = 0;
            } else if (question.userResponse == "No Issues")
              resultMap[name] = 1;
            else {
              resultMap[name] = null;
            }
            try {
              resultMap[comment] = question.optionalComment;
            } catch (err) {
              print(err);
              print("moving on");
            }
          }

          if (qtype == "string") {
            resultMap[name] = question.userResponse;
            try {
              resultMap[comment] = question.optionalComment;
            } catch (err) {
              print(err);
              print("moving on");
            }
          }

          if (qtype == "date") {
            resultMap[name] = question.userResponse;

            try {
              resultMap[comment] = question.optionalComment;
            } catch (err) {
              print(err);
              print("moving on");
            }
          }
          print("go again");
        }
      }
    }
    resultMap.remove(null);
    print(resultMap);
    // Map<String, dynamic> pantryDetail =
    //     <String, dynamic>{"PantryDetail": resultMap};
    String deviceid = deviceidProvider; //Provider.of<GeneralData>(
    //context,
    //listen: false)
    //.deviceid;
    activeCalendarResult.status = "Submitted";
    String dateOfSiteVisit =
        outgoingAudit.calendarResult.startDateTime.toString();

    String startOfAudit = DateFormat("HH:mm:ss.000")
        .format(outgoingAudit.calendarResult.startDateTime);

    String endOfAudit = DateFormat("HH:mm").format(
        outgoingAudit.calendarResult.startDateTime.add(Duration(hours: 2)));

    resultMap["DateOfSiteVisit"] = dateOfSiteVisit;
    resultMap["StartOfAudit"] = startOfAudit;
    resultMap["EndOfAudit"] = endOfAudit;
    resultMap["GCFDAuditorID"] = outgoingAudit.calendarResult.auditor;
    resultMap['ProgramContact'] =
        outgoingAudit.sections[0].questions[7].userResponse;
    resultMap['PersonInterviewed'] =
        outgoingAudit.sections[0].questions[8].userResponse;
    resultMap['ServiceArea'] =
        outgoingAudit.sections[0].questions[10].userResponse;
    if (outgoingAudit.correctiveActionPlanDueDate != null) {
      String tempDateTimeString =
          outgoingAudit.correctiveActionPlanDueDate.toString();
      resultMap['CorrectiveActionPlanDueDate'] = tempDateTimeString;
    }
    //TODO logive the splits up the signature.

    resultMap['SiteRepresentativeSignature'] =
        base64Encode(outgoingAudit.photoSig['siteRepresentativeSignature']);
    /////////
    if (outgoingAudit.photoSig['foodDepositoryMonitorSignature'] != null)
      resultMap['FoodDepositoryMonitorSignature'] = base64Encode(
          outgoingAudit.photoSig['foodDepositoryMonitorSignature']);
    bool followUpRequired = false;
    List<String> followUpItems = [];
    for (Question citation in outgoingAudit.citations) {
      if (!citation.unflagged) {
        followUpRequired = true;
        followUpItems.add(citation.actionItem);
      }
    }
    resultMap['FollowUpRequired'] = followUpRequired;
    resultMap['FollowUpItems'] = followUpItems;
    resultMap['ImmediateHold'] = outgoingAudit.putProgramOnImmediateHold;

    Map<String, dynamic> mainBody = <String, dynamic>{
      "AgencyNumber": outgoingAudit.calendarResult.agencyNum,
      "ProgramNumber": outgoingAudit.calendarResult.programNum,
      "ProgramType":
          convertProgramTypeToNumber(outgoingAudit.calendarResult.programType),
      "Auditor": outgoingAudit.calendarResult.auditor,
      "AuditType":
          convertAuditTypeToNumber(outgoingAudit.calendarResult.auditType),
      "StartTime": outgoingAudit.calendarResult.startDateTime.toString(),
      "DeviceId": deviceid,
      "PantryFollowUp": null,
      "CongregateDetail": null,
      "PPCDetail": null,
    };
    mainBody["PantryDetail"] = resultMap;
    print(mainBody);

    return FullAuditComms.sendFullAudit(mainBody);

    // return success;
  }

  void showSuccess() {
    successfullySubmitted = true;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////
}
