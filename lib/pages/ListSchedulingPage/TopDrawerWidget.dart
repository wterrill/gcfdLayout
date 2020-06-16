import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/providers/AuditData.dart';
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

class _TopDrawerWidgetState extends State<TopDrawerWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool _drawerState;
  bool startSync = false;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    var curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInBack)
          ..addListener(() => setState(() {}));

    animation = Tween(begin: 0.0, end: 150.0).animate(curvedAnimation);
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
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: -175,
          child: Transform.translate(
            offset: Offset((animation.value * (175 / 150)), 0.0),
            child: Container(
                // top drawer container
                height: 325,
                width: 175,
                color: ColorDefs.colorTopDrawerBackground,
                child: Column(children: [
                  Container(
                      height: 40,
                      width: double.infinity,
                      color: ColorDefs.colorTopDrawerBackground),
                  GestureDetector(
                    onTap: () {
                      Dialogs.showNotImplemented(context);
                    },
                    child: Container(
                        height: 35.4,
                        width: double.infinity,
                        color: ColorDefs.colorTopDrawerAlternating,
                        child: Center(
                            child: Text("Schedule Audit",
                                style: ColorDefs.textBodyBlue20))),
                  ),
                  GestureDetector(
                    onTap: () {
                      SiteList siteList =
                          Provider.of<SiteData>(context, listen: false)
                              .siteList;
                      Dialogs.showSites(context, siteList.siteList);
                    },
                    child: Container(
                        height: 35.4,
                        width: double.infinity,
                        child: Center(
                            child: Text("Sites",
                                style: ColorDefs.textBodyBlue20))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Dialogs.showNotImplemented(context);
                    },
                    child: Container(
                        height: 35.4,
                        width: double.infinity,
                        color: ColorDefs.colorTopDrawerAlternating,
                        child: Center(
                            child: Text("Contacts",
                                style: ColorDefs.textBodyBlue20))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Dialogs.showNotImplemented(context);
                    },
                    child: Container(
                        height: 35.4,
                        width: double.infinity,
                        child: Center(
                            child:
                                Text("View", style: ColorDefs.textBodyBlue20))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Dialogs.showNotImplemented(context);
                    },
                    child: Container(
                        height: 35.4,
                        width: double.infinity,
                        color: ColorDefs.colorTopDrawerAlternating,
                        child: GestureDetector(
                          onTap: () async {
                            // Sync all data
                            setState(() {
                              startSync = true;
                            });
                            await Provider.of<SiteData>(context, listen: false)
                                .siteSync();
                            SiteList siteList =
                                Provider.of<SiteData>(context, listen: false)
                                    .siteList;
                            await Provider.of<ListCalendarData>(context,
                                    listen: false)
                                .dataSync(context, siteList);
                            await Provider.of<AuditData>(context, listen: false)
                                .dataSync(context, siteList);

                            setState(() {
                              startSync = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.sync, color: ColorDefs.colorAudit2),
                              Center(
                                  child: Text("Sync",
                                      style: ColorDefs.textBodyBlue20)),
                              Container(
                                height: 20,
                                width: 20,
                                child: startSync
                                    ? CircularProgressIndicator()
                                    : Icon(Icons.sync,
                                        color:
                                            ColorDefs.colorTopDrawerBackground),
                              ),
                            ],
                          ),
                        )),
                  ),
                ])),
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
                      blurRadius: (1 - animation.value / 150) *
                          3.0, // soften the shadow
                      spreadRadius:
                          (1 - animation.value / 150) * 1.0, //extend the shadow
                      offset: Offset(
                        (1 - animation.value / 150) *
                            2.0, // Move to right 10  horizontally
                        (1 - animation.value / 150) *
                            2.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Transform.rotate(
                  angle: (animation.value / 150) * 3.14 / 4,
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
