import 'package:flutter/material.dart';
import 'TopDrawer.dart';
import 'colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SchedulingPage extends StatelessWidget {
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
  final List<String> days = [
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
              color: ColorDefs.colorTopHeader,
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
                        border: Border.all(
                            color: ColorDefs.colorUserAccent, width: 1.0),
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
                                    color: ColorDefs.colorDarkBackground,
                                    width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
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
                              "Sarah Connor",
                              style: ColorDefs.bodyText1,
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
                color: ColorDefs.colorDarkBackground,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
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
                        ), // end of calendar header

                        Expanded(
                          child: CustomScrollView(
                            slivers: <Widget>[
                              SliverAppBar(
                                backgroundColor: Colors.transparent,
                                floating: true,
                                flexibleSpace: Row(
                                  children: <Widget>[
                                    Expanded(child: Text(" ")),
                                    ...days
                                        .map(
                                          (d) => Expanded(
                                              child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorDefs.colorTimeBackground,
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
                                                    d.split(" ")[0],
                                                    style: ColorDefs
                                                        .textDayHeadings,
                                                    minFontSize: 1.0,
                                                    maxLines: 1,
                                                  ),
                                                  AutoSizeText(
                                                    d.split(" ")[1],
                                                    style: TextStyle(
                                                        fontSize: 10.0),
                                                    minFontSize: 1.0,
                                                    maxLines: 1,
                                                  ),
                                                ]),
                                          )),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                              // SliverList(
                              //   delegate: SliverChildBuilderDelegate(
                              //     _itemBuilder3,
                              //     childCount: hours.length,
                              //   ),
                              // ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    _itemBuilder4,
                                    childCount: 1),
                              ),
                            ],
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

  Widget _itemBuilder3(BuildContext context, int index) {
    return Row(
      children: List.generate(
        8,
        (i) => Expanded(
          child: i == 0
              ? Container(
                  height: rowHeight,
                  decoration: BoxDecoration(
                    color: ColorDefs.colorTimeBackground,
                    border: Border(
                      top: BorderSide(
                          width: 1.0, color: ColorDefs.colorCalendarHeader),
                    ),
                  ),
                  child: Center(
                    child: Text(hours[index], style: ColorDefs.subtitle2),
                  ),
                )
              : Container(
                  height: rowHeight,
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? ColorDefs.colorAlternatingDark
                        : ColorDefs.colorDarkBackground,
                    border: Border(
                      left: BorderSide(
                          width: 1.0, color: ColorDefs.colorCalendarHeader),
                      // top: BorderSide(width: 1.0, color: ColorDefs.colorCalendarHeader),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _itemBuilder4(BuildContext context, int index) {
    List<Widget> boxes = _buildBoxes();
    List<Widget> times = List.generate(
        hours.length,
        (i) =>
            // Expanded( child:
            Container(
              height: rowHeight,
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

    Widget group = Row(children: [
      Column(children: [...times]),
      Column(children: [...boxes]),
      Column(children: [...boxes]),
      Column(children: [...boxes])
    ]);

    return group;
  }

  List<Widget> _buildBoxes() {
    List<Widget> list = [];
    print(hours.length);
    print(list);
    for (int hourindex = 0; hourindex < hours.length; hourindex++) {
      list.add(Container(
        height: rowHeight,
        width: 50,
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
    return list;
  }
}
