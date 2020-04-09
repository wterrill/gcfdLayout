import 'package:flutter/material.dart';
import 'package:gcfdlayout/providers/CalendarData.dart';
import 'package:provider/provider.dart';

class Event {
  final Color color;
  final double top;
  final double height;
  final String message;
  final BuildContext context;
  bool visible = true;

  Event(double start, double end, this.color, this.message, this.context)
      : top = start * Provider.of<CalendarData>(context).rowHeight,
        height = (end - start) * Provider.of<CalendarData>(context).rowHeight;

  @override
  String toString() => message;
}
