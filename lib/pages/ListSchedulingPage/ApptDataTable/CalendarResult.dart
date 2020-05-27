import 'package:auditor/Definitions/Site.dart';
import 'package:auditor/Definitions/programTypeTextAndColorLookup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarResult {
  final String startTime;
  final String agency;
  final String auditType;
  final String programNum;
  final String programType;
  final String auditor;
  final String status;
  final String message;
  Color programTypeColor;
  Site siteInfo = Site();

  DateTime startDateTime;
  // String date;

  CalendarResult(
      {this.startTime,
      this.agency,
      this.auditType,
      this.programNum,
      this.programType,
      this.auditor,
      this.status,
      this.message,
      this.programTypeColor}) {
    startDateTime = DateTime.parse(startTime);
    var lookup = programTypeTextAndColorLookup(programType);
    programTypeColor = lookup["color"] as Color;
    print(programTypeColor);
  }

  String getStartTimeFormatted() {
    return DateFormat.Hm().format(startDateTime).toString();
  }

  String getDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(startDateTime).toString();
  }

  bool selected = false;

  // factory CalendarResult.fromJson(Map<String, dynamic> json) {
  //   return CalendarResult(
  //     date: json['date'] as String,
  //     startTime: json['startTime'] as String,
  //     endTime: json['endTime'] as String,
  //     siteName: json['siteName'] as String,
  //     auditType: json['auditType'] as String,
  //   );
  // }
}
