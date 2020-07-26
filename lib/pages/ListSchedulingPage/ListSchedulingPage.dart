import 'dart:ui';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Utilities/SyncCode.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ApptDataTable.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
import 'package:auditor/providers/ListCalendarData.dart';

class ListSchedulingPage extends StatefulWidget {
  @override
  _ListSchedulingPageState createState() => _ListSchedulingPageState();
}

class _ListSchedulingPageState extends State<ListSchedulingPage> {
  bool backgroundDisable = false;
  final filterTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ,,,,,,
    totalDataSync(context);
    print("ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ& STARTUP!!!!");
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool filteredTime =
        Provider.of<ListCalendarData>(context, listen: false).filterTimeToggle;
    String dayOfWeek = DateFormat('EEE').format(DateTime.now()).toString();
    AuditorList auditorList =
        Provider.of<ListCalendarData>(context).auditorList;
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
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
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
                                              if (auditorList != null) {
                                                Dialogs.showScheduledAudit(
                                                    context);
                                              } else {
                                                Dialogs.showNotSynced(context);
                                              }
                                            },
                                            child: Text("Schedule New Audit",
                                                style:
                                                    ColorDefs.textBodyWhite20),
                                          ),
                                        ),
                                        // SizedBox(width: 10),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 70,
                                              maxWidth: 400,
                                              minWidth: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: FlatButton(
                                              color: filteredTime
                                                  ? ColorDefs
                                                      .colorDarkBackground
                                                  : ColorDefs.colorAudit2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
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
                                                  : Text(
                                                      "Show last $dayOfWeek to next $dayOfWeek ",
                                                      style: ColorDefs
                                                          .textBodyWhite20),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 250,
                                          child: TextField(
                                            onChanged: (text) {
                                              Provider.of<ListCalendarData>(
                                                      context,
                                                      listen: false)
                                                  .updateFilterValue(
                                                      filterTextController
                                                          .text);
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
                              ),
                              ApptDataTable()
                            ],
                          )
                        : Center(
                            child: Container(
                              height: 300,
                              width: 300,
                              child: Stack(
                                children: [
                                  Center(child: Text("Loading Data...")),
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
