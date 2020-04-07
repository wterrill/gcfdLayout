import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'colorDefs.dart';

final days = [
  "Monday 03-09-2002",
  "Tuesday 03-10-2002",
  "Wednesday 03-11-2002",
  "Thursday 03-12-2002",
  "Friday 03-13-2002",
  "Saturday 03-14-2002",
  "Sunday 03-15-2002",
];

final hours = [
  "6:00 am",
  "7:00 am",
  "8:00 am",
  "9:00 am",
  "10:00 am",
  "11:00 am",
  "12:00 pm",
  "1:00 pm",
  "2:00 pm",
  "3:00 pm",
  "4:00 pm",
  "5:00 pm",
  "6:00 pm",
  "7:00 pm",
  "8:00 pm",
  "9:00 pm",
  "10:00 pm",
];

List<List<Event>> dayEvents = [
  [], // "Monday 03-09-2002",
  [Event(2.5, 4.5, Colors.green, 'long green')], // "Tuesday 03-10-2002",
  [
    Event(4.25, 4.75, Colors.orange, 'orange'),
    Event(4.85, 6.0, Colors.blue, 'blue')
  ], // "Wednesday 03-11-2002",
  [Event(3.2, 3.4, Colors.indigo, 'short indigo')], // "Thursday 03-12-2002",
  [], // "Friday 03-13-2002",
  [], // "Saturday 03-14-2002",
  [], // "Sunday 03-15-2002",
];

var rowHeight = 80.0;

class Event {
  final Color color;
  final Rect playWindow;
  final String message;

  Event(double start, double end, this.color, this.message)
      : playWindow = Rect.fromLTRB(0, start * rowHeight, 1000, end * rowHeight);
}

class SchedulingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _whiteBar(), // white bar
            Expanded(
              child: Container(
                color: ColorDefs.colorDarkBackground,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                  child: Column(
                    children: [
                      _staticHeader(), // static header
                      Expanded(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            // floating header
                            // SliverAppBar(
                            //   backgroundColor: Colors.transparent,
                            //   floating: true,
                            //   flexibleSpace: _floatingHeader(),
                            // ),
                            SliverPersistentHeader(
                              floating: true,
                              pinned: true,
                              delegate: HeaderDelegate(),
                            ),
                            // main grid
                            SliverToBoxAdapter(
                              child: _grid(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        RepaintBoundary(child: TopDrawer())
      ],
    );
  }

  Widget _whiteBar() {
    return Container(
      height: 50,
      color: ColorDefs.colorTopHeader,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
            child: Image.network("http://placekitten.com/500/100"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
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
                            color: ColorDefs.colorDarkBackground, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Icon(
                        Icons.person,
                        color: ColorDefs.colorDarkBackground,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Sarah Kitty",
                      style: ColorDefs.textBodyWhite20,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _staticHeader() {
    return Container(
      decoration: BoxDecoration(
          color: ColorDefs.colorCalendarHeader,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
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
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: ColorDefs.colorButton1Background,
              ),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: ColorDefs.colorTopHeader,
                size: 30.0,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This Week's Schedule",
                style: ColorDefs.textBodyWhite20,
              ),
              Text("Mar 09, 2020 - Mar 15, 2020",
                  style: ColorDefs.textDayHeadings),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: ColorDefs.colorButton1Background,
              ),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: ColorDefs.colorTopHeader,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingHeader() {
    return Row(
      children: <Widget>[
        Spacer(),
        ...days.map(
          (d) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: ColorDefs.colorCalendarHeader),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    d.split(" ")[0],
                    style: ColorDefs.textDayHeadings,
                    maxLines: 1,
                  ),
                  Text(
                    d.split(" ")[1],
                    style: TextStyle(fontSize: 10.0),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _grid() {
    var columns = List.generate(8, (col) {
      if (col == 0) {
        return Expanded(
          child: Column(
            children: List.generate(
              hours.length,
              (row) => Container(
                height: rowHeight,
                decoration: BoxDecoration(
                  color: ColorDefs.colorTimeBackground,
                  border: Border(
                    top: BorderSide(
                        width: 1.0, color: ColorDefs.colorCalendarHeader),
                  ),
                ),
                child: Center(
                  child: Text(hours[row], style: ColorDefs.textSubtitle2),
                ),
              ),
            ),
          ),
        );
      }
      var events = dayEvents[col - 1].map((e) => Positioned.fromRect(
            rect: e.playWindow,
            child: Container(
              color: e.color,
              child: Text(e.message),
            ),
          ));
      return Expanded(
        child: Stack(
          children: <Widget>[
            Column(
              children: List.generate(
                hours.length,
                (row) => Container(
                  height: rowHeight,
                  decoration: BoxDecoration(
                    color: row.isEven
                        ? ColorDefs.colorAlternatingDark
                        : ColorDefs.colorDarkBackground,
                    border: Border(
                      left: BorderSide(
                          width: 1.0, color: ColorDefs.colorCalendarHeader),
                    ),
                  ),
                ),
              ),
            ),
            // add day's events
            ...events,
          ],
        ),
      );
    });
    return Row(
      children: columns,
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  Widget _floatingHeader(double shrinkOffset) {
    return Row(
      children: <Widget>[
        Spacer(),
        ...days.map(
          (d) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                border: Border(
                  left: BorderSide(
                      width: 1.0, color: ColorDefs.colorCalendarHeader),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 1 - (shrinkOffset / maxExtent),
                    child: Text(
                      d.split(" ")[1],
                      style: TextStyle(fontSize: 10.0),
                      maxLines: 1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1 - (shrinkOffset / maxExtent),
                    child: Text(
                      d.split(" ")[0],
                      style: ColorDefs.textDayHeadings,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _floatingHeader(shrinkOffset);
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 25;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
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
