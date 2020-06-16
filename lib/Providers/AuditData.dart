import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/ExternalDataAudit.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;
  Section activeSection;
  Box auditBox;
  Box auditsToSendBox;
  Audit retrievedAudit;
  CalendarResult activeCalendarResult;

  AuditData() {
    initialize();
    initHive();
  }
/////////////// HIVE STUFF ////////////////
  void initHive() {
    Future auditBoxFuture = Hive.openBox<Audit>('auditBox');
    Future auditToSendBoxFuture = Hive.openBox<Audit>('auditsToSendBox');

    Future.wait<dynamic>([auditBoxFuture]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditBox = Hive.box<Audit>('auditBox');
      notifyListeners();
    });

    Future.wait<dynamic>([auditToSendBoxFuture]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditsToSendBox = Hive.box<Audit>('auditsToSendBox');
      notifyListeners();
    });
  }

  void saveAudit(Audit incomingAudit) {
    if (incomingAudit != null) {
      auditBox.put(
          '${incomingAudit.calendarResult.startTime}-${incomingAudit.calendarResult.agencyName}-${incomingAudit.calendarResult.programNum}-${incomingAudit.calendarResult.auditor}',
          incomingAudit);
    }
  }

  bool getAudit(CalendarResult calendarResult) {
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

////////////////////////////E ND OF HIVE STUFF ////////////////
  void updateSectionStatus(Status status) {
    print("in updateSectionStatus");
    if (status != activeSection.status) {
      activeSection.status = status;
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
    activeSection = newSection;
    notifyListeners();
  }

  void createNewAudit(CalendarResult calendarResult) {
    createAuditClass(calendarResult);
  }

  /////////////////////// sync stuff //////////////////////////
  void dataSync(BuildContext context, SiteList siteList) async {
    // await sendAuditsToCloud();
    await getAuditsFromCloud(context, siteList);
  }

  void sendAuditsToCloud() async {
    List<dynamic> dynKeys = auditsToSendBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      CalendarResult result =
          auditsToSendBox.get(toBeSentKeys[i]) as CalendarResult;
      // dynamic successful = await FullAuditComms.sendFullAudit(result);
      // if (successful as bool) auditsToSendBox.delete(toBeSentKeys[i]);
    }
  }

  void getAuditsFromCloud(BuildContext context, SiteList siteList) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    if (auditBox.keys.toList().length == 0) {
      allNotMe = 1;
    }
    dynamic fromServer = await FullAuditComms.getFullAudit(allNotMe);
    List<Audit> newAudits = buildAuditFromIncoming(fromServer, siteList);
    print(newAudits);
    for (Audit audit in newAudits) {
      print(audit);

      saveAudit(audit);
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
          startTime: receivedAudit['StartTime']
              as String, //incomingPantryAudit['DateOfSiteVisit'] as String,
          status: "Completed",
          auditor: event['Auditor'] as String,
        );

        newAudit = Audit(
            calendarResult: newCalendarResult,
            questionnaire: pantryAuditSectionsQuestions);

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
                    question.userResponse =
                        incomingPantryAudit[databaseVar] as bool ? "Yes" : "No";
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
                    question.userResponse =
                        incomingPantryAudit[databaseVar] as String;
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

  ////////////////////////////////////////////////////////////
}
