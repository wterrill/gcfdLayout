// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ntlm/ntlm.dart';

bool isNtlm = false;
dynamic sender;

int convertAuditTypeToNumber(String auditTypeString) {
  int value = 0;
  switch (auditTypeString) {
    case ("Annual"):
      value = 1;
      break;

    case ("Food Rescue"):
      value = 2;
      break;

    case ("CEDA"):
      value = 3;
      break;

    case ("Bi-Annual"):
      value = 4;
      break;

    case ("Complaint"):
      value = 5;
      break;

    case ("Follow Up"):
      value = 6;
      break;

    case ("Grant"):
      value = 7;
      break;
  }
  return value;
}

int convertProgramTypeToNumber(String programType) {
  int value = 0;
  switch (programType) {
    case ("Pantry Audit"):
      value = 1;
      break;
    case ("Congregate Audit"):
      value = 2;
      break;
    case ("Senior Adults Program"):
      value = 3;
      break;
    case ("Healthy Student Market"):
      value = 4;
      break;
  }
  return value;
}

class Authentication {
  static Future<bool> getAuthentication() async {
    return Future.delayed(Duration(milliseconds: 1000), () => true);
  }

  static Future<bool> authenticate({String username, String password}) async {
    NTLMClient client = NTLMClient(
      domain: "",
      workstation: "LAPTOP",
      username: username,
      password: password,
    );

    return client
        .get(
      "http://12.216.81.220:88/api/AuthenticateUser",
    )
        .then((result) {
      bool isAuthenticated = false;
      try {
        dynamic resultMap = json.decode(result.body);
        dynamic dynIsAuthenticated = resultMap['IsAuthenticated'];
        isAuthenticated = dynIsAuthenticated as bool;
      } catch (error) {
        return isAuthenticated;
      }
      return isAuthenticated;
    });
  }
}

class ScheduleAuditComms {
  static Future<bool> scheduleAudit(CalendarResult calendarResult) async {
    NTLMClient client = NTLMClient(
      domain: "",
      workstation: "LAPTOP",
      username: "MXOTestAud1",
      password: "Password1",
    );

    String body = jsonEncode(<String, dynamic>{
      'AED': 'A',
      'AgencyNumber': calendarResult.agencyNum,
      'ProgramNumber': calendarResult.programNum,
      'ProgramType': convertProgramTypeToNumber(calendarResult.programType),
      'Auditor': calendarResult.auditor,
      'AuditType': convertAuditTypeToNumber(calendarResult.auditType),
      'StartTime': calendarResult.startDateTime.toString(),
      'DeviceId': kIsWeb ? "website" : "app"
      //TODO setup device ID for the app.
    });

    if (isNtlm) {
      sender = client.post('http://12.216.81.220:88/api/Audit/Schedule',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body);
    } else {
      sender = http.post('http://12.216.81.220:88/api/Audit/Schedule',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body);
    }

    return sender.then((http.Response res) {
      print(res.body);
      return true;
    }).catchError((String e) {
      print(e);
      return false;
    }) as Future<bool>;
  }
}
