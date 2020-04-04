import 'package:flutter/material.dart';
import 'TopDrawer.dart';
import 'colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Version1 extends StatelessWidget {
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
  final days = [
    "Monday 03-09-2002",
    "Tuesday 03-10-2002",
    "Wednesday 03-11-2002",
    "Thursday 03-12-2002",
    "Friday 03-13-2002",
    "Saturday 03-14-2002",
    "Sunday 03-15-2002",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 50,
              color: colorTopHeader,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
                    child: Image(
                      image: AssetImage('images/GCFD_Logo.jpg'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorUserAccent, width: 1.0),
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
            ), // end of top white bar

            Expanded(
              child: Container(
                // Color for big grey background
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

                        Expanded(
                          child: GridView.builder(
                            itemCount: 8 * (hours.length + 1),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                            ),
                            itemBuilder: _itemBuilder,
                          ),
                        ),
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

  // final version = 1; // one of: 1, 2, 3, imho 2 and 3 are better that 1
  double rowHeight =
      50; // <-- Change this to set rowHeight, works only for version 3 ;-(

  Widget _itemBuilder(context, index) {
    if (index == 0) return Text(" ");
    if (index < 8) {
      return Center(
        child: Text(
          days[index - 1],
          style: subtitle2,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (index % 8 == 0) {
      return Container(
        height: rowHeight,
        decoration: BoxDecoration(
          color: colorTimeBackground,
          border: Border(
            top: BorderSide(width: 1.0, color: colorCalendarHeader),
          ),
        ),
        child: Center(
          child: Text(hours[(index ~/ 8) - 1], style: subtitle2),
        ),
      );
    }
    return Container(
      height: rowHeight,
      decoration: BoxDecoration(
        color: (index ~/ 8).isOdd ? colorAlternatingDark : colorDarkBackground,
        border: Border(
          left: BorderSide(width: 1.0, color: colorCalendarHeader),
          // top: BorderSide(width: 1.0, color: colorCalendarHeader),
        ),
      ),
    );
  }
}
