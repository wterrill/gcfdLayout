import 'package:flutter/material.dart';
import 'package:gcfdlayout/providers/CalendarData.dart';
import 'package:provider/provider.dart';

class Event {
  final Color color;
  final double top;
  final double height;
  final String message;
  final double rowHeight;
  bool visible = true;

  Event(double start, double end, this.color, this.message, this.rowHeight)
      : top = start * rowHeight,
        height = (end - start) * rowHeight;

  @override
  String toString() => message;
}
