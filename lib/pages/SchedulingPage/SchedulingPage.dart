// import 'dart:async';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
// import 'package:auditor/definitions/Event.dart';
import 'package:auditor/definitions/colorDefs.dart';
import 'package:provider/provider.dart';
import 'BigDrawerWidget.dart';
import 'CalendarHeaderWidget.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auditor/providers/CalendarData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:rxdart/rxdart.dart';

import 'filterGridWidget.dart';
// import 'dart:developer';

class SchedulingPage extends StatefulWidget {
  // final controller = StreamController<String>();

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  final controller = BehaviorSubject<String>();
  bool backgroundDisable = false;

  @override
  Widget build(BuildContext context) {
    // bool startAudit = Provider.of<AuditData>(context).auditStarted;
    var mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    // List<List<Event>> dayEvents = Provider.of<CalendarData>(context).dayEvents;
    // var mediaHeight = Provider.of<LayoutData>(context).mediaArea.height;
    backgroundDisable = Provider.of<LayoutData>(context).backgroundDisable;
    return SafeArea(
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (backgroundDisable) {
              Provider.of<LayoutData>(context, listen: false)
                  .toggleBigDrawerWidget();
            } else {
              // Provider.of<AuditData>(context, listen: false).toggleStartAudit();
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    TopWhiteHeaderWidget(), // white bar
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
                                    CalendarHeaderWidget(
                                        controller:
                                            controller), // static header
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
                                            child: FilterGridWidget(
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
                // ),
                if (backgroundDisable)
                  Container(color: ColorDefs.colorDisabledBackground),
                RepaintBoundary(child: BigDrawerWidget()),
                RepaintBoundary(child: TopDrawerWidget()),
                AuditPage()
              ],
            ),
          )),
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
//                   style: ColorDefs.textBodyBlue20,
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
                      style: ColorDefs.textBodyBlue10,
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
