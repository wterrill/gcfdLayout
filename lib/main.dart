import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Utilities/SyncCode.dart';
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
// import 'Definitions/Dialogs.dart';
import 'Definitions/SiteClasses/Site.dart';
import 'Definitions/SiteClasses/SiteList.dart';
import 'Definitions/AuditorClasses/Auditor.dart';
import 'Definitions/AuditorClasses/AuditorList.dart';
import 'Definitions/colorDefs.dart';
import 'pages/developer/hiveTest/Contact.dart';
import 'package:auditor/pages/developer/hiveTest/Contact.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
// import 'package:background_fetch/background_fetch.dart';
import 'package:sentry/sentry.dart';
import 'dart:async';

final navigatorKey = GlobalKey<NavigatorState>();
final SentryClient sentry =
    SentryClient(dsn: 'https://cd836d0fb8ca4376b30917eef5b32517@o436899.ingest.sentry.io/5398676');

/// This "Headless Task" is run when app is terminated.
// void backgroundFetchHeadlessTask(String taskId) async {
//   print('[BackgroundFetch] Headless event received.');
//   BackgroundFetch.finish(taskId);
// }

void main() async {
  try {
    throw new StateError('This is a Dart exception.');
  } catch (error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }

  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dynamic appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
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
  Hive.registerAdapter(AuditorAdapter());
  Hive.registerAdapter(AuditorListAdapter());

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
  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _enabled = true;
  // int _status = 0;
  // List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();

    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   // Configure BackgroundFetch.
  //   BackgroundFetch.configure(
  //       BackgroundFetchConfig(
  //           minimumFetchInterval: 15,
  //           stopOnTerminate: false,
  //           enableHeadless: false,
  //           requiresBatteryNotLow: false,
  //           requiresCharging: false,
  //           requiresStorageNotLow: false,
  //           requiresDeviceIdle: false,
  //           requiredNetworkType: NetworkType.NONE), (String taskId) async {
  //     // This is the fetch-event callback.a
  //     print("[BackgroundFetch] Event received $taskId");
  //     setState(() {
  //       _events.insert(0, new DateTime.now());
  //     });
  //     print(_events);
  //     ///////////////////////////////////////////////////////////////////////////////////// totalDataSync(context);
  //     // IMPORTANT:  You must signal completion of your task or the OS can punish your app
  //     // for taking too long in the background.
  //     BackgroundFetch.finish(taskId);
  //   }).then((int status) {
  //     print('[BackgroundFetch] configure success: $status');
  //     setState(() {
  //       _status = status;
  //     });
  //   }).catchError((dynamic e) {
  //     print('[BackgroundFetch] configure ERROR: $e');
  //     // setState(() {
  //     //   _status = e;
  //     // });
  //   });

  //   // Optionally query the current BackgroundFetch status.
  //   int status = await BackgroundFetch.status;
  //   setState(() {
  //     _status = status;
  //   });

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  // }

  // void _onClickEnable(bool enabled) {
  //   setState(() {
  //     _enabled = enabled;
  //   });
  //   if (enabled) {
  //     BackgroundFetch.start().then((int status) {
  //       print('[BackgroundFetch] start success: $status');
  //     }).catchError((int e) {
  //       print('[BackgroundFetch] start FAILURE: $e');
  //     });
  //   } else {
  //     BackgroundFetch.stop().then((int status) {
  //       print('[BackgroundFetch] stop success: $status');
  //     });
  //   }
  // }

  // void _onClickStatus() async {
  //   int status = await BackgroundFetch.status;
  //   print('[BackgroundFetch] status: $status');
  //   setState(() {
  //     _status = status;
  //   });
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // BackgroundFetch.start().then((int status) {
    //   print('[BackgroundFetch] start success: $status');
    // }).catchError((dynamic e) {
    //   print('[BackgroundFetch] start FAILURE: $e');
    // });
    Widget screen;
    if (Provider.of<GeneralData>(context).rememberMe == true) {
      screen = ListSchedulingPage();
    } else {
      screen = LoginScreen();
    }
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        toggleableActiveColor: ColorDefs.colorLogoDarkGreen,
        fontFamily: 'Roboto', // 'Poppins', //'Arial', // Arial Regular, Arial, sans-serif  <-- from Kyle
        textTheme: TextTheme(),
      ),
      home: SafeArea(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          print("constraints: $constraints");
          Size mediaSize = MediaQuery.of(context).size;
          double safeAreaSize = mediaSize.height - constraints.maxHeight;
          Provider.of<GeneralData>(context).safeAreaDiff = safeAreaSize;
          Provider.of<GeneralData>(context).safeArea = constraints;
          Provider.of<GeneralData>(context).mediaArea = mediaSize;

          return kIsWeb ? Scaffold(body: ListSchedulingPage()) : Scaffold(body: screen);
          // return Scaffold(body: ListSchedulingPage());
        }),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return new MaterialApp(
  //     home: new Scaffold(
  //       appBar: new AppBar(
  //           title: const Text('BackgroundFetch Example',
  //               style: TextStyle(color: Colors.black)),
  //           backgroundColor: Colors.amberAccent,
  //           brightness: Brightness.light,
  //           actions: <Widget>[
  //             Switch(value: _enabled, onChanged: _onClickEnable),
  //           ]),
  //       body: Container(
  //         color: Colors.black,
  //         child: new ListView.builder(
  //             itemCount: _events.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               DateTime timestamp = _events[index];
  //               return InputDecorator(
  //                   decoration: InputDecoration(
  //                       contentPadding:
  //                           EdgeInsets.only(left: 10.0, top: 10.0, bottom: 0.0),
  //                       labelStyle: TextStyle(
  //                           color: Colors.amberAccent, fontSize: 20.0),
  //                       labelText: "[background fetch event]"),
  //                   child: new Text(timestamp.toString(),
  //                       style: TextStyle(color: Colors.white, fontSize: 16.0)));
  //             }),
  //       ),
  //       bottomNavigationBar: BottomAppBar(
  //           child: Row(children: <Widget>[
  //         RaisedButton(onPressed: _onClickStatus, child: Text('Status')),
  //         Container(
  //             child: Text("$_status"), margin: EdgeInsets.only(left: 20.0))
  //       ])),
  //     ),
  //   );
  // }
}
