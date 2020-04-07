import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LayoutData.dart';
import 'TopDrawer.dart';
import 'TopWhiteHeader.dart';
import 'colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SchedulingPage2 extends StatelessWidget {
  final List<String> hours = [
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
  final List<Map<String, String>> days = [
    {'date': 'Monday 03-09-2002'},
    {'date': 'Tuesday 03-10-2002'},
    {'date': 'Wednesday 03-11-2002'},
    {'date': 'Thursday 03-12-2002'},
    {'date': 'Friday 03-13-2002'},
    {'date': 'Saturday 03-14-2002'},
    {'date': 'Sunday 03-15-2002'},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TopWhiteHeader(),
            Expanded(
              child: Container(
                // Color for big grey background
                color: ColorDefs.colorDarkBackground,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                  child: Container(
                    // Container for calendar
                    child: Column(
                      children: [
                        Container(
                          // header of calendar
                          decoration: BoxDecoration(
                              color: ColorDefs.colorCalendarHeader,
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
                                    "This Week's Audits",
                                    style: ColorDefs.bodyText2,
                                  ),
                                  Text("Mar 09, 2020 - Mar 15, 2020",
                                      style: ColorDefs.textDayHeadings),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
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
                        ),
                        Container(
                          // Day name and date headings (static)
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text(" ")),
                              ...days
                                  .map(
                                    (Map<String, String> d) => Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorDefs.colorTimeBackground,
                                        border: Border(
                                          left: BorderSide(
                                              width: 1.0,
                                              color: ColorDefs
                                                  .colorCalendarHeader),
                                        ),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              d['date'].split(" ")[0],
                                              // d['date'].split(" ")[0],
                                              style: ColorDefs.textDayHeadings,
                                              minFontSize: 1.0,
                                              maxLines: 1,
                                            ),
                                            AutoSizeText(
                                              d['date'].split(" ")[1],
                                              style: TextStyle(fontSize: 10.0),
                                              minFontSize: 1.0,
                                              maxLines: 1,
                                            ),
                                          ]),
                                    )),
                                  )
                                  .toList(),
                            ],
                          ),
                        ), // end of calendar header
                        Container(
                          width: double.infinity,
                          // height: 50.0 * hours.length - 76,
                          height: MediaQuery.of(context).size.height -
                              200 -
                              Provider.of<LayoutData>(context).safeAreaDiff,
                          child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildTimes(),
                                ),
                                _buildBoxes(context),
                                _buildBoxes(context),
                                _buildBoxes(context),
                                _buildBoxes(context),
                                _buildBoxes(context),
                                _buildBoxes(context),
                                _buildBoxes(context)
                              ],
                            ),
                          ),
                        ),
                        // ===============================================
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

  // final version = 3; // one of: 1, 2, 3, imho 2 and 3 are better that 1
  double rowHeight =
      50; // <-- Change this to set rowHeight, works only for version 3 ;-(

  Widget _buildTimes() {
    // List<Widget> boxes = _buildBoxes();
    List<Widget> times = List.generate(
        hours.length,
        (i) =>
            // Expanded( child:
            Container(
              height: rowHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorDefs.colorTimeBackground,
                border: Border(
                  top: BorderSide(
                      width: 1.0, color: ColorDefs.colorCalendarHeader),
                ),
              ),
              child: Center(
                child: Text(hours[i], style: ColorDefs.subtitle2),
              ),
            ) //),
        );
    return Column(children: [...times]);
  }

  Widget _buildBoxes(BuildContext context) {
    List<Widget> boxes = [];
    for (int hourindex = 0; hourindex < hours.length; hourindex++) {
      boxes.add(Container(
        height: rowHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: hourindex.isEven
              ? ColorDefs.colorAlternatingDark
              : ColorDefs.colorDarkBackground,
          border: Border(
            left: BorderSide(width: 1.0, color: ColorDefs.colorCalendarHeader),
          ),
        ),
      ));
    }
    return Expanded(
      child: Container(
        width: double.infinity,
        child:
            Stack(fit: StackFit.loose, alignment: Alignment.center, children: [
          Column(children: [...boxes]),
          Positioned(
              left: Provider.of<LayoutData>(context).safeArea.minWidth * 0.01,
              right: Provider.of<LayoutData>(context).safeArea.minWidth * 0.01,
              top: 20,
              child: Container(
                  decoration: new BoxDecoration(
                    color: ColorDefs.colorAudit1,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                  ),
                  height: 51))
        ]),
      ),
    );
  }
}
