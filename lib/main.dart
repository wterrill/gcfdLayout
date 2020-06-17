import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ColorAdapter.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:auditor/providers/WebData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/pages/LoginScreen/LoginScreen.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:provider/provider.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Definitions/AuditClasses/Question.dart';
import 'Definitions/AuditClasses/Section.dart';
import 'Definitions/AuditClasses/Audit.dart';
import 'Definitions/SiteClasses/Site.dart';
import 'Definitions/SiteClasses/SiteList.dart';
import 'pages/developer/hiveTest/Contact.dart';
import 'package:auditor/pages/developer/hiveTest/Contact.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dynamic appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path as String);
  }
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(CalendarResultAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(SiteAdapter());
  Hive.registerAdapter(AuditAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(SiteListAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListCalendarData()),
        ChangeNotifierProvider(create: (context) => GeneralData()),
        ChangeNotifierProvider(
          create: (context) => AuditData(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => WebData()),
        // ChangeNotifierProvider(
        //   create: (context) => SiteData(),
        //   lazy: false,
        // ),
        ChangeNotifierProvider(
          create: (context) => SiteData(),
          lazy: false,
        ),
      ],

      //     MultiProvider(
      // providers: [
      //   ChangeNotifierProvider(builder: (_) => Auth()),
      //   ChangeNotifierProxyProvider<Auth, Messages>(
      //     update: (context, auth, previousMessages) => Messages(auth),
      //     create: (BuildContext context) => Messages(null),
      //   ),
      // ],

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
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily:
            'Poppins', //'Arial', // Arial Regular, Arial, sans-serif  <-- from Kyle
        textTheme: TextTheme(),
      ),
      home:
          // StatsFl(
          // child:
          SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          print("constraints: $constraints");
          Size mediaSize = MediaQuery.of(context).size;
          double safeAreaSize = mediaSize.height - constraints.maxHeight;
          Provider.of<GeneralData>(context).safeAreaDiff = safeAreaSize;
          Provider.of<GeneralData>(context).safeArea = constraints;
          Provider.of<GeneralData>(context).mediaArea = mediaSize;
          return kIsWeb
              ? Scaffold(body: ListSchedulingPage())
              : Scaffold(body: LoginScreen());
          // return Scaffold(body: ListSchedulingPage());
          // return Scaffold(body: LoginScreen());
        }),
      ),
      //),
    );
  }
}
