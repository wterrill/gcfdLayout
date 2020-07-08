import 'dart:convert';

import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

String buildScheduledToSend(CalendarResult calendarResult, String addDelete) {
  print("Beer pre 1");

  String key;
  if (calendarResult.programType == "Pantry Audit") {
    key = "PantryFollowUp";
  }
  if (calendarResult.programType == "Congregate Audit") {
    key = "CongregateFollowUp";
  }
  print("Beer1");
  if (calendarResult.citationsToFollowUp != null) {
    Map<String, dynamic> finalObject = <String, dynamic>{};

    Map<String, dynamic> temp = calendarResult.citationsToFollowUp;
    dynamic initialObject = temp['PreviousEvent'];
    dynamic keys2 = initialObject.keys.toList();
    List<String> keys3 = keys2.cast<String>().toList() as List<String>;
    for (String key in keys3) {
      if (key == "ProgramType") {
        print("777777777");
        print(initialObject[key]);

        finalObject[key] = initialObject[key];
        // convertProgramTypeToNumber(initialObject[key] as String);
        print("88888888888");
      } else if (key == "AuditType") {
        print("**************");
        dynamic beer = initialObject[key];
        print(beer);
        // String wine = beer as String;
        // print(wine);

        finalObject[key] = beer;
        //convertAuditTypeToNumber(wine);
        print(finalObject[key]);
        print("Wind4");
      } else {
        print("Wind5");
        finalObject[key] = initialObject[key];
        print("Wind6");
      }
    }
    print("Beer3");
    calendarResult.citationsToFollowUp['PreviousEvent'] = finalObject;
  }
  print("Beer3");
  String body = jsonEncode(<String, dynamic>{
    'AED': addDelete,
    'AgencyNumber': calendarResult.agencyNum,
    'ProgramNumber': calendarResult.programNum,
    'ProgramType': convertProgramTypeToNumber(calendarResult.programType),
    'Auditor': calendarResult.auditor,
    'AuditType': convertAuditTypeToNumber(calendarResult.auditType),
    'StartTime': calendarResult.startDateTime.toString(),
    'DeviceId': kIsWeb ? "website" : calendarResult.deviceid,
    key: calendarResult.citationsToFollowUp
  });
  print("Beer5");
  return body;
}
