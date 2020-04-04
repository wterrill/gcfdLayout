import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'OldVersion.dart';
import 'SizedBoxExpandedBox.dart';
import 'Version1.dart';
import 'Version123.dart';
import 'Version2.dart';
import 'Version3.dart';
import 'colorDefs.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: (context, widget) => ResponsiveWrapper.builder(
//           maxWidth: 1200,
//           minWidth: 450,
//           defaultScale: true,
//           breakpoints: [
//             ResponsiveBreakpoint(breakpoint: 450, name: MOBILE),
//             ResponsiveBreakpoint(breakpoint: 800, name: TABLET, scale: true),
//             ResponsiveBreakpoint(breakpoint: 1000, name: TABLET, scale: true),
//             ResponsiveBreakpoint(breakpoint: 1200, name: DESKTOP),
//             ResponsiveBreakpoint(breakpoint: 2460, name: "4K", scale: true),
//           ],
//           background: Container(color: Color(0xFFF5F5F5))),
//       initialRoute: "/",
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: (context, widget) => ResponsiveWrapper.builder(
//           BouncingScrollWrapper.builder(context, widget),
//           maxWidth: 1200,
//           minWidth: 450,
//           defaultScale: true,
//           breakpoints: [
//             ResponsiveBreakpoint(
//                 breakpoint: 450, name: MOBILE, autoScale: true),
//             ResponsiveBreakpoint(
//                 breakpoint: 800, name: TABLET, autoScale: true),
//             ResponsiveBreakpoint(
//                 breakpoint: 1000, name: TABLET, autoScale: true),
//             ResponsiveBreakpoint(
//                 breakpoint: 1200, name: DESKTOP, autoScale: true),
//             ResponsiveBreakpoint(breakpoint: 2460, name: "4K", autoScale: true),
//           ],
//           background: Container(color: Color(0xFFF5F5F5))),
//       // initialRoute: Routes.home,
//       // onGenerateRoute: (RouteSettings settings) {
//       //   switch (settings.name) {
//       //     case Routes.home:
//       //       return Routes.fadeThrough(settings, (context) => ListPage());
//       //       break;
//       //     case Routes.post:
//       //       return Routes.fadeThrough(settings, (context) => PostPage());
//       //       break;
//       //     case Routes.style:
//       //       return Routes.fadeThrough(settings, (context) => TypographyPage());
//       //       break;
//       //     default:
//       //       return null;
//       //       break;
//       //   }
//       // },
//       theme: ThemeData(
//         // Define the default brightness and colors.
//         brightness: Brightness.dark,
//         primaryColor: Colors.lightBlue[800],
//         accentColor: Colors.cyan[600],
//         canvasColor:
//             Color(0xFFFEFEFE), // off white for main header and text and borders
//         backgroundColor: Color(0xFF343434), // grey for big background and row
//         dividerColor: Color(0xFF393939), // grey for alternating lines
//         primaryColorLight: Color(0xFF5B5B5B), // light gray for calendar header
//         indicatorColor: Color(0xFF717171), // left / right button background
//         cardColor: Color(0xFF303030), // background of time column / date row
//         hoverColor: Colors.green, // Profile image and outline

// // primaryC491d4bcer
// // bottomAppBarColor
// // dividerColor
// // focusColor
// // highlightColor
// // splashColor
// // selectedRowColor
// // unselectedWidgetColor
// // disabledColor
// // buttonColor
// // secondaryHeaderColor
// // textSelectionColor
// // cursorColor
// // textSelectionHandleColor
// // dialogBackgroundColor
// // hintColor
// // errorColor
// // toggleableActiveColor

//         // Define the default font family.
//         fontFamily: 'Georgia',

//         // Define the default TextTheme. Use this to specify the default
//         // text styling for headlines, titles, bodies of text, and more.
//         textTheme: TextTheme(
//           bodyText1: TextStyle(color: Colors.black, fontSize: 20.0), //
//           bodyText2:
//               TextStyle(color: Theme.of(context).canvasColor, fontSize: 20.0),
//           headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//           headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//           textDayHeadings: TextStyle(color: Colors.cyan[300], fontSize: 10.0), //
//           subtitle2:
//               TextStyle(color: Theme.of(context).canvasColor, fontSize: 15.0),
//           caption: TextStyle(
//               fontSize: 14.0, fontFamily: 'Hind', color: Colors.cyan[300]),
//           overline: TextStyle(
//               fontSize: 10.0,
//               fontFamily: 'Hind',
//               color: Theme.of(context).canvasColor),
//         ),
//       ),
//       home: Scaffold(body: MyPage()),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

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
      // home: Scaffold(body: SizedBoxExpandedBox()),
      // home: Scaffold(body: OldVersion()),
      // home: Scaffold(body: Version1()),
      // home: Scaffold(body: Version2()),
      // home: Scaffold(body: Version3()),
      home: Scaffold(body: Version123()),
    );
  }
}
