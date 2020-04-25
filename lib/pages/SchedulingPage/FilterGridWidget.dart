import 'dart:async';

import 'package:auditor/definitions/Event.dart';
import 'package:auditor/definitions/colorDefs.dart';
import 'package:auditor/providers/CalendarData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

//https://medium.com/flutter-community/flutter-deep-dive-gestures-c16203b3434f
// this class is from the above link, and it's there to allow multiple gestures between
// parents and children.
class AllowMultipleGestureRecognizer extends ScaleGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class FilterGridWidget extends StatefulWidget {
  FilterGridWidget({Key key, this.controller}) : super(key: key);
  final StreamController<String> controller;

  @override
  FilterGridWidgetState createState() => FilterGridWidgetState();
}

class FilterGridWidgetState extends State<FilterGridWidget> {
  @override
  void initState() {
    super.initState();
    previousNumOfDays = 7;
    numberOfDays = 7;
  }

  int previousNumOfDays;
  int numberOfDays;
  String dayInCenter;
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
    // List<List<Event>> dayEvents = Provider.of<CalendarData>(context).dayEvents;
    Size dimensions = MediaQuery.of(context).size;

    // widget.controller.add(dayEvents);

    return StreamBuilder<List<List<Event>>>(
        stream: widget.controller.stream.map(_filter),
        initialData: Provider.of<CalendarData>(context).dayEvents,
        builder: (context, snapshot) {
          int newNumberOfDays = 0;
          bool withinRangeAndDifferent;
          return RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                          AllowMultipleGestureRecognizer>(
                      () => AllowMultipleGestureRecognizer(),
                      (AllowMultipleGestureRecognizer instance) {
                instance.onUpdate = (scaleDetails) => {
                      //print("beer"),
                      if (scaleDetails.scale > 1.0)
                        {
                          newNumberOfDays = (previousNumOfDays -
                              (scaleDetails.scale / 2).round()),
                          print('positive newNumberOfDays: $newNumberOfDays'),
                          print(
                              'positive previousNumOfDays: $previousNumOfDays'),
                          print(
                              'positive scaleDetail.scale: ${scaleDetails.scale}'),
                        }
                      else if (scaleDetails.scale < 1.0)
                        {
                          newNumberOfDays = (previousNumOfDays +
                              (((1 - scaleDetails.scale) * 100 / 25)).round()),
                          print('negative newNumberOfDays: $newNumberOfDays'),
                          print(
                              'negative previousNumOfDays: $previousNumOfDays'),
                          print(
                              'negative scaleDetail.scale: ${scaleDetails.scale}'),
                        },
                      withinRangeAndDifferent = newNumberOfDays < 15 &&
                          newNumberOfDays >= 1 &&
                          newNumberOfDays != numberOfDays,
                      if (withinRangeAndDifferent)
                        {
                          numberOfDays = newNumberOfDays,
                          Provider.of<LayoutData>(context, listen: false)
                              .updateNumberOfDaysShown(numberOfDays),
                          print('onUpdate numberOfDays change: $numberOfDays')
                        }

                      // setState(() {
//                        print('parent - scale: ${scaleDetails.scale}');
//                        print(((scaleDetails.scale / 25)));
                      // int newNumberOfDays = 0;
//                        print('onUpdate $scaleDetails');
//                        print('prior -  prviousNumOfDays: $previousNumOfDays');
                      // if (scaleDetails.scale > 1) {
                      //   newNumberOfDays = (previousNumOfDays -
                      //       ((scaleDetails.scale / 12)).round());
                      // } else {
                      //   newNumberOfDays = (previousNumOfDays +
                      //       (((1 - scaleDetails.scale) * 100 / 25)).round());
                      // }

//                        print('previousNumOfDays:$previousNumOfDays');
//                        print('numberOfDays:$numberOfDays');
//                        print('newNumberOfDays:$newNumberOfDays');
                      //   bool withinRangeAndDifferent = newNumberOfDays < 15 &&
                      //       newNumberOfDays >= 1 &&
                      //       newNumberOfDays != numberOfDays;
                      //   if (withinRangeAndDifferent) {
                      //     numberOfDays = newNumberOfDays;
                      //     Provider.of<LayoutData>(context, listen: false)
                      //         .updateNumberOfDaysShown(numberOfDays);
                      //     print('onUpdate numberOfDays change: $numberOfDays');
                      //   }
                      // })
                    };
              })
            },
            behavior: HitTestBehavior.opaque,
            //Parent Container
            child: Row(
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
                var dayEvents = Provider.of<CalendarData>(context).dayEvents;
//              var events = snapshot.data[col - 1].map(
                var events = dayEvents[col - 1].map(
                  (Event e) => Positioned(
                    top: e.yTop,
                    height: e.yHeight,
                    left: Provider.of<LayoutData>(context).safeArea.minWidth *
                        0.01,
                    right: Provider.of<LayoutData>(context).safeArea.minWidth *
                        0.01,
                    child:
                        // AnimatedOpacity(
                        //   curve: Curves.ease,
                        //   opacity: e.visible
                        //       ? 1
                        //       : 0.2, // you can use 0 instead of 0.1 to hide it completely
                        //   duration: Duration(milliseconds: 250),
                        // child:
                        GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("toggleBigDrawerWidget tap");
                        Provider.of<LayoutData>(context, listen: false)
                            .toggleBigDrawerWidget(event: e);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: dimensions.width * 0.01),
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
                                textAlign: TextAlign.center,
                                wrapWords: false,
                                minFontSize: 5,
                                maxLines: 2,
                                style: e.textStyle,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ),
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
                    child: IgnorePointer(
                        child: Container(
                            color: ColorDefs.colorTransparentOffDayBackground,
                            child: Center(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                  dayOFFmarker,
                                  dayOFFmarker,
                                  dayOFFmarker
                                ])))));

                var todayOverlay = Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Opacity(
                        opacity: 0.05,
                        child: IgnorePointer(
                            child: Container(color: Colors.white))));

                return Expanded(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: List.generate(
                          hours.length,
                          (row) => RawGestureDetector(
                            gestures: {
                              AllowMultipleGestureRecognizer:
                                  GestureRecognizerFactoryWithHandlers<
                                          AllowMultipleGestureRecognizer>(
                                      () =>
                                          AllowMultipleGestureRecognizer(), //constructor
                                      (AllowMultipleGestureRecognizer
                                          instance) {
                                //initializer
                                instance.onStart = (scaleDetails) => {
                                      setState(() {
                                        print(
                                            'child - previousNumOfDays:$previousNumOfDays');
                                        print(
                                            'child - numberOfDays:$numberOfDays');
                                        dayInCenter = Provider.of<CalendarData>(
                                                context,
                                                listen: false)
                                            .days[col - 1];
                                        print(
                                            'child - dayInCenter: $dayInCenter');
                                        previousNumOfDays = numberOfDays;
                                      })
                                    };
                                instance.onEnd = (scaleDetails) =>
                                    {print('***END*** $numberOfDays')};
                              })
                            },
                            //Creates the nested container within the first.
                            child: Container(
                              height:
                                  Provider.of<CalendarData>(context).rowHeight,
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
                              //),
                            ),
                          ),
                        ),
                      ),
                      // add day's events
                      ...events,
                      // add the day off overlay
                      (col == 7) ? offOverlay : Container(),
                      // add the "Today" overlay
                      (col ==
                              Provider.of<CalendarData>(context)
                                  .todayOverlaySpot)
                          ? todayOverlay
                          : Container(),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }
}
