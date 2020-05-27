import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:auditor/providers/WebData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/pages/LoginScreen/LoginScreen.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
// import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:statsfl/statsfl.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'pages/developer/hiveTest/Contact.dart';

// import 'package:flutter/scheduler.dart' show timeDilation;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dynamic appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path as String);
  }
  Hive.registerAdapter(ContactAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListCalendarData()),
        ChangeNotifierProvider(create: (context) => LayoutData()),
        ChangeNotifierProvider(
          create: (context) => AuditData(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => WebData()),
        ChangeNotifierProvider(
          create: (context) => SiteData(),
          lazy: false,
        ),
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
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => ListSchedulingPage(),
        '/audit': (context) => AuditPage(),
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
      home:
          // StatsFl(
          // child:
          SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          print("constraints: $constraints");
          Size mediaSize = MediaQuery.of(context).size;
          double safeAreaSize = mediaSize.height - constraints.maxHeight;
          Provider.of<LayoutData>(context).safeAreaDiff = safeAreaSize;
          Provider.of<LayoutData>(context).safeArea = constraints;
          Provider.of<LayoutData>(context).mediaArea = mediaSize;

          return Scaffold(body: LoginScreen());
          // return Scaffold(body: ListSchedulingPage());
        }),
      ),
      //),
    );
  }
}
