import 'dart:ui';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/SyncCode.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ApptDataTable.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ListSchedulingPage extends StatefulWidget {
  @override
  _ListSchedulingPageState createState() => _ListSchedulingPageState();
}

class _ListSchedulingPageState extends State<ListSchedulingPage> {
  bool backgroundDisable = false;
  bool startSync = false;
  // final filterTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // syncIfYouCan();
    // WidgetsBinding.instance
    // .addPostFrameCallback((_) => syncIfYouCan());

    print("ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ& STARTUP!!!!");
  }

  void syncIfYouCan() async {
    if (!kIsWeb) {
      await totalDataSync(context);
    }
  }

  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   filterTextController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    bool filteredTime =
        Provider.of<ListCalendarData>(context, listen: false).filterTimeToggle;
    // String dayOfWeek = DateFormat('EEE').format(DateTime.now()).toString();
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
                                  child: Container(
                                    color: Colors.black,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Row(
                                            children: [
                                              Container(width: 30),
                                              IconButton(
                                                  icon: FaIcon(
                                                      FontAwesomeIcons.sync,
                                                      size: 35),
                                                  onPressed: () async {
                                                    setState(() {
                                                      startSync = true;
                                                    });
                                                    //// Site Data /////
                                                    Dialogs.showMessage(
                                                        context: context,
                                                        message:
                                                            "Syncing Site Data",
                                                        dismissable: false);
                                                    String deviceid = Provider
                                                            .of<GeneralData>(
                                                                context,
                                                                listen: false)
                                                        .deviceid;
                                                    print("before siteSync");
                                                    await Provider.of<SiteData>(
                                                            context,
                                                            listen: false)
                                                        .siteSync();
                                                    print("After siteSync");
                                                    SiteList siteList =
                                                        Provider.of<SiteData>(
                                                                context,
                                                                listen: false)
                                                            .siteList;
                                                    print(
                                                        "after siteList load");
                                                    Navigator.of(context).pop();

                                                    /// Schedule data ///
                                                    Dialogs.showMessage(
                                                        context: context,
                                                        message:
                                                            "Syncing Scheduling data: upload and download",
                                                        dismissable: false);
                                                    await Provider.of<
                                                                ListCalendarData>(
                                                            context,
                                                            listen: false)
                                                        .dataSync(
                                                            context: context,
                                                            siteList: siteList,
                                                            deviceid: deviceid,
                                                            fullSync: false);
                                                    Navigator.of(context).pop();

                                                    /// Audit Data ///
                                                    // Navigator.of(context).pop();
                                                    Dialogs.showMessage(
                                                        context: context,
                                                        message:
                                                            "Syncing Audit calendar data: upload and download",
                                                        dismissable: false);

                                                    await Provider.of<
                                                                AuditData>(
                                                            context,
                                                            listen: false)
                                                        .dataSync(
                                                            context: context,
                                                            siteList: siteList,
                                                            deviceid: deviceid,
                                                            fullSync: false);
                                                    Navigator.of(context).pop();

                                                    /// Done with sync
                                                    setState(() {
                                                      startSync = false;
                                                    });
                                                  }),
                                              Container(width: 30),
                                              IconButton(
                                                icon: FaIcon(
                                                    FontAwesomeIcons.sitemap,
                                                    size: 35),
                                                onPressed: () {
                                                  SiteList siteList =
                                                      Provider.of<SiteData>(
                                                              context,
                                                              listen: false)
                                                          .siteList;
                                                  Dialogs.showSites(context,
                                                      siteList.siteList);
                                                },
                                              )
                                            ],
                                          )),
                                          Container(
                                            height: 70,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "Show this week pressed");
                                                      Provider.of<ListCalendarData>(
                                                              context,
                                                              listen: false)
                                                          .toggleFilterTimeToggle();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            "${DateFormat('MM/dd').format(DateTime.now().subtract(Duration(days: 7)))}-${DateFormat('MM/dd').format(DateTime.now().add(Duration(days: 7)))}",
                                                            style: !filteredTime
                                                                ? ColorDefs
                                                                    .textBodyWhite15
                                                                : ColorDefs
                                                                    .textBodyWhite15Underlined),
                                                        Container(width: 2),
                                                        Text("|"),
                                                        Container(width: 2),
                                                        Text("Show All",
                                                            style: filteredTime
                                                                ? ColorDefs
                                                                    .textBodyWhite15
                                                                : ColorDefs
                                                                    .textBodyWhite15Underlined),
                                                      ],
                                                    ) //filteredTime

                                                    ),
                                                Container(
                                                  width: 20,
                                                ),
                                                FlatButton(
                                                  color:
                                                      ColorDefs.colorTopHeader,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    side: BorderSide(
                                                        color: ColorDefs
                                                            .colorLogoLightGreen,
                                                        width: 3.0),
                                                  ),
                                                  onPressed: () {
                                                    if (auditorList != null) {
                                                      Dialogs
                                                          .showScheduledAudit(
                                                              context);
                                                    } else {
                                                      Dialogs.showNotSynced(
                                                          context);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        5.0, 12.0, 5.0, 12.0),
                                                    child: Text(
                                                        "Schedule Audit",
                                                        style: ColorDefs
                                                            .textBodyBlack20),
                                                  ),
                                                ),
                                                Container(width: 20)
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
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

            if (Provider.of<GeneralData>(context).showTopDrawer)
              TopDrawerWidget(),
            // AuditPage()
          ],
        ),
      ),
    );
  }
}
