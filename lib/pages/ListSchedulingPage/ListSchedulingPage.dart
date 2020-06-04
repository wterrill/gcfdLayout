// import 'dart:async';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:auditor/pages/AuditPage/AuditPage.dart';
// import 'package:auditor/pages/ListSchedulingPage/jsonDataTabledemo.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ApptDataTable.dart';
import 'package:auditor/providers/CalendarData.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
// import 'package:auditor/Definitions/Event.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';
import 'NewAuditDialog.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auditor/providers/ListCalendarData.dart';
// import 'package:auditor/providers/LayoutData.dart';
// import 'package:rxdart/rxdart.dart';

// import 'dart:developer';

class ListSchedulingPage extends StatefulWidget {
  // final controller = StreamController<String>();

  @override
  _ListSchedulingPageState createState() => _ListSchedulingPageState();
}

class _ListSchedulingPageState extends State<ListSchedulingPage> {
  // final controller = BehaviorSubject<String>();
  bool backgroundDisable = false;
  final filterTextController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool filteredTime = Provider.of<ListCalendarData>(context).filterTimeToggle;
    // var mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    // backgroundDisable = Provider.of<LayoutData>(context).backgroundDisable;
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
                    child: Provider.of<ListCalendarData>(context).initializedx
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24.0, 0, 0, 0),
                                        child: FlatButton(
                                          color: ColorDefs.colorAudit2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: ColorDefs
                                                      .colorDarkBackground)),
                                          onPressed: () {
                                            Dialogs.showScheduledAudit(context);
                                          },
                                          child: Text("Schedule New Audit",
                                              style: ColorDefs.textBodyWhite20),
                                        ),
                                      ),
                                      // SizedBox(width: 10),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: FlatButton(
                                            color: filteredTime
                                                ? ColorDefs.colorDarkBackground
                                                : ColorDefs.colorAudit2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                  color: filteredTime
                                                      ? ColorDefs.colorAudit2
                                                      : ColorDefs
                                                          .colorDarkBackground,
                                                )),
                                            onPressed: () {
                                              print("Show this week pressed");
                                              Provider.of<ListCalendarData>(
                                                      context,
                                                      listen: false)
                                                  .toggleFilterTimeToggle();
                                            },
                                            child: filteredTime
                                                ? Text("Show All",
                                                    style: ColorDefs
                                                        .textBodyBlue20)
                                                : Text("Show This Week",
                                                    style: ColorDefs
                                                        .textBodyWhite20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextField(
                                          onChanged: (text) {
                                            Provider.of<ListCalendarData>(
                                                    context,
                                                    listen: false)
                                                .updateFilterValue(
                                                    filterTextController.text);
                                          },
                                          controller: filterTextController,
                                          style: ColorDefs.textBodyBlack20,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.teal,
                                                ),
                                              ),
                                              hintText:
                                                  'Agency / Program Number Filter'),
                                        ),
                                      )
                                    ]),
                              ),
                              ApptDataTable()
                            ],
                          )
                        : Center(
                            child:
                                //CircularProgressIndicator(
                                // backgroundColor: Colors.cyan,
                                // strokeWidth: 10,
                                // )

                                // CircularProgressIndicator(
                                // value: .5,
                                // valueColor: AlwaysStoppedAnimation<Color>(
                                //     ColorDefs.colorAudit3
                                // )
                                Container(
                              height: 300,
                              width: 300,
                              child: Stack(
                                children: [
                                  Center(child: Text("Loading Data...")),
                                  // Center(
                                  //   child: SizedBox(
                                  //       width: 100,
                                  //       height: 100,
                                  //       child: CircularProgressIndicator(
                                  //           strokeWidth: 10,
                                  //           // value: .5,
                                  //           valueColor:
                                  //               AlwaysStoppedAnimation<Color>(
                                  //                   ColorDefs.colorAudit3))),
                                  // ),
                                  // Center(
                                  //   child: SizedBox(
                                  //       width: 50,
                                  //       height: 50,
                                  //       child: CircularProgressIndicator(
                                  //           strokeWidth: 30,
                                  //           // value: .5,
                                  //           valueColor:
                                  //               AlwaysStoppedAnimation<Color>(
                                  //                   ColorDefs.colorAudit2))),
                                  // )
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ],
              // ),
            ),
            if (backgroundDisable)
              Container(color: ColorDefs.colorDisabledBackground),

            TopDrawerWidget(),
            // AuditPage()
          ],
        ),
      ),
    );
  }
}
