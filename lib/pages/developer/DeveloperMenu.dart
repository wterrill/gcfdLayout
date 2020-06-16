import 'package:auditor/pages/developer/pdf/PdfDemo.dart';
// import 'package:auditor/pages/developer/pdf/showPdfDocument.dart';
// import 'package:auditor/pages/developer/pdf/writePdfDocument.dart';
import 'package:flutter/material.dart';

import 'authenticationEndpoint.dart/testAuthentication.dart';
import 'fingerSign/fingerSign.dart';
import 'hiveTest/Contact.dart';
import 'hiveTest/HiveTest.dart';
import 'lookAhead/lookAhead.dart';
import 'videoGame/VideoGame.dart';
import 'package:hive/hive.dart';

class DeveloperMenu extends StatelessWidget {
  const DeveloperMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FlatButton(
                color: Colors.red,
                child: Text("Navigate back"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
//          Container(
//            child: FlatButton(
//                color: Colors.red,
//                child: Text("pdf generation"),
//                onPressed: () {
//                  Navigator.push<dynamic>(
//                    context,
//                    MaterialPageRoute<dynamic>(
//                        builder: (context) => PdfCreate()),
//                  );
//                }),
//          ),
//          Container(
//            child: FlatButton(
//              color: Colors.red,
//              child: Text("pdf viewing"),
//              onPressed: () {
//                Navigator.push<dynamic>(
//                  context,
//                  MaterialPageRoute<dynamic>(builder: (context) => PDFScreen()),
//                );
//              },
//            ),
//          ),
          FlatButton(
            color: Colors.red,
            child: Text("finger signing"),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(builder: (context) => FingerSign()),
              );
            },
          ),

          FlatButton(
            color: Colors.red,
            child: Text("Look Ahead"),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(builder: (context) => LookAhead()),
              );
            },
          ),

          FlatButton(
            color: Colors.red,
            child: Text("Pdf generation and display"),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(builder: (context) => PdfDemo()),
              );
            },
          ),

          FlatButton(
            color: Colors.red,
            child: Text("Date picker"),
            onPressed: () async {
              DateTime selectedDate;
              selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2018),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              );
              print(selectedDate);
            },
          ),

          FlatButton(
            color: Colors.red,
            child: Text("Time picker"),
            onPressed: () async {
              TimeOfDay selectedTimeRTL = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget child) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: child,
                  );
                },
              );
              print(selectedTimeRTL);
            },
          ),

          // FlatButton(
          //   color: Colors.red,
          //   child: Text("videogame"),
          //   onPressed: () {
          //     Navigator.push<dynamic>(
          //       context,
          //       MaterialPageRoute<dynamic>(builder: (context) => VideoGame()),
          //     );
          //   },
          // ),
          FlatButton(
            color: Colors.red,
            child: Text("hive test"),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (context) => FutureBuilder<dynamic>(
                    future: Hive.openBox<Contact>('contacts'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return HiveTest();
                      } else
                        return Scaffold();
                    },
                  ),
                ),
              );
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text("Authentication"),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (context) => TestAuthentication()),
              );
            },
          ),
        ],
      ),
    );
  }
}
