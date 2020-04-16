import 'package:flutter/material.dart';
// import 'package:gcfdlayout2/Providers/CalendarData.dart';
// import 'package:provider/provider.dart';

class Event {
  // passed
  final TimeOfDay earliestTime;
  final DateTime startTime;
  final Duration duration;
  final String siteName;
  final String auditType;
  final String message;
  final Color color;
  final TextStyle textStyle;

  // Calculated/Obtained
  double rowHeight;
  String formattedDate;
  DateTime endTime;
  double yTop;
  double yHeight;
  String addressStreet;
  String cityStateZip;
  String phone;
  bool visible = true;

  Event({
    @required this.earliestTime,
    @required this.startTime,
    @required this.duration,
    @required this.siteName,
    @required this.auditType,
    @required this.rowHeight,
    @required this.color,
    @required this.textStyle,
    this.addressStreet,
    this.cityStateZip,
    this.phone,
    this.message,
  }) {
    double start = startTime.hour - earliestTime.hour + startTime.minute / 60;
    yTop = start * rowHeight;
    yHeight = (duration.inHours * rowHeight + (duration.inMinutes % 60));
  }

  @override
  String toString() => message;
}
