import 'package:auditor/Definitions/Site.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/AuditInfoDialog.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:auditor/pages/ListSchedulingPage/NewAuditDialog.dart';
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

  static void showSites(BuildContext context, List<Site> siteList) {
    AlertDialog alert = AlertDialog(
      elevation: 6.0,
      content: Container(
        width: 600,
        height: 900,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: siteList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (siteList[index].agencyName != null)
                    Text(siteList[index].agencyName),
                  if (siteList[index].agencyNumber != null)
                    Text(siteList[index].agencyNumber),
                  if (siteList[index].address1 != null)
                    Text(siteList[index].address1),
                  if (siteList[index].address2 != null)
                    Text(siteList[index].address2),
                  if (siteList[index].city != null) Text(siteList[index].city),
                  if (siteList[index].state != null)
                    Text(siteList[index].state),
                  if (siteList[index].zip != null) Text(siteList[index].zip),
                  if (siteList[index].contact != null)
                    Text(siteList[index].contact),
                  if (siteList[index].operateHours != null)
                    Text(siteList[index].operateHours),
                  if (siteList[index].programName != null)
                    Text(siteList[index].programName),
                  if (siteList[index].programNumber != null)
                    Text(siteList[index].programNumber),
                  if (siteList[index].serviceArea != null)
                    Text(siteList[index].serviceArea),
                  if (siteList[index].programDisplayName != null)
                    Text(siteList[index].programDisplayName),
                ],
              ));
            }),
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

  static void failedAuthentication(BuildContext context) {
    AlertDialog alert = AlertDialog(
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Username or password is not correct.  Please try again.'),
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
          Text('This program type is not yet available'),
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

  static void showBadSchedule(BuildContext context) {
    AlertDialog alert = AlertDialog(
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              'This audit cannot be scheduled as entered.  Please verify that all fields are filled.'),
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
          // title: Text("Audit Info"),
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
