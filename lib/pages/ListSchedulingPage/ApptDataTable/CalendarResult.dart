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
  final String agencyName;
  @HiveField(2)
  final String agencyNum;
  @HiveField(3)
  final String auditType;
  @HiveField(4)
  final String programNum;
  @HiveField(5)
  final String programType;
  @HiveField(6)
  final String auditor;
  @HiveField(7)
  final String status;
  @HiveField(8)
  final String message;
  @HiveField(9)
  Color programTypeColor;
  @HiveField(10)
  DateTime startDateTime;
  @HiveField(11)
  Site siteInfo = Site();

  // String date;

  CalendarResult(
      {this.startTime,
      this.agencyName,
      this.agencyNum,
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
    return DateFormat.jm().format(startDateTime).toString();
  }

  String getDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(startDateTime).toString();
  }

  String getDateTimeFormatted() {
    return DateFormat('dd-MM-yyyy HH:mm').format(startDateTime).toString();
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
