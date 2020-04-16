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
                    Expanded(
                      flex: 1,
                      // height: 40,
                      // width: double.infinity,

                      child: Container(
                        color: event.color,
                        child: Center(
                            child: Text(event.message, style: event.textStyle)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      // height: 40,
                      // width: double.infinity,

                      child: Container(
                        color: Colors.black,
                        child: Center(
                            child: Text("policy and hours block",
                                style: event.textStyle)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      // height: 40,
                      // width: double.infinity,

                      child: Container(
                        color: Colors.grey,
                        child: Center(
                            child: Text("Address and map block",
                                style: event.textStyle)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      // height: 40,
                      // width: double.infinity,

                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: ListTile(
                            title: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: ColorDefs.colorUserAccent,
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      width: 2.0, color: Colors.grey)),
                              child: FlatButton(
                                disabledTextColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                onPressed: () {
                                  print("pressed navigate button");
                                },
                                child: Text('Navigate Me',
                                    style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      // height: 40,
                      // width: double.infinity,

                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: ListTile(
                            title: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: ColorDefs.colorUserAccent,
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      width: 2.0, color: Colors.transparent)),
                              child: FlatButton(
                                disabledTextColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                onPressed: () {
                                  print("pressed begin audit button");
                                },
                                child: Text('Begin Audit',
                                    style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      // height: 40,
                      // width: double.infinity,

                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: ListTile(
                            title: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: ColorDefs.colorUserAccent,
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      width: 2.0, color: Colors.transparent)),
                              child: FlatButton(
                                disabledTextColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                onPressed: () {
                                  print("pressed reschedule Audit button");
                                },
                                child: Text('Reschedule Audit',
                                    style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
            ),
          ),
      ],
    );
  }
}
