import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/Event.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:provider/provider.dart';

class BigDrawerWidget extends StatefulWidget {
  BigDrawerWidget({Key key}) : super(key: key);

  @override
  _BigDrawerWidgetState createState() => _BigDrawerWidgetState();
}

class _BigDrawerWidgetState extends State<BigDrawerWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
//  bool _drawerState;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    var curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInQuart)
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
    Size dimensions = MediaQuery.of(context).size;
    openDrawer ? controller.forward() : controller.reverse();
    return Stack(
      children: [
        if (event != null)
          Positioned(
            top: dimensions.height * 0.15,
            left: -350,
            child: Transform.translate(
              offset: Offset((animation.value * (350 / 150)), 0.0),
              child: Container(
                  // Big drawer container
                  height: dimensions.height * 0.8,
                  width:
                      (dimensions.width > 350) ? 350 : dimensions.width * 0.8,
                  color: ColorDefs.colorTopDrawerBackground,
                  child: Column(children: [
                    //Site Name
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: event.color,
                        child: Center(
                            child: AutoSizeText(event.siteName,
                                style: event.textStyle)),
                      ),
                    ),
                    // Audit type and time
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            // Audit Type
                            color: Colors.black,
                            child: Center(
                                child: AutoSizeText(event.auditType,
                                    style: event.textStyle)),
                          ),
                          Container(
                            color: Colors.black,
                            child: Center(
                                // time
                                child: AutoSizeText(
                                    '${event.getStartTime()} - ${event.getEndTime()}',
                                    style: event.textStyle)),
                          ),
                        ],
                      ),
                    ),
                    // Address block and map pic.
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // color: Colors.grey,
                                child: AutoSizeText(
                                    event.siteInfo.addressStreet,
                                    style: ColorDefs.textBodyBlue20),
                              ),
                              Container(
                                // color: Colors.grey,
                                child: AutoSizeText(
                                    '${event.siteInfo.city}, ${event.siteInfo.state},  ${event.siteInfo.zip},',
                                    style: ColorDefs.textBodyBlue20),
                              ),
                              Container(
                                // color: Colors.grey,
                                child: AutoSizeText('${event.siteInfo.phone}',
                                    style: ColorDefs.textBodyBlue20),
                              ),
                              Container(
                                  child: AutoSizeText.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Open: ',
                                        style: ColorDefs.textBodyBlue20),
                                    TextSpan(
                                        text:
                                            ' ${event.siteInfo.hoursOfOperation}',
                                        style: ColorDefs.textBodyWhite20),
                                  ],
                                ),
                                minFontSize: 5,
                              )),
                            ],
                          ),
                          Image(
                            fit: BoxFit.fitWidth,
                            image: AssetImage('assets/images/location.jpg'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: ListTile(
                            title: DecoratedBox(
                              decoration: BoxDecoration(
                                color: ColorDefs.colorAudit2,
                                borderRadius: BorderRadius.circular(50.0),
                                // border: Border.all(
                                //     width: 2.0, color: Colors.grey)
                              ),
                              child: FlatButton(
                                // disabledTextColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                onPressed: () {
                                  Dialogs.showNotImplemented(context);
                                },
                                child: AutoSizeText('Navigate Me',
                                    style: ColorDefs.textBodyWhite20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                                  Provider.of<AuditData>(context, listen: false)
                                      .toggleStartAudit();
                                  Provider.of<LayoutData>(context,
                                          listen: false)
                                      .toggleBigDrawerWidget();
//                                  Dialogs.showNotImplemented(context);
                                },
                                child: AutoSizeText('Begin Audit',
                                    style: ColorDefs.textBodyWhite20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ListTile(
                              title: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: ColorDefs.colorBigDrawerBronze)),
                                child: FlatButton(
                                  disabledTextColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  onPressed: () {
                                    Dialogs.showNotImplemented(context);
                                  },
                                  child: AutoSizeText('Reschedule Audit',
                                      style: ColorDefs.textBodyBronze20),
                                ),
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
