import 'package:flutter/material.dart';
import 'package:gcfdlayout2/providers/CalendarData.dart';
import 'package:provider/provider.dart';

class Event {
  final Color color;
  final double top;
  final double height;
  final String message;
  bool visible = true;

  Event(double start, double end, double rowHeight, this.color, this.message)
      : top = start * rowHeight,
        height = (end - start) * rowHeight;

  @override
  String toString() => message;
}
