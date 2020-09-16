import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/pages/developer/DatabaseDetails/DatabaseDetails.dart';
import 'package:auditor/pages/developer/DeveloperMenu.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

class TopDrawerWidget extends StatefulWidget {
  TopDrawerWidget({Key key}) : super(key: key);

  @override
  _TopDrawerWidgetState createState() => _TopDrawerWidgetState();
}

class _TopDrawerWidgetState extends State<TopDrawerWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool _drawerState;
  bool startSync = false;

  @override
  void initState() {
    controller = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    var curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInBack)
      ..addListener(() => setState(() {}));

    animation = Tween(begin: 0.0, end: 180.0).animate(curvedAnimation);
    _drawerState = false;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String portNumber = Provider.of<GeneralData>(context).portNumber;
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: -300,
          child: Transform.translate(
            offset: Offset((animation.value * (300 / 180)), 0.0),
            child: Container(
              // top drawer container
              height: 725,
              width: 300,
              color: ColorDefs.colorTopDrawerBackground,
              child: Column(
                children: [
                  Container(height: 40, width: double.infinity, color: ColorDefs.colorTopDrawerBackground),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      // Sync all data
                      setState(() {
                        startSync = true;
                      });
                      //// Site Data /////
                      Dialogs.showMessage(context: context, message: "Syncing Site Data", dismissable: false);
                      String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
                      print("before siteSync");

                      await Provider.of<SiteData>(context, listen: false).siteSync();

                      print("After siteSync");
                      SiteList siteList = Provider.of<SiteData>(context, listen: false).siteList;
                      print("after siteList load");
                      Navigator.of(context).pop();

                      /// Schedule data ///
                      Dialogs.showMessage(
                          context: context,
                          message: "Syncing Scheduling data: upload and download",
                          dismissable: false);
                      await Provider.of<ListCalendarData>(context, listen: false)
                          .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: false);
                      Navigator.of(context).pop();

                      /// Audit Data ///
                      // Navigator.of(context).pop();
                      Dialogs.showMessage(
                          context: context,
                          message: "Syncing Audit calendar data: upload and download",
                          dismissable: false);

                      await Provider.of<AuditData>(context, listen: false)
                          .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: false);
                      Navigator.of(context).pop();

                      /// Done with sync
                      setState(() {
                        startSync = false;
                      });
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.sync, color: ColorDefs.colorAudit2),
                          Center(child: Text("Sync", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      // Sync all data
                      setState(() {
                        startSync = true;
                      });
                      //// Site Data /////
                      Dialogs.showMessage(context: context, message: "Syncing Site Data", dismissable: false);
                      String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
                      await Provider.of<SiteData>(context, listen: false).siteSync();

                      SiteList siteList = Provider.of<SiteData>(context, listen: false).siteList;
                      Navigator.of(context).pop();

                      /// Schedule data ///
                      Dialogs.showMessage(
                          context: context,
                          message: "Syncing Scheduling data: upload and download",
                          dismissable: false);
                      await Provider.of<ListCalendarData>(context, listen: false)
                          .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: true);
                      Navigator.of(context).pop();

                      /// Audit Data ///
                      // Navigator.of(context).pop();
                      Dialogs.showMessage(
                          context: context,
                          message: "Syncing Audit calendar data: upload and download",
                          dismissable: false);

                      await Provider.of<AuditData>(context, listen: false)
                          .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: true);
                      Navigator.of(context).pop();

                      /// Done with sync
                      setState(() {
                        startSync = false;
                      });
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.sync, color: ColorDefs.colorAudit2),
                          Center(child: Text("Full Download", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      // Sync all data
                      setState(() {
                        startSync = true;
                      });
                      //// Site Data /////
                      // Dialogs.showMessage(
                      //     context: context,
                      //     message: "Uploading Scheduled Data:",
                      //     dismissable: false);
                      String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;

                      // SiteList siteList =
                      //     Provider.of<SiteData>(context, listen: false)
                      //         .siteList;
                      // Navigator.of(context).pop();

                      /// Schedule data ///
                      Dialogs.showMessage(
                          context: context, message: "Force Uploading Scheduled Data:", dismissable: false);
                      await Provider.of<ListCalendarData>(context, listen: false).forceScheduleDataUpload(
                        deviceid: deviceid,
                      );
                      Navigator.of(context).pop();

                      /// Audit Data ///
                      // Navigator.of(context).pop();
                      Dialogs.showMessage(context: context, message: "Force Uploading Audit Data:", dismissable: false);

                      await Provider.of<AuditData>(context, listen: false).forceAuditDataUpload(
                        deviceid: deviceid,
                      );
                      Navigator.of(context).pop();

                      /// Done with sync
                      setState(() {
                        startSync = false;
                      });
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.sync, color: ColorDefs.colorAudit2),
                          Center(child: Text("Full Upload", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      // Sync all data
                      Navigator.of(context).pop();
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(builder: (context) => DeveloperMenu()),
                      );
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.edit, color: ColorDefs.colorAudit2),
                          Center(child: Text("Developer Menu", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      String calendarBoxKeys = Provider.of<ListCalendarData>(context, listen: false)
                          .calendarBox
                          .keys
                          .toList()
                          .toString()
                          .replaceAll(",", "\n");
                      String calendarOrderedOutBoxKeys = Provider.of<ListCalendarData>(context, listen: false)
                          .calendarOrderedOutBox
                          .keys
                          .toList()
                          .toString()
                          .replaceAll(",", "\n");

                      String auditBoxKeys = Provider.of<AuditData>(context, listen: false)
                          .auditBox
                          .keys
                          .toList()
                          .toString()
                          .replaceAll(",", "\n");
                      String auditOutBoxKeys = Provider.of<AuditData>(context, listen: false)
                          .auditOutBox
                          .keys
                          .toList()
                          .toString()
                          .replaceAll(",", "\n");

                      String databaseInfo = '''
                      Calendar Boxes:

                      calendarBox: 
                      $calendarBoxKeys
                      

                      calendarOutBoxKeys: 
                      $calendarOrderedOutBoxKeys
                      ------------
                      Audit Boxes:

                      auditBox: 
                      $auditBoxKeys

                      auditOutBoxKeys: 
                      $auditOutBoxKeys            
                      '''
                          .replaceAll("  ", "")
                          .replaceAll("[ ", "")
                          .replaceAll("[", "")
                          .replaceAll("] ", "")
                          .replaceAll("]", "");

                      Dialogs.showMessage(context: context, message: databaseInfo, dismissable: true);
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.perm_data_setting, color: ColorDefs.colorAudit2),
                          Center(child: Text("DataBase Index", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      Dialogs.showWidget(context: context, widget: DatabaseDetails(), dismissable: true);
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.perm_data_setting, color: ColorDefs.colorAudit2),
                          Center(child: Text("DataBase Details", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      List<dynamic> result = Provider.of<AuditData>(context, listen: false).auditBox.keys.toList();

                      for (dynamic key in result) {
                        String keyString = key as String;
                        Provider.of<AuditData>(context, listen: false).auditBox.delete(keyString);
                      }
                      result = Provider.of<AuditData>(context, listen: false).auditOutBox.keys.toList();

                      for (dynamic key in result) {
                        String keyString = key as String;
                        Provider.of<AuditData>(context, listen: false).auditOutBox.delete(keyString);
                      }
                      result = <String>["All Audit data deleted"];
                      setState(() {});
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.error, color: ColorDefs.colorAudit2),
                          Center(child: Text("Delete Audit DB", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      List<dynamic> result =
                          Provider.of<ListCalendarData>(context, listen: false).calendarBox.keys.toList();

                      for (dynamic key in result) {
                        String keyString = key as String;
                        Provider.of<ListCalendarData>(context, listen: false).calendarBox.delete(keyString);
                      }

                      result =
                          Provider.of<ListCalendarData>(context, listen: false).calendarOrderedOutBox.keys.toList();

                      for (dynamic key in result) {
                        String keyString = key as String;
                        Provider.of<ListCalendarData>(context, listen: false).calendarOrderedOutBox.delete(keyString);
                      }

                      result = <String>["All calendar data deleted"];
                      setState(() {});
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.error, color: ColorDefs.colorAudit2),
                          Center(child: Text("Delete Calendar DB ", style: ColorDefs.textBodyBlue20)),
                          Container(
                            height: 20,
                            width: 20,
                            child: startSync
                                ? CircularProgressIndicator()
                                : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          ),
                        ],
                      ),
                    ),
                  ),

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  Container(
                      height: 35.4,
                      width: double.infinity,
                      child: Center(child: Text("", style: ColorDefs.textBodyBlue20))),
                  GestureDetector(
                    onTap: () async {
                      String newPortNumber = "";
                      if (portNumber == "88") {
                        newPortNumber = "90";
                      } else {
                        newPortNumber = "88";
                      }
                      Provider.of<GeneralData>(context, listen: false).updateDatabasePort(newPortNumber);
                    },
                    child: Container(
                      height: 35.4,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerAlternating,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.error, color: ColorDefs.colorAudit2),
                          Center(child: Text("toggle ext. DB from $portNumber", style: ColorDefs.textBodyBlue20)),
                          // Container(
                          //   height: 20,
                          //   width: 20,
                          //   child: startSync
                          //       ? CircularProgressIndicator()
                          //       : Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
                          // ),
                        ],
                      ),
                    ),
                  ),
////////////////////////////////////////////////////
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 62.5,
          child: Transform.translate(
            offset: Offset(animation.value, 0.0),
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    _drawerState = !_drawerState;
                  },
                );
                _drawerState ? controller.forward() : controller.reverse();
              },
              child: Container(
                // hamburger icon handle
                height: 25,
                width: 25,
                decoration: new BoxDecoration(
                  color: ColorDefs.colorTopDrawerBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: (1 - animation.value / 180) * 3.0, // soften the shadow
                      spreadRadius: (1 - animation.value / 180) * 1.0, //extend the shadow
                      offset: Offset(
                        (1 - animation.value / 180) * 2.0, // Move to right 10  horizontally
                        (1 - animation.value / 180) * 2.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Transform.rotate(
                  angle: (animation.value / 180) * 3.14 / 4,
                  child: Icon(Icons.dehaze),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
