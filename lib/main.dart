import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
      home: Scaffold(body: MyPage()),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffFFCE00),
                    Color(0xffE86F1C),
                  ],
                ),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.blue)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Container(
                      color: Colors
                          .blueAccent, //remove color to make it transpatrent
                      child: Center(child: Text("This is Sized Box"))),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent, //remove color?
                        border: Border.all(
                            style: BorderStyle.solid, color: colorTopHeader),
                      ),
                      child: Center(child: Text("This is Expanded"))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Center(child: Text("This is Sized Box")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget timeColumn = Column(
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
              "5:00 pm",
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
              "6:00 pm",
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
              "7:00 pm",
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
              "8:00 pm",
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
              "9:00 pm",
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
              "10:00 pm",
              style: subtitle2,
              minFontSize: 1.0,
              maxLines: 1,
            ),
            // Text("1:00 pm", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
      ],
    );

    Widget dayColumn(String day, String date) {
      return Expanded(
        flex: 1,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorTimeBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
              height: 50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      day,
                      style: textDayHeadings,
                      minFontSize: 1.0,
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      date,
                      style: TextStyle(fontSize: 10.0),
                      minFontSize: 1.0,
                      maxLines: 1,
                    ),

                    // Text(day, style: caption),
                    // Text(date, style: overline)
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorAlternatingDark,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorDarkBackground,
                border: Border(
                  left: BorderSide(width: 1.0, color: colorCalendarHeader),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              // top white bar
              flex: 1,
              child: Container(
                color: colorTopHeader,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
                      child: Container(
                          child:
                              Image(image: AssetImage('images/GCFD_Logo.jpg'))),
                      // Image.asset('images/GCFD_Logo.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: colorUserAccent, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorDarkBackground, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: colorDarkBackground,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Sarah Connor",
                                style: bodyText1,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ), // end of top white bar

            Expanded(
              //big grey background Main
              flex: 12,
              child: Container(
                // Color for big grey background
                width: double.infinity,
                height: double.infinity,
                color: colorDarkBackground,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                  child: Container(
                    // Container for calendar
                    child: Column(
                      children: [
                        Container(
                          // header of calendar
                          decoration: BoxDecoration(
                              color: colorCalendarHeader,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          width: double.infinity,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    color: colorButton1Background,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: colorTopHeader,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "This Week's Audits",
                                    style: bodyText2,
                                  ),
                                  Text("Mar 09, 2020 - Mar 15, 2020",
                                      style: textDayHeadings),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    color: colorButton1Background,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: colorTopHeader,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), // end of calendar header
                        // LayoutBuilder(
                        //   builder: (BuildContext context,
                        //       BoxConstraints viewportConstraints) {
                        //     print(viewportConstraints.maxHeight);
                        //     print(viewportConstraints.minHeight);
                        //     return SingleChildScrollView(
                        //       child: ConstrainedBox(
                        //         constraints: BoxConstraints(
                        //             maxHeight: 900, minHeight: 500),
                        //         child: Row(
                        //           children: [
                        //             Expanded(
                        //               flex: 1,
                        //               child: timeColumn,
                        //             ),
                        //             dayColumn("Monday", "03-09-2002"),
                        //             dayColumn("Tuesday", "03-10-2002"),
                        //             dayColumn("Wednesday", "03-11-2002"),
                        //             dayColumn("Thursday", "03-12-2002"),
                        //             dayColumn("Friday", "03-13-2002"),
                        //             dayColumn("Saturday", "03-14-2002"),
                        //             dayColumn("Sunday", "03-15-2002"),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // )
                        Container(
                            height: MediaQuery.of(context).size.height * .7,
                            child: SingleChildScrollView(
                                child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: timeColumn,
                                ),
                                dayColumn("Monday", "03-09-2002"),
                                dayColumn("Tuesday", "03-10-2002"),
                                dayColumn("Wednesday", "03-11-2002"),
                                dayColumn("Thursday", "03-12-2002"),
                                dayColumn("Friday", "03-13-2002"),
                                dayColumn("Saturday", "03-14-2002"),
                                dayColumn("Sunday", "03-15-2002"),
                              ],
                            ))),
                      ],
                    ), // end of column for calendar
                  ), // end of container for calendar
                ),
              ),
            ),
          ],
        ),
        RepaintBoundary(child: TopDrawer())
      ],
    );
  }
}

class TopDrawer extends StatefulWidget {
  TopDrawer({Key key}) : super(key: key);

  @override
  _TopDrawerState createState() => _TopDrawerState();
}

class _TopDrawerState extends State<TopDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool _drawerState;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this)
          ..addListener(() => setState(() {}));

    animation = Tween(begin: 0.0, end: 150.0).animate(controller);
    _drawerState = false;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 70,
          left: -175,
          child: Transform.translate(
            offset: Offset((animation.value * (175 / 150)), 0.0),
            child: Container(
              height: 325,
              width: 175,
              color: Colors.pink,
            ),
          ),
        ),
        Positioned(
          top: 70,
          child: Transform.translate(
            offset: Offset(animation.value, 0.0),
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    _drawerState = !_drawerState;
                  },
                );
                _drawerState ? controller.forward() : controller.reverse();
              },
              child: Container(
                height: 25,
                width: 25,
                color: Colors.pink,
                child: Transform.rotate(
                  angle: (animation.value / 150) * 3.14 / 4,
                  child: Icon(Icons.dehaze),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
