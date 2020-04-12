import 'package:flutter/material.dart';
// import 'package:gcfdlayout2/Providers/CalendarData.dart';
// import 'package:provider/provider.dart';

class EventOld {
  final Color color;
  final double yTop;
  final double yHeight;
  final String message;
  bool visible = true;

  EventOld(double start, double end, double rowHeight, this.color, this.message)
      : yTop = start * rowHeight,
        yHeight = (end - start) * rowHeight;

  @override
  String toString() => message;
}
