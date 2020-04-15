import 'dart:async';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/Event.dart';
import 'package:gcfdlayout2/definitions/colorDefs.dart';
import 'package:provider/provider.dart';
import 'CalendarHeader.dart';
import 'TopDrawer.dart';
import 'TopWhiteHeader.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:gcfdlayout2/providers/CalendarData.dart';
import 'package:gcfdlayout2/providers/LayoutData.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer';

class SchedulingPage extends StatelessWidget {
  // final controller = StreamController<String>();

  final controller = BehaviorSubject<String>();
  // final controller2 = BehaviorSubject<List<List<Event>>();

  @override
  Widget build(BuildContext context) {
    var mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    List<List<Event>> dayEvents = Provider.of<CalendarData>(context).dayEvents;
    // var mediaHeight = Provider.of<LayoutData>(context).mediaArea.height;
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
                    padding: EdgeInsets.fromLTRB(
                        0.01 * mediaWidth,
                        50.0,
                        0.01 * mediaWidth,
                        0.0), // symmetric(horizontal: 20.0, vertical: 50.0),
                    child: Provider.of<CalendarData>(context).initialized
                        ? Column(
                            children: [
                              CalendarHeader(
                                  controller: controller), // static header
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
                                      delegate: HeaderDelegate(context),
                                    ),
                                    // main grid
                                    SliverToBoxAdapter(
                                      child: filterGridWidget(
                                          controller: controller),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Text("not initialized"),
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
}

// Widget _floatingHeader() {
//   return Row(
//     children: <Widget>[
//       Spacer(),
//       ...days.map(
//         (d) => Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.black26,
//               border: Border(
//                 left: BorderSide(
//                     width: 1.0, color: ColorDefs.colorCalendarHeader),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   d.split(" ")[0],
//                   style: ColorDefs.textDayHeadings,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   d.split(" ")[1],
//                   style: TextStyle(fontSize: 10.0),
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

class filterGridWidget extends StatefulWidget {
  filterGridWidget({Key key, this.controller}) : super(key: key);
  final StreamController<String> controller;

  @override
  _filterGridWidgetState createState() => _filterGridWidgetState();
}

class _filterGridWidgetState extends State<filterGridWidget> {
  @override
  Widget build(BuildContext context) {
    List<List<Event>> _filter(String query) {
      print('query: |$query|');
      var q = query.toLowerCase();
      List<List<Event>> dayEvents =
          Provider.of<CalendarData>(context, listen: false).dayEvents;
      dayEvents.forEach((day) =>
          day.forEach((e) => e.visible = e.message.toLowerCase().contains(q)));
      return dayEvents;
    }

    var timeAutoGroup = AutoSizeGroup();
    List<String> hours = Provider.of<CalendarData>(context).hours;
    List<List<Event>> dayEvents = Provider.of<CalendarData>(context).dayEvents;
    // widget.controller.add(dayEvents);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(dayEvents);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    return StreamBuilder<List<List<Event>>>(
        stream: widget.controller.stream.map(_filter),
//        initialData: Provider.of<CalendarData>(context).dayEvents,
        builder: (context, snapshot) {
          print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
          print(snapshot);
          print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
          return Row(
            children: List.generate(8, (col) {
              if (col == 0) {
                return Expanded(
                  child: Column(
                    children: List.generate(
                      hours.length,
                      (row) => Container(
                        height: Provider.of<CalendarData>(context).rowHeight,
                        decoration: BoxDecoration(
                          color: ColorDefs.colorTimeBackground,
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: ColorDefs.colorCalendarHeader),
                          ),
                        ),
                        child: Center(
                          child: AutoSizeText(hours[row],
                              maxLines: 1,
                              group: timeAutoGroup,
                              minFontSize: 5,
                              style: ColorDefs.textSubtitle2),
                        ),
                      ),
                    ),
                  ),
                );
              }
              var beer = Provider.of<CalendarData>(context).dayEvents;
//              var events = snapshot.data[col - 1].map(
              var events = beer[col - 1].map(
                (Event e) => Positioned(
                  top: e.yTop,
                  height: e.yHeight,
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
                      child: AutoSizeText(
                        e.message,
                        minFontSize: 5,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ); // <== end of .map

              var dayOFFmarker = Transform.rotate(
                  angle: 3.14 / 2,
                  child: AutoSizeText("OFF",
                      minFontSize: 5,
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
                          height: Provider.of<CalendarData>(context).rowHeight,
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
                    (col == Provider.of<CalendarData>(context).todayOverlaySpot)
                        ? todayOverlay
                        : Container(),
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
  final BuildContext context;

  HeaderDelegate(this.context);

  Widget _floatingHeader(double shrinkOffset) {
    var days = Provider.of<CalendarData>(context).days;
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
