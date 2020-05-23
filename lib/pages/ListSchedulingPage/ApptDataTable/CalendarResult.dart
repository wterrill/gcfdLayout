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
      this.message}) {
    startDateTime = DateTime.parse(startTime);
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
