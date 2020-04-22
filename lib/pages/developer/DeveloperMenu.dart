import 'package:auditor/pages/developer/pdf/showPdfDocument.dart';
import 'package:auditor/pages/developer/pdf/writePdfDocument.dart';
import 'package:flutter/material.dart';

import 'fingerSign/fingerSign.dart';

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
                child: Text("Go back to Login Page"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          Container(
            child: FlatButton(
                color: Colors.red,
                child: Text("pdf generation"),
                onPressed: () {
                  writePdfDocument();
                }),
          ),
          Container(
            child: FlatButton(
              color: Colors.red,
              child: Text("pdf viewing"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => PDFScreen()),
                );
              },
            ),
          ),
          Container(
            child: FlatButton(
              color: Colors.red,
              child: Text("finger signing"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => FingerSign()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
