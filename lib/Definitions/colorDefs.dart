import 'dart:ui';
import 'package:flutter/material.dart';

class ColorDefs {
  static Color colorTopHeader =
      Color(0xFFFEFEFE); // off white for main header and text and borders
  static Color colorDarkBackground =
      Color(0xFF343434); // grey for big background and row
  static Color colorAlternatingDark =
      Color(0xFF393939); // grey for alternating lines
  static Color colorCalendarHeader =
      Color(0xFF5B5B5B); // light gray for calendar header
  static Color colorButton1Background =
      Color(0xFF717171); // left / right button background
  static Color colorTimeBackground =
      Color(0xFF303030); // background of time column / date row
  static Color colorUserAccent = Colors.green; // Profile image and outline
  static Color colorTransparentOffDayBackground =
      Color(0x114ED4DF); // For the OFF day overlay
  static Color colorTransparentOffDayText =
      Color(0x88919C9D); // For the OFF day overlay
  static Color colorTopDrawerBackground = Color(0xFF3C3C3C); //
  static Color colorTopDrawerAlternating = Color(0xFF474747);
  static Color colorBigDrawerBronze = Color(0xFFA36422);

  static Color colorAudit1 = Color(0xFFD84342);
  static Color colorAudit2 = Color(0xFF4ED4DF);
  static Color colorAudit3 = Color(0xFF26BF7D);
  static Color colorAudit4 = Color(0xFFD8AD43);
  static Color colorAudit5 = Color(0xFFFFFFFF);

  static Color colorLoginBackground = Color(0xFFE7EFFE);

  static Color colorDisabledBackground = Color(0xAA555555);

// Styles
  static TextStyle textBodyBlue10 =
      TextStyle(color: colorAudit2, fontSize: 10.0);
  static TextStyle textBodyBlue20 =
      TextStyle(color: colorAudit2, fontSize: 20.0);
  static TextStyle textBodyBlack10 =
      TextStyle(color: Colors.black, fontSize: 10.0);
  static TextStyle textBodyBlack20 =
      TextStyle(color: Colors.black, fontSize: 20.0);
  static TextStyle textBodyBlack30 =
      TextStyle(color: Colors.black, fontSize: 30.0);

  static TextStyle textBodyGrey20 =
      TextStyle(color: Colors.grey, fontSize: 20.0);
  static TextStyle textBodyWhite20 =
      TextStyle(color: Colors.white, fontSize: 20.0);
  static TextStyle textBodyWhite10 =
      TextStyle(color: Colors.white, fontSize: 10.0);
  static TextStyle textBodyText2 =
      TextStyle(color: colorTopHeader, fontSize: 20.0);
  static TextStyle textSubtitle2 =
      TextStyle(color: colorTopHeader, fontSize: 15.0);

  static TextStyle textTransparentOffDay =
      TextStyle(color: colorTransparentOffDayText, fontSize: 42.0);

  static TextStyle textBodyBronze20 =
      TextStyle(color: colorBigDrawerBronze, fontSize: 20.0);
}
