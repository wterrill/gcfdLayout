import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class DatabaseDetails extends StatelessWidget {
  const DatabaseDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box auditBox = Provider.of<AuditData>(context).auditBox;
    Box auditOutBox = Provider.of<AuditData>(context).auditOutBox;

    Box calendarBox = Provider.of<ListCalendarData>(context).calendarBox;
    Box calendarDeleteBox = Provider.of<ListCalendarData>(context).calendarDeleteBox;
    Box calendarEditOutBox = Provider.of<ListCalendarData>(context).calendarEditOutBox;
    Box calendarOutBox = Provider.of<ListCalendarData>(context).calendarOutBox;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            Text("auditBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: auditBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Audit gotAudit = auditBox.get(auditBox.keys.toList()[index].toString()) as Audit;
                          Dialogs.showMessage(context: context, message: gotAudit.toString(), dismissable: true);
                        },
                        child: Text(auditBox.keys.toList()[index].toString()));
                  }),
            ),
            Container(height: 50),
            Text("auditOutBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: auditOutBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Audit gotIt = auditOutBox.get(auditOutBox.keys.toList()[index].toString()) as Audit;
                          Dialogs.showMessage(context: context, message: gotIt.toString(), dismissable: true);
                        },
                        child: Text(auditOutBox.keys.toList()[index].toString()));
                  }),
            ),
            Container(height: 50),
            Text("calendarBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: calendarBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          CalendarResult gotIt =
                              calendarBox.get(calendarBox.keys.toList()[index].toString()) as CalendarResult;
                          Dialogs.showMessage(context: context, message: gotIt.toString(), dismissable: true);
                        },
                        child: Text(calendarBox.keys.toList()[index].toString()));
                  }),
            ),
            Text("calendarDeleteBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: calendarDeleteBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          CalendarResult gotIt = calendarDeleteBox
                              .get(calendarDeleteBox.keys.toList()[index].toString()) as CalendarResult;
                          Dialogs.showMessage(context: context, message: gotIt.toString(), dismissable: true);
                        },
                        child: Text(calendarDeleteBox.keys.toList()[index].toString()));
                  }),
            ),
            Text("calendarEditOutBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: calendarEditOutBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          CalendarResult gotIt = calendarEditOutBox
                              .get(calendarEditOutBox.keys.toList()[index].toString()) as CalendarResult;
                          Dialogs.showMessage(context: context, message: gotIt.toString(), dismissable: true);
                        },
                        child: Text(calendarEditOutBox.keys.toList()[index].toString()));
                  }),
            ),
            Text("calendarOutBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: calendarOutBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          CalendarResult gotIt =
                              calendarOutBox.get(calendarOutBox.keys.toList()[index].toString()) as CalendarResult;
                          Dialogs.showMessage(context: context, message: gotIt.toString(), dismissable: true);
                        },
                        child: Text(calendarOutBox.keys.toList()[index].toString()));
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
