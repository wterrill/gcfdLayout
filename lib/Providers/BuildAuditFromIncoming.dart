import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/PantryAuditData.dart';
import 'package:auditor/Definitions/CongregateAuditData.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'dart:convert';

List<Audit> buildAuditFromIncoming(dynamic fromServer, SiteList siteList) {
  List<Audit> newAudits = [];
  Audit newAudit;
  for (dynamic event in fromServer) {
    Map<String, dynamic> receivedAudit = event as Map<String, dynamic>;
    String auditTypeKey;
    if (convertNumberToProgramType(event['ProgramType'] as int) ==
        "Pantry Audit") {
      auditTypeKey = "PantryDetail";
    } else if (convertNumberToProgramType(event['ProgramType'] as int) ==
        "Congregate Audit") {
      auditTypeKey = "CongregateDetail";
    }
    Map<String, dynamic> incomingAudit =
        receivedAudit[auditTypeKey] as Map<String, dynamic>;

    if (incomingAudit != null && receivedAudit['StartTime'] != null) {
      CalendarResult newCalendarResult = CalendarResult(
        programType: convertNumberToProgramType(event['ProgramType'] as int),
        message: "",
        siteInfo: siteList.getSiteFromAgencyNumber(
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

      if (newCalendarResult.programType == "Pantry Audit") {
        newAudit = Audit(
            calendarResult: newCalendarResult,
            questionnaire: pantryAuditSectionsQuestions);
      }

      if (newCalendarResult.programType == "Congregate Audit") {
        newAudit = Audit(
            calendarResult: newCalendarResult,
            questionnaire: congregateAuditSectionsQuestions);
      }

      List<String> missingDBVar = [];
      Map<String, dynamic> citationsMap;
      if (newAudit.calendarResult.programType == "Pantry Audit") {
        citationsMap = receivedAudit["PantryCitations"] as Map<String, dynamic>;
      }
      if (newAudit.calendarResult.programType == "Congregate Audit") {
        citationsMap =
            receivedAudit["CongregateCitations"] as Map<String, dynamic>;
      }
      // pantryCitations is a big object... we just need the data for the non-null pieces:
      // also, let's get a list of the databaseVars
      List<String> citationDatabaseVarsList = [];
      if (citationsMap != null) {
        citationsMap
            .removeWhere((key, dynamic value) => key == null || value == null);

        for (String key in citationsMap.keys) {
          if (key.contains("Flag")) {
            citationDatabaseVarsList.add(key.replaceFirst("Flag", ""));
          }
        }
      }

      // // we need to get the QuestionMap using the datavar.  ugh.
      // for (Map<String, List<Map<String, dynamic>>> section
      //     in pantryAuditSectionsQuestions) {}

      List<Question> citations = [];

      // Sections
      for (Section section in newAudit.sections) {
        print("-------------------" + section.name + "-------------------");

        //Questions
        for (Question question in section.questions) {
          // get database variable
          String databaseVar = question.questionMap['databaseVar'] as String;
          // see if we can snag the question into the citations
          if (citationDatabaseVarsList.contains(databaseVar)) {
            // found one
            if (citationsMap[databaseVar + 'Flag'] as int == 0) {
              question.unflagged = true;
            } else if (citationsMap[databaseVar + 'Flag'] as int == 1) {
              question.unflagged = false;
            }
            question.fromSectionName = section.name;

            // question.unflagged = !question.unflagged;
            question.actionItem =
                citationsMap[databaseVar + "ActionItem"] as String;
            citations.add(question);
          }

          if (databaseVar != null) {
            dynamic value = incomingAudit[databaseVar];
            if (value == null) {
              print("Missing: $databaseVar");
              missingDBVar.add(databaseVar);
            } else {
              switch (question.typeOfQuestion) {
                case ("display"):
                  print(question.text);
                  print('display');
                  print(incomingAudit[databaseVar]);
                  break;

                case ("yesNo"):
                  print(question.text);
                  print('yesNo');
                  print(incomingAudit[databaseVar]);
                  try {
                    question.userResponse =
                        incomingAudit[databaseVar] as bool ? "Yes" : "No";
                  } catch (err) {
                    question.userResponse =
                        incomingAudit[databaseVar] as String;
                  }

                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;

                  break;
                case ("issuesNoIssues"):
                  print(question.text);
                  print('issuesNoIssues');
                  print(incomingAudit[databaseVar]);
                  question.userResponse = incomingAudit[databaseVar] as bool
                      ? "No Issues"
                      : "Issues";
                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;

                  break;

                case ("fillIn"):
                  print(question.text);
                  print('fillIn');
                  print(incomingAudit[databaseVar]);
                  question.userResponse = incomingAudit[databaseVar] as String;
                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;

                  break;

                case ("fillInNum"):
                  print(question.text);
                  print('fillInNum');
                  print(incomingAudit[databaseVar]);
                  question.userResponse = incomingAudit[databaseVar] as int;
                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;
                  break;

                case ("dropDown"):
                  print(question.text);
                  print('dropDown');
                  print(incomingAudit[databaseVar]);
                  try {
                    question.userResponse =
                        incomingAudit[databaseVar] as String;
                  } catch (err) {
                    //TODO get rid of try / catches in this file
                    question.userResponse = question
                        .dropDownMenu[incomingAudit[databaseVar] as int];
                  }
                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;
                  break;

                case ("yesNoNa"):
                  print(question.text);
                  print('yesNoNa');
                  print(incomingAudit[databaseVar]);
                  if (incomingAudit[databaseVar] != null) {
                    question.userResponse =
                        incomingAudit[databaseVar] as bool ? "Yes" : "No";
                  } else {
                    question.userResponse = "NA";
                  }
                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;
                  break;

                case ("date"):
                  print(question.text);
                  print('date');
                  print(incomingAudit[databaseVar]);
                  question.userResponse = incomingAudit[databaseVar] as String;
                  question.optionalComment =
                      incomingAudit[databaseVar + "Comments"] as String;
                  break;
              }
            }
          }
        }
      }
      dynamic temp = incomingAudit['SiteVisitRequired'];
      newAudit.siteVisitRequired = temp as bool;

      // finally, add the citations created above.
      newAudit.citations = citations;

      if (incomingAudit['SiteRepresentativeSignature'] != null)
        newAudit.photoSig['siteRepresentativeSignature'] = Base64Decoder()
            .convert(incomingAudit['SiteRepresentativeSignature'] as String);
      if (incomingAudit['FoodDepositoryMonitorSignature'] != null)
        newAudit.photoSig['foodDepositoryMonitorSignature'] = Base64Decoder()
            .convert(incomingAudit['FoodDepositoryMonitorSignature'] as String);

      if (incomingAudit['CorrectiveActionPlanDueDate'] != null) {
        newAudit.correctiveActionPlanDueDate = DateTime.parse(
            incomingAudit['CorrectiveActionPlanDueDate'] as String);
      }
      if (incomingAudit['ImmediateHold'] != null) {
        newAudit.putProgramOnImmediateHold =
            incomingAudit['ImmediateHold'] as bool;
      }

      print(missingDBVar);
      for (Section section in newAudit.sections) {
        section.status = Status.completed;
      }
      if (incomingAudit != null) {
        newAudits.add(newAudit);
      }
    }
    // if (incomingPantryAudit != null) {
    //   newAudits.add(newAudit);
    // }
  }
  return newAudits;
}
