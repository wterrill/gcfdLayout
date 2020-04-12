import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/colorDefs.dart';

class TopDrawer extends StatefulWidget {
  TopDrawer({Key key}) : super(key: key);

  @override
  _TopDrawerState createState() => _TopDrawerState();
}

class TopDrawerMenu {
  final String text;
  final double height;
  final bool haveIcon;
  final Color color;
  final TextStyle style;
  final IconData icon;
  TopDrawerMenu(
      {@required this.text,
      @required this.haveIcon,
      @required this.color,
      this.icon,
      @required this.height,
      @required this.style});

  Widget makeDrawer() {
    Widget finalWidget;
    if (haveIcon) {
      finalWidget = Container(
          height: height,
          width: double.infinity,
          color: color,
          child: Center(child: Text(text, style: style)));
    } else {
      finalWidget = Container(
        height: height,
        width: double.infinity,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(icon, color: ColorDefs.colorAudit2),
            Center(child: Text(text, style: style)),
            // Icon(Icons.sync, color: ColorDefs.colorTopDrawerBackground),
          ],
        ),
      );
    }
    return finalWidget;
  }
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
    List<Widget> topDrawerMenu() {
      List<Map<String, dynamic>> defineMenu = [
        <String, dynamic>{'text': "", 'height': 40, 'haveIcon': false},
        <String, dynamic>{
          'text': "Schedule Audit",
          'height': 40,
          'haveIcon': false,
          'style': ColorDefs.textDayHeadings,
        },
        <String, dynamic>{
          'text': "Forms",
          'height': 40,
          'haveIcon': false,
          'style': ColorDefs.textDayHeadings
        },
        <String, dynamic>{
          'text': "Contacts",
          'height': 40,
          'haveIcon': false,
          'style': ColorDefs.textDayHeadings
        },
        <String, dynamic>{
          'text': "View",
          'height': 40,
          'haveIcon': false,
          'style': ColorDefs.textDayHeadings
        },
        <String, dynamic>{
          'text': "Sync",
          'height': 40,
          'haveIcon': true,
          'style': ColorDefs.textDayHeadings,
          'icon': Icons.sync
        },
      ];
      List<Widget> finalList = [];
      for (int i = 0; i < defineMenu.length; i++) {
        print(i.isOdd);
        finalList.add(TopDrawerMenu(
                text: defineMenu[i]['text'] as String,
                height: defineMenu[i]['height'] as double,
                haveIcon: defineMenu[i]['haveIcon'] as bool,
                style: defineMenu[i]['style'] as TextStyle,
                color: i.isOdd
                    ? ColorDefs.colorTopDrawerAlternating
                    : ColorDefs.colorTopDrawerBackground,
                icon: defineMenu[i]['icon'] as IconData)
            .makeDrawer());
      }
      return finalList;
    }

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
                child: Column(children: [...topDrawerMenu()])),
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
