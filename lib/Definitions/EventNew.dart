import 'package:flutter/material.dart';
// import 'package:gcfdlayout2/Providers/CalendarData.dart';
// import 'package:provider/provider.dart';

class EventNew {
  // passed
  final TimeOfDay earliestTime;
  final DateTime startTime;
  final Duration duration;
  final String siteName;
  final String auditType;
  final String message;

  // Calculated/Obtained
  double rowHeight;
  String formattedDate;
  DateTime endTime;
  Color color;
  double yTop;
  double yHeight;
  String addressStreet;
  String cityStateZip;
  String phone;
  bool visible = true;

  EventNew({
    @required this.earliestTime,
    @required this.startTime,
    @required this.duration,
    @required this.siteName,
    @required this.auditType,
    @required this.rowHeight,
    this.addressStreet,
    this.cityStateZip,
    this.phone,
    this.message,
  }) {
    double start = startTime.hour - earliestTime.hour + startTime.minute / 60;
    yTop = start * rowHeight;
    yHeight =
        (startTime.add(duration).hour + startTime.add(duration).minute / 60) *
            rowHeight;
  }

  // : yTop = start * rowHeight,
  //   yHeight = (end - start) * rowHeight;

  @override
  String toString() => message;
}
