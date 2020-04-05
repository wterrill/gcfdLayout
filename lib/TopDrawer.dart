import 'package:flutter/material.dart';

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
              height: 325,
              width: 175,
              color: Colors.pink,
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
                height: 25,
                width: 25,
                color: Colors.pink,
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
