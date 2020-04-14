import 'package:flutter/material.dart';

class OldEvent {
  final Color color;
  double top;
  double height;
  final String message;
  bool visible = true;
  double start;
  double end;
  double rowHeight;

  OldEvent(double start, double end, double rowHeight, this.color, this.message)
      : top = start * rowHeight,
        height = (end - start) * rowHeight;

  // void initState(){
  //   print("initialised");
  //   top = start * rowHeight;
  //   height = (end - start) * rowHeight;
  //   print(top);
  //   print(height);
  // }

  @override
  String toString() => message;
}
