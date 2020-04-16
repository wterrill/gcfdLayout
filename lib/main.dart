import 'package:flutter/material.dart';
import 'package:gcfdlayout2/pages/LoginScreen/LoginScreen.dart';
import 'package:gcfdlayout2/pages/SchedulingPage/SchedulingPage.dart';
// import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';
import 'package:gcfdlayout2/providers/CalendarData.dart';
import 'package:gcfdlayout2/providers/LayoutData.dart';
import 'package:statsfl/statsfl.dart';

// import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CalendarData(), lazy: false),
        ChangeNotifierProvider(create: (context) => LayoutData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // timeDilation = 14.0;
    return MaterialApp(
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SchedulingPage(),
      },
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        textTheme: TextTheme(),
      ),
      // home: Scaffold(body: LoginScreen())
      home: StatsFl(
        child: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            print("constraints: $constraints");
            Size mediaSize = MediaQuery.of(context).size;
            double safeAreaSize = mediaSize.height - constraints.maxHeight;
            Provider.of<LayoutData>(context).safeAreaDiff = safeAreaSize;
            Provider.of<LayoutData>(context).safeArea = constraints;
            Provider.of<LayoutData>(context).mediaArea = mediaSize;

            return Scaffold(body: LoginScreen());
            // return Scaffold(body: SchedulingPage());
          }),
        ),
      ),
    );
  }
}
