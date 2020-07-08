// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/AuditorClasses/Auditor.dart';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ntlm/ntlm.dart';

bool isNtlm = true;
dynamic sender;
NTLMClient client = NTLMClient(
  domain: "",
  workstation: "LAPTOP",
  username: "MXOTestAud1",
  password: "Password1",
);

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

    try {
      return client
          .get(
        "http://12.216.81.220:88/api/AuthenticateUser",
      )
          .then((result) {
        bool isAuthenticated = false;
        try {
          print(result.body);
          dynamic resultMap = json.decode(result.body);
          dynamic dynIsAuthenticated = resultMap['IsAuthenticated'];
          isAuthenticated = dynIsAuthenticated as bool;
        } catch (error) {
          return false;
        }
        return isAuthenticated;
      });
    } catch (error) {
      print(error);
      return false;
    }
  }
}

class FullAuditComms {
  //todo this needs to be future<dynamic>
  static Future<dynamic> sendFullAudit(Map<String, dynamic> auditToSend) async {
    String body = jsonEncode(auditToSend);
    print(body);
    print('sendFullAudit send ${DateTime.now()}');

    if (isNtlm) {
      sender = client.post('http://12.216.81.220:88/api/Audit/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body);
    } else {
      sender = http.post('http://12.216.81.220:88/api/Audit/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body);
    }
    return sender.then((http.Response res) {
      // print(res.body);
      print('sendFullAudit receive ${DateTime.now()}');
      bool result = false;
      if (res.body != null) {
        result = true;
      }
      return result;
    }).catchError((Object e) {
      print(e.toString());
    }) as Future<dynamic>;
  }

  static Future<dynamic> getFullAudit(int allNotMe, String deviceid) async {
    var queryParameters = {
      "MyDeviceId": kIsWeb ? "website" : deviceid,
      "QueryType": allNotMe.toString()
    };
    print('getFullAudit send ${DateTime.now()}');

    if (isNtlm) {
      sender = client.get(
          "http://12.216.81.220:88/api/Audit/Query?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
    } else {
      sender = http.get(
          "http://12.216.81.220:88/api/Audit/Query?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
    }

    return sender.then(
      (http.Response res) {
        print(res.body);
        print('getFullAudit receive ${DateTime.now()}');
        try {
          dynamic resultMap = json.decode(res.body);
          print(resultMap);
          List<dynamic> listEvents = resultMap["Result"] as List<dynamic>;
          return listEvents;
        } catch (error) {
          print(error);
        }
      },
    ).catchError((Object e) {
      print(e);
    }) as Future<dynamic>;
  }
}

class ScheduleAuditComms {
  static Future<dynamic> scheduleAudit(String body) async {
    // String key;
    // if (calendarResult.programType == "Pantry Audit") {
    //   key = "PantryFollowUp";
    // }
    // if (calendarResult.programType == "Congregate Audit") {
    //   key = "CongregateFollowUp";
    // }
    // if (calendarResult.citationsToFollowUp != null) {
    //   Map<String, dynamic> finalObject = <String, dynamic>{};

    //   Map<String, dynamic> temp = calendarResult.citationsToFollowUp;
    //   dynamic initialObject = temp['PreviousEvent'];
    //   dynamic keys2 = initialObject.keys.toList();
    //   List<String> keys3 = keys2.cast<String>().toList() as List<String>;
    //   for (String key in keys3) {
    //     if (key == "ProgramType") {
    //       finalObject[key] =
    //           convertProgramTypeToNumber(initialObject[key] as String);
    //     } else if (key == "AuditType") {
    //       finalObject[key] =
    //           convertAuditTypeToNumber(initialObject[key] as String);
    //     } else {
    //       finalObject[key] = initialObject[key];
    //     }
    //   }
    //   calendarResult.citationsToFollowUp['PreviousEvent'] = finalObject;
    // }

    // String body = jsonEncode(<String, dynamic>{
    //   'AED': addDelete,
    //   'AgencyNumber': calendarResult.agencyNum,
    //   'ProgramNumber': calendarResult.programNum,
    //   'ProgramType': convertProgramTypeToNumber(calendarResult.programType),
    //   'Auditor': calendarResult.auditor,
    //   'AuditType': convertAuditTypeToNumber(calendarResult.auditType),
    //   'StartTime': calendarResult.startDateTime.toString(),
    //   'DeviceId': kIsWeb ? "website" : calendarResult.deviceid,
    //   key: calendarResult.citationsToFollowUp
    // });
    // print(calendarResult.deviceid);
    print('scheduleAudit send ${DateTime.now()}');
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
      print('scheduleAudit receive ${DateTime.now()}');
      return true;
    }).catchError((Object e) {
      print(e);
      return false;
    }) as Future<dynamic>;
  }

  static Future<dynamic> getScheduled(int allNotMe, String deviceid) async {
    // allNotMe = 1;
    var queryParameters = {
      "MyDeviceId": kIsWeb ? "website" : deviceid,
      "QueryType": allNotMe.toString(), // "1: Query All   0: Query All But Me"
    };
    print('getScheduled send ${DateTime.now()}');

    if (isNtlm) {
      sender = client.get(
          "http://12.216.81.220:88/api/Schedule/Query?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
    } else {
      sender = http.get(
          "http://12.216.81.220:88/api/Schedule/Query?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
    }

    return sender.then(
      (http.Response res) {
        print(res.body);
        print('getScheduled receive ${DateTime.now()}');
        try {
          dynamic resultMap = json.decode(res.body);
          print(resultMap);
          List<dynamic> listEvents = resultMap["Result"] as List<dynamic>;
          return listEvents;
        } catch (error) {
          print(error);
        }
      },
    ).catchError((Object e) {
      print(e);
    }) as Future<dynamic>;
  }

  static Future<dynamic> getAuditors() async {
    if (isNtlm) {
      sender = client.get("http://12.216.81.220:88/api/GetAuditors");
    } else {
      sender = http.get("http://12.216.81.220:88/api/GetAuditors");
    }
    print('getAuditors send ${DateTime.now()}');

    return sender.then(
      (http.Response res) {
        print('getAuditors receive ${DateTime.now()}');
        print(res.body);
        try {
          dynamic resultMap = json.decode(res.body);
          print(resultMap);
          List<dynamic> auditors = resultMap["Result"] as List<dynamic>;
          List<Auditor> auditorsList = [];
          for (dynamic auditorDyn in auditors) {
            Auditor auditor = Auditor(auditorName: auditorDyn as String);
            auditorsList.add(auditor);
          }
          AuditorList auditorList = AuditorList(auditorList: auditorsList);
          return auditorList;
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
    print('getSites send ${DateTime.now()}');
    return sender.then(
      (http.Response res) {
        // print(res.body);
        print('getSites Receive ${DateTime.now()}');
        try {
          dynamic parsed =
              json.decode(res.body)['Result'].cast<Map<String, dynamic>>();
          List<Site> oneliner = parsed
              .map<Site>((Map<String, dynamic> json) => Site.fromJson(json))
              .toList() as List<Site>;
          // print(oneliner);
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
