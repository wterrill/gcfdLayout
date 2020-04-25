import 'package:auditor/pages/developer/DeveloperMenu.dart';
import 'package:flutter/material.dart';
import 'package:auditor/buildTime/flutterVersion.dart';
import 'package:auditor/buildTime/flutterDate.dart';

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

  static void showNotImplemented(BuildContext context) {
    AlertDialog alert = AlertDialog(
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This functionality is not yet available'),
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

  static void showPdfCreated(BuildContext context) {
    AlertDialog alert = AlertDialog(
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The pdf has been created'),
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

  static void showDeveloperMenu(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Open developer Menu?'),
      content: const Text('Do you want to open the developer menu?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: const Text('ACCEPT'),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => DeveloperMenu()),
            );
          },
        )
      ],
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
