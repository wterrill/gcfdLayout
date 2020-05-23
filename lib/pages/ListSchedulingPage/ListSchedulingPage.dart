// import 'dart:async';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/pages/ListSchedulingPage/jsonDataTabledemo.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ApptDataTable.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
// import 'package:auditor/Definitions/Event.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:rxdart/rxdart.dart';

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
    var mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
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
                    child: Provider.of<ListCalendarData>(context).initialized
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
