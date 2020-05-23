import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/CalendarData.dart';
import 'package:provider/provider.dart';

class CalendarHeaderWidget extends StatefulWidget {
  CalendarHeaderWidget({Key key, this.controller}) : super(key: key);
  final StreamController<String> controller;

  @override
  _CalendarHeaderWidgetState createState() => _CalendarHeaderWidgetState();
}

class _CalendarHeaderWidgetState extends State<CalendarHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    var days = Provider.of<CalendarData>(context).days;
    return Container(
      decoration: BoxDecoration(
          color: ColorDefs.colorCalendarHeader,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      width: double.infinity,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: ColorDefs.colorButton1Background,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Provider.of<CalendarData>(context, listen: false)
                      .changeWeek("backward");
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: ColorDefs.colorTopHeader,
                  size: 30.0,
                ),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: 'enter filter query - type "ora" for example',
          //     ),
          //     onChanged: widget.controller.add,
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  "This Week's Audits",
                  maxLines: 1,
                  minFontSize: 10,
                  style: ColorDefs.textBodyWhite20,
                ),
                Text("${days[0]} - ${days[days.length - 1]}",
                    style: ColorDefs.textBodyBlue10),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: ColorDefs.colorButton1Background,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Provider.of<CalendarData>(context, listen: false)
                      .changeWeek("forward");
                },
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: ColorDefs.colorTopHeader,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
