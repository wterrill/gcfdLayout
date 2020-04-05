import 'package:flutter/material.dart';

class ThisWeeksKitties extends StatelessWidget {
  ///////////////////////////////////////////////////////////
  double rowHeight = 70; // <-- Change this to set rowHeight
  ///////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    Widget timeColumn = Column(
      children: [
        Container(
          height: rowHeight,
          color: Theme.of(context).cardColor,
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("6:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("7:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("8:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("9:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("10:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("11:00 am", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("12:00 pm", style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Container(
          height: rowHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Theme.of(context).primaryColorLight),
            ),
          ),
          child: Center(
            child:
                Text("1:00 pm", style: Theme.of(context).textTheme.subtitle2),
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
                color: Theme.of(context).cardColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
              height: rowHeight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(day, style: Theme.of(context).textTheme.caption),
                    Text(date, style: Theme.of(context).textTheme.overline)
                  ],
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            Container(
              height: rowHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColorLight),
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
                color: Theme.of(context).canvasColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
                      child: Image.network('http://placekitten.com/g/500/100'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).hoverColor, width: 1.0),
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
                                      color: Theme.of(context).backgroundColor,
                                      width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Theme.of(context).backgroundColor,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Keyboard Kittie",
                                style: Theme.of(context).textTheme.bodyText1,
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
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                  child: Container(
                    // Container for calendar
                    child: Column(
                      children: [
                        Container(
                          // header of calendar
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
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
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Theme.of(context).canvasColor,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "This Week's Kitties",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text("Mar 09, 2020 - Mar 15, 2020",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Theme.of(context).canvasColor,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), // end of calendar header

                        Container(
                            height: 50 * 9.0,
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
