import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HiveTroubleShooting extends StatefulWidget {
  HiveTroubleShooting({Key key}) : super(key: key);

  @override
  _HiveTroubleShootingState createState() => _HiveTroubleShootingState();
}

List<dynamic> result = <String>["press the buttons"];

class _HiveTroubleShootingState extends State<HiveTroubleShooting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => ListSchedulingPage()),
                );
              },
              child: Text("Go to scheduling page")),
          RaisedButton(
            child: Text("calendarBoxKeys"),
            onPressed: () {
              result = Provider.of<ListCalendarData>(context, listen: false)
                  .calendarBox
                  .keys
                  .toList();
              setState(() {});
            },
          ),
          RaisedButton(
            child: Text("toSendKeys"),
            onPressed: () {
              result = Provider.of<ListCalendarData>(context, listen: false)
                  .calToBeSentBox
                  .keys
                  .toList();
              setState(() {});
            },
          ),
          RaisedButton(
            child: Text("toDeleteKeys"),
            onPressed: () {
              result = Provider.of<ListCalendarData>(context, listen: false)
                  .calToBeDeletedBox
                  .keys
                  .toList();
              setState(() {});
            },
          ),
          RaisedButton(
            child: Text("Clear"),
            onPressed: () {
              result = <String>['Cleared'];
              setState(() {});
            },
          ),
          Text(result.toString())
        ],
      ),
    );
  }
}
