import 'package:auditor/Definitions/Site.dart';
import 'package:auditor/Definitions/programTypeTextAndColorLookup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive/hive.dart';
part 'CalendarResult.g.dart';

@HiveType(typeId: 1)
class CalendarResult extends HiveObject {
  @HiveField(0)
  final String startTime;
  @HiveField(1)
  final String agency;
  @HiveField(2)
  final String auditType;
  @HiveField(3)
  final String programNum;
  @HiveField(4)
  final String programType;
  @HiveField(5)
  final String auditor;
  @HiveField(6)
  final String status;
  @HiveField(7)
  final String message;
  @HiveField(8)
  Color programTypeColor;
  @HiveField(9)
  DateTime startDateTime;
  @HiveField(10)
  Site siteInfo = Site();

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
