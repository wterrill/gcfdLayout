import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'colorDefs.dart';

class TimeColumn extends StatelessWidget {
  const TimeColumn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          color: colorTimeBackground,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "6:00 am",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),

            // Text("6:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "7:00 am",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("7:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "8:00 am",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("8:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "9:00 am",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("9:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "10:00 am",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("10:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "11:00 am",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "12:00 pm",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "1:00 pm",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("1:00 pm", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "2:00 pm",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("1:00 pm", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "3:00 pm",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("1:00 pm", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: colorTimeBackground,
            border: Border(
              top: BorderSide(width: 1.0, color: colorCalendarHeader),
            ),
          ),
          child: Center(
            child: AutoSizeText(
              "4:00 pm",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("1:00 pm", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
      ],
    );
  }
}
