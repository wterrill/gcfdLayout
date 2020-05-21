// import 'dart:async';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/pages/SchedulingPage2/tabledemo.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
// import 'package:auditor/Definitions/Event.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';
import 'ApptList.dart';
import 'CalendarHeaderWidget.dart';
import 'DataTableAppt.dart';
import 'PaginatedDataTableList.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auditor/providers/CalendarData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:rxdart/rxdart.dart';

import 'filterGridWidget.dart';
// import 'dart:developer';

class SchedulingPage2 extends StatefulWidget {
  // final controller = StreamController<String>();

  @override
  _SchedulingPage2State createState() => _SchedulingPage2State();
}

class _SchedulingPage2State extends State<SchedulingPage2> {
  final controller = BehaviorSubject<String>();
  bool backgroundDisable = false;

  @override
  Widget build(BuildContext context) {
    final columns = [
      "Date",
      "Start",
      "Agency",
      "Program Number",
      "Audit Type",
      "Auditor",
      "Status"
    ];
    final rows = 40;

    List<List<String>> _makeData() {
      final List<List<String>> output = [];
      for (int i = 0; i < columns.length; i++) {
        final List<String> row = [];
        for (int j = 0; j < rows; j++) {
          row.add('RRR$i : RRR$j');
        }
        output.add(row);
      }
      return output;
    }

    /// Simple generator for column title
    List<String> _makeTitleColumn() => columns;

    /// Simple generator for row title
    List<String> _makeTitleRow() => List.generate(rows, (i) => 'Left $i');

    // bool startAudit = Provider.of<AuditData>(context).auditStarted;
    var mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    // List<List<Event>> dayEvents = Provider.of<CalendarData>(context).dayEvents;
    // var mediaHeight = Provider.of<LayoutData>(context).mediaArea.height;
    backgroundDisable = Provider.of<LayoutData>(context).backgroundDisable;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                TopWhiteHeaderWidget(), // white bar
                Expanded(
                  child: Container(
                    color: ColorDefs.colorDarkBackground,
                    child: Provider.of<CalendarData>(context).initialized
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // SizedBox(width: 50),
                                      FlatButton(
                                          color: ColorDefs.colorAudit2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: ColorDefs
                                                      .colorAlternateDark)),
                                          onPressed: () {
                                            print("new audit pressed");
                                          },
                                          child: Text("Schedule New Audit",
                                              style:
                                                  ColorDefs.textBodyWhite20)),
                                      // SizedBox(width: 10),
                                      FlatButton(
                                          color: ColorDefs.colorAudit2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: ColorDefs
                                                      .colorAlternateDark)),
                                          onPressed: () {
                                            print("this week pressed");
                                          },
                                          child: Text("Show This Week",
                                              style:
                                                  ColorDefs.textBodyWhite20)),
                                      // SizedBox(width: 10),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: InputBorder.none,
                                              hintText:
                                                  'Agency / Program Number Filter'),
                                        ),
                                      )
                                    ]),
                              ),

                              // DataTableAppt()
                              // PaginatedDataTableList()
                              Expanded(
                                child: SingleChildScrollView(
                                    child:
                                        // Container(color: Colors.blue))

                                        // height: 900,
                                        // width: 700,
                                        DataTableDemo()),
                              )

                              // TableSimple(
                              //   titleColumn: _makeTitleColumn(),
                              //   titleRow: _makeTitleRow(),
                              //   data: _makeData(),
                              // ),
                            ],
                          )
                        : Text("not initialized"),
                  ),
                ),
              ],
            ),
            // ),
            if (backgroundDisable)
              Container(color: ColorDefs.colorDisabledBackground),

            TopDrawerWidget(),
            AuditPage()
          ],
        ),
      ),
    );
  }
}

// class HeaderDelegate extends SliverPersistentHeaderDelegate {
//   final BuildContext context;

//   HeaderDelegate(this.context);

//   Widget _floatingHeader(double shrinkOffset) {
//     var days = Provider.of<CalendarData>(context).days;
//     return Row(
//       children: <Widget>[
//         Spacer(),
//         ...days.map(
//           (d) => Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black26,
//                 border: Border(
//                   left: BorderSide(
//                       width: 1.0, color: ColorDefs.colorCalendarHeader),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Opacity(
//                     opacity: 1 - (shrinkOffset / maxExtent),
//                     child: Text(
//                       d.split(" ")[1],
//                       style: TextStyle(fontSize: 10.0),
//                       maxLines: 1,
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     heightFactor: 1 - (shrinkOffset / maxExtent),
//                     child: Text(
//                       d.split(" ")[0],
//                       style: ColorDefs.textBodyBlue10,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

// @override
// Widget build(
//     BuildContext context, double shrinkOffset, bool overlapsContent) {
//   return _floatingHeader(shrinkOffset);
// }

//   @override
//   double get maxExtent => 50;

//   @override
//   double get minExtent => 25;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
