import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/Event.dart';
import 'package:gcfdlayout2/definitions/colorDefs.dart';
import 'package:gcfdlayout2/providers/LayoutData.dart';
import 'package:provider/provider.dart';

class BigDrawer extends StatefulWidget {
  BigDrawer({Key key}) : super(key: key);

  @override
  _BigDrawerState createState() => _BigDrawerState();
}

class _BigDrawerState extends State<BigDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
//  bool _drawerState;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    var curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInBack)
          ..addListener(() => setState(() {}));

    animation = Tween(begin: 0.0, end: 150.0).animate(curvedAnimation);
    // _drawerState = false;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Event event = Provider.of<LayoutData>(context).selectedEvent;
    bool openDrawer = Provider.of<LayoutData>(context).backgroundDisable;
    openDrawer ? controller.forward() : controller.reverse();
    return Stack(
      children: [
        if (event != null)
          Positioned(
            top: 200,
            left: -350,
            child: Transform.translate(
              offset: Offset((animation.value * (350 / 150)), 0.0),
              child: Container(
                  // top drawer container
                  height: 525,
                  width: 350,
                  color: ColorDefs.colorTopDrawerBackground,
                  child: Column(children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: event.color,
                      child: Center(
                          child: Text(event.message, style: event.textStyle)),
                    ),
                    Container(
                        height: 35.4,
                        width: double.infinity,
                        color: ColorDefs.colorTopDrawerAlternating,
                        child: Center(
                            child: Text("Schedule Audit",
                                style: ColorDefs.textDayHeadings))),
                    Container(
                        height: 35.4,
                        width: double.infinity,
                        child: Center(
                            child: Text("Forms",
                                style: ColorDefs.textDayHeadings))),
                    Container(
                        height: 35.4,
                        width: double.infinity,
                        color: ColorDefs.colorTopDrawerAlternating,
                        child: Center(
                            child: Text("Contacts",
                                style: ColorDefs.textDayHeadings))),
                    Container(
                        height: 35.4,
                        width: double.infinity,
                        child: Center(
                            child: Text("View",
                                style: ColorDefs.textDayHeadings))),
                    Container(
                        height: 35.4,
                        width: double.infinity,
                        color: ColorDefs.colorTopDrawerAlternating,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(Icons.sync, color: ColorDefs.colorAudit2),
                            Center(
                                child: Text("Sync",
                                    style: ColorDefs.textDayHeadings)),
                            Icon(Icons.sync,
                                color: ColorDefs.colorTopDrawerBackground),
                          ],
                        )),
                  ])),
            ),
          ),
      ],
    );
  }
}
