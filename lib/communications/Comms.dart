// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:auditor/Definitions/NewSite.dart';
import 'package:auditor/Definitions/SiteList.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/NewSiteData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ntlm/ntlm.dart';
import 'package:provider/provider.dart';

bool isNtlm = false;
dynamic sender;
NTLMClient client = NTLMClient(
  domain: "",
  workstation: "LAPTOP",
  username: "MXOTestAud1",
  password: "Password1",
);

String converNumberToStatus(int number) {
  String value = "NONE";
  switch (number) {
    case (0):
      value = "Scheduled";
      break;
    case (1):
      value = "Completed";
  }
  return value;
}

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

String convertNumberToAuditType(int number) {
  String value = "NONE";
  switch (number) {
    case (1):
      value = "Annual";
      break;

    case (2):
      value = "Food Rescue";
      break;

    case (3):
      value = "CEDA";
      break;

    case (4):
      value = "Bi-Annual";
      break;

    case (5):
      value = "Complaint";
      break;

    case (6):
      value = "Follow Up";
      break;

    case (7):
      value = "Grant";
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

String convertNumberToProgramType(int number) {
  String value = "None";
  switch (number) {
    case (1):
      value = "Pantry Audit";
      break;
    case (2):
      value = "Congregate Audit";
      break;
    case (3):
      value = "Senior Adults Program";
      break;
    case (4):
      value = "Healthy Student Market";
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
        return false;
      }
      return isAuthenticated;
    });
  }
}

class ScheduleAuditComms {
  static Future<bool> scheduleAudit(CalendarResult calendarResult) async {
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
    }).catchError((Object e) {
      print(e);
      return false;
    }) as Future<bool>;
  }

  static Future<dynamic> getScheduled(int allNotMe, SiteList siteList) async {
    var queryParameters = {
      "MyDeviceId": kIsWeb ? "website" : "app",
      "QueryType": allNotMe.toString(), // "1: Query All   0: Query All But Me"
    };

    if (isNtlm) {
      sender = client.get(
          "http://12.216.81.220:88/api/Audit/Get?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
    } else {
      sender = http.get(
          "http://12.216.81.220:88/api/Audit/Get?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
    }

    return sender.then(
      (http.Response res) {
        print(res.body);
        try {
          dynamic resultMap = json.decode(res.body);
          print(resultMap);
          List<dynamic> listEvents = resultMap["Result"] as List<dynamic>;
          List<CalendarResult> finalList = [];
          for (dynamic event in listEvents) {
            CalendarResult newResult = CalendarResult(
                agencyName:
                    siteList.lookupAgencyName(event['AgencyNumber'] as String),
                programNum: event['ProgramNumber'] as String,
                programType:
                    convertNumberToProgramType(event['ProgramType'] as int),
                auditor: event['Auditor'] as String,
                auditType: convertNumberToAuditType(event['AuditType'] as int),
                startTime: event['StartTime'] as String,
                status: converNumberToStatus(event['Status'] as int));
            finalList.add(newResult);
          }

          return finalList;
        } catch (error) {
          print(error);
        }
      },
    ).catchError((Object e) {
      print(e);
    }) as Future<dynamic>;
  }
}

class SiteComms {
  static Future<dynamic> getSites() async {
    dynamic sender;
    if (isNtlm) {
      sender = client.get("http://12.216.81.220:88/api/SiteInfo");
    } else {
      sender = http.get("http://12.216.81.220:88/api/SiteInfo");
    }
    return sender.then(
      (http.Response res) {
        print(res.body);
        try {
          dynamic parsed =
              json.decode(res.body)['Result'].cast<Map<String, dynamic>>();
          List<NewSite> oneliner = parsed
              .map<NewSite>(
                  (Map<String, dynamic> json) => NewSite.fromJson(json))
              .toList() as List<NewSite>;
          print(oneliner);
          return oneliner;
        } catch (error) {
          print(error);
        }
      },
    ).catchError((Object e) {
      print(e);
    }) as Future<dynamic>;
  }
}
