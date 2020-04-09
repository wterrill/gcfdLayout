import 'package:flutter/material.dart';
import 'package:gcfdlayout/buildTime/flutterVersion.dart';
import 'package:gcfdlayout/buildTime/flutterDate.dart';

class Dialogs {
  static void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showVersionDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Built and uploaded on: $buildDate'),
          Text("Flutter framework: ${version['frameworkVersion']}"),
          Text("Dart version: ${version['dartSdkVersion']}"),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
