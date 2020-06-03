// import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/AuditInfoDialog.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:auditor/pages/ListSchedulingPage/NewAuditDialog.dart';
import 'package:auditor/pages/developer/DeveloperMenu.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/buildTime/flutterVersion.dart';
import 'package:auditor/buildTime/flutterDate.dart';
// import 'package:provider/provider.dart';

// import 'colorDefs.dart';

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

  static void showAuditInfo(
      BuildContext context, CalendarResult calendarResult) {
    showDialog<void>(
      context: context, //navigatorKey.currentState.overlay.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Audit Info"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: AuditInfoDialog(calendarResult: calendarResult)));
            },
          ),
        );
      },
    );
  }

  static void showScheduledAudit(
    BuildContext context,
  ) {
    showGeneralDialog<void>(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text('Schedule a New Audit:'),
                content: NewAuditDialog(),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: "Beer",
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Text("Beer?");
        });
  }

  static void showRescheduleAudit(
      BuildContext context, CalendarResult calendarResult) {
    showGeneralDialog<void>(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text('Reschedule this Audit:'),
                content: NewAuditDialog(calendarResult: calendarResult),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: "Beer",
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Text("Beer?");
        });
  }
}
