import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

Map<String, dynamic> buildAuditToSend(
    Audit outgoingAudit, String deviceidProvider) {
  Map<String, dynamic> resultMap = <String, dynamic>{};
////////// Encode all of the questions first //////////
  for (Section section in outgoingAudit.sections) {
    for (Question question in section.questions) {
      if (section.name != "Photos") {
        print('------- ${section.name} -------');
        String name = question.questionMap['databaseVar'] as String;
        if (name != null) {
          print(name);
        }
        if (name == "PestControlReport") {
          print("gotch!");
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
////////// Encode main body  //////////
  String deviceid = deviceidProvider;

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

////////// Encode signatures in base 64 //////////
  resultMap['SiteRepresentativeSignature'] =
      base64Encode(outgoingAudit.photoSig['siteRepresentativeSignature']);

  if (outgoingAudit.photoSig['foodDepositoryMonitorSignature'] != null)
    resultMap['FoodDepositoryMonitorSignature'] =
        base64Encode(outgoingAudit.photoSig['foodDepositoryMonitorSignature']);
  // bool siteVisitRequired = false;

  Map<String, dynamic> citationsMap = <String, dynamic>{};

  for (Question citation in outgoingAudit.citations) {
    if (!citation.unflagged) {
      // siteVisitRequired = true;
      citationsMap[(citation.questionMap['databaseVar'] as String) + 'Flag'] =
          1;
      citationsMap[(citation.questionMap['databaseVar'] as String) +
          'ActionItem'] = citation.actionItem;

      citationsMap[(citation.questionMap['databaseVar'] as String) +
          'OriginalAnswer'] = citation.userResponse;

      citationsMap[(citation.questionMap['databaseVar'] as String) +
          'OriginalComments'] = citation.optionalComment;
    } else {
      String text = (citation.questionMap['databaseVar'] as String) + 'Flag';
      citationsMap[text] = 0;
      citationsMap[(citation.questionMap['databaseVar'] as String) +
          'OriginalAnswer'] = citation.userResponse;

      citationsMap[(citation.questionMap['databaseVar'] as String) +
          'OriginalComments'] = citation.optionalComment;
    }
  }

  resultMap['SiteVisitRequired'] = outgoingAudit.siteVisitRequired;

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
  if (outgoingAudit.calendarResult.programType == "Pantry Audit") {
    mainBody["PantryDetail"] = resultMap;
  } else if (outgoingAudit.calendarResult.programType == "Congregate Audit") {
    mainBody["CongregateDetail"] = resultMap;
  } else {
    mainBody["PPCDetail"] = resultMap;
  }
  if (outgoingAudit.calendarResult.programType == "Pantry Audit") {
    mainBody['PantryCitations'] = citationsMap;
  }
  if (outgoingAudit.calendarResult.programType == "Congregate Audit") {
    mainBody['CongregateCitations'] = citationsMap;
  }

  print(mainBody);
  return mainBody;

  // return FullAuditComms.sendFullAudit(mainBody).timeout(
  //   const Duration(seconds: 10),
  //   onTimeout: () {
  //     // Navigator.of(navigatorKey.currentContext).pop();
  //     // Dialogs.showMessage(
  //     //     context: navigatorKey.currentContext,
  //     //     message:
  //     //         "A timeout error has ocurred while contacting the site data enpoint. Check internet connection",
  //     //     dismissable: true);
  //     return null;
  //   },
  // );
}
