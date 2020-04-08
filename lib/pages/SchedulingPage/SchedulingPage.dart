import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gcfdlayout/Definitions/colorDefs.dart';
import 'package:gcfdlayout/providers/LayoutData.dart';
import 'package:provider/provider.dart';
import 'TopDrawer.dart';
import 'TopWhiteHeader.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
  [Event(3.2, 3.7, Colors.indigo, 'short indigo')], // "Thursday 03-12-2002",
  [], // "Friday 03-13-2002",
  [], // "Saturday 03-14-2002",
  [], // "Sunday 03-15-2002",
];

var rowHeight = 50.0;

class Event {
  final Color color;
  final double top;
  final double height;
  final String message;
  bool visible = true;

  Event(double start, double end, this.color, this.message)
      : top = start * rowHeight,
        height = (end - start) * rowHeight;

  @override
  String toString() => message;
}

class SchedulingPage extends StatelessWidget {
  final controller = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TopWhiteHeader(), // white bar
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
          Expanded(
            flex: 1,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'enter filter query - type "ora" for example',
              ),
              onChanged: controller.add,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This Week's Audits",
                  style: ColorDefs.textBodyWhite20,
                ),
                Text("Mar 09, 2020 - Mar 15, 2020",
                    style: ColorDefs.textDayHeadings),
              ],
            ),
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

  List<List<Event>> _filter(String query) {
    print('query: |$query|');
    var q = query.toLowerCase();
    dayEvents.forEach((day) =>
        day.forEach((e) => e.visible = e.message.toLowerCase().contains(q)));
    return dayEvents;
  }

  Widget _grid() {
    return StreamBuilder<List<List<Event>>>(
        stream: controller.stream.map(_filter),
        initialData: dayEvents,
        builder: (context, snapshot) {
          return Row(
            children: List.generate(8, (col) {
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
                                width: 1.0,
                                color: ColorDefs.colorCalendarHeader),
                          ),
                        ),
                        child: Center(
                          child:
                              Text(hours[row], style: ColorDefs.textSubtitle2),
                        ),
                      ),
                    ),
                  ),
                );
              }

              var events = snapshot.data[col - 1].map(
                (e) => Positioned(
                  top: e.top,
                  height: e.height,
                  left:
                      Provider.of<LayoutData>(context).safeArea.minWidth * 0.01,
                  right:
                      Provider.of<LayoutData>(context).safeArea.minWidth * 0.01,
                  child: AnimatedOpacity(
                    curve: Curves.ease,
                    opacity: e.visible
                        ? 1
                        : 0.2, // you can use 0 instead of 0.1 to hide it completely
                    duration: Duration(milliseconds: 250),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: e.color,
                        // color: e.visible
                        //     ? e.color
                        //     : Colors.white, /* this looks good too */
                      ),
                      alignment: Alignment.center,
                      child: Text(e.message),
                    ),
                  ),
                ),
              ); // <== end of .map

              var dayOFFmarker = Transform.rotate(
                  angle: 3.14 / 2,
                  child: AutoSizeText("OFF",
                      minFontSize: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ColorDefs.textTransparentOffDay));

              var offOverlay = Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: ColorDefs.colorTransparentOffDayBackground,
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            dayOFFmarker,
                            dayOFFmarker,
                            dayOFFmarker
                          ]))));

              var todayOverlay = Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Opacity(
                      opacity: 0.05, child: Container(color: Colors.white)));

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
                                  width: 1.0,
                                  color: ColorDefs.colorCalendarHeader),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // add day's events
                    (col == 7) ? offOverlay : Container(),
                    (col == 3) ? todayOverlay : Container(),
                    ...events,

                    // ...todayOverlay
                  ],
                ),
              );
            }),
          );
        });
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
