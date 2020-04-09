import 'package:flutter/material.dart';
import 'package:gcfdlayout/definitions/colorDefs.dart';

class TopDrawer extends StatefulWidget {
  TopDrawer({Key key}) : super(key: key);

  @override
  _TopDrawerState createState() => _TopDrawerState();
}

class _TopDrawerState extends State<TopDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool _drawerState;

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
                          child:
                              Text("Forms", style: ColorDefs.textDayHeadings))),
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