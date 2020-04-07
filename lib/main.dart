import 'package:flutter/material.dart';
import 'package:gcfdlayout/thisWeeksKitties.dart';
// import 'package:responsive_framework/responsive_framework.dart';
import 'CalendarData.dart';
import 'LayoutData.dart';
import 'SchedulingPage.dart';
import 'SchedulingPage2.dart';
import 'package:provider/provider.dart';

import 'SchedulingPage3.dart';
import 'SchedulingPage4.dart';
import 'SchedulingPage5.dart';

// void main() => runApp(MyApp());

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalendarData()),
        ChangeNotifierProvider(create: (context) => LayoutData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        textTheme: TextTheme(),
      ),
      home: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          print("constraints: $constraints");
          Size mediaSize = MediaQuery.of(context).size;
          double safeAreaSize = mediaSize.height - constraints.maxHeight;
          Provider.of<LayoutData>(context).safeAreaDiff = safeAreaSize;
          Provider.of<LayoutData>(context).safeArea = constraints;
          Provider.of<LayoutData>(context).mediaArea = mediaSize;

          // constraints.hei
          return Scaffold(body: SchedulingPage5());
        }),
      ),
    );
  }
}
