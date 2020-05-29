import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'CalendarResult.dart';

class AuditInfoDialog extends StatelessWidget {
  final CalendarResult calendarResult;
  const AuditInfoDialog({Key key, this.calendarResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
              // Big drawer container
              height: 700,
              width: 350,
              color: ColorDefs.colorTopDrawerBackground,
              child: Column(children: [
                //Site Name
                Expanded(
                  flex: 1,
                  child: Container(
                    color: calendarResult.programTypeColor,
                    child: Center(
                        child: AutoSizeText(calendarResult.agency,
                            style: ColorDefs.textBodyWhite20)),
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
                            child: AutoSizeText(
                                'Audit type: ${calendarResult.auditType} - ${calendarResult.programType}',
                                style: ColorDefs.textBodyWhite15)),
                      ),
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: Center(
                            child: AutoSizeText(
                                'Program Number: ${calendarResult.programNum}',
                                style: ColorDefs.textBodyWhite15)),
                      ),
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: Center(
                            child: AutoSizeText(
                                'Auditor: ${calendarResult.programType}',
                                style: ColorDefs.textBodyWhite15)),
                      ),
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: Center(
                            child: AutoSizeText(
                                'Status: ${calendarResult.status}',
                                style: ColorDefs.textBodyWhite15)),
                      ),
                      Container(
                        color: Colors.black,
                        child: Center(
                            // time
                            child: AutoSizeText(
                                'Start time: ${DateFormat.yMd().add_jm().format(calendarResult.startDateTime)}',
                                style: ColorDefs.textBodyWhite15)),
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
                                calendarResult.siteInfo.addressStreet,
                                style: ColorDefs.textBodyBlue20),
                          ),
                          Container(
                            // color: Colors.grey,
                            child: AutoSizeText(
                                '${calendarResult.siteInfo.city}, ${calendarResult.siteInfo.state},  ${calendarResult.siteInfo.zip},',
                                style: ColorDefs.textBodyBlue20),
                          ),
                          Container(
                            // color: Colors.grey,
                            child: AutoSizeText(
                                '${calendarResult.siteInfo.phone}',
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
                                        ' ${calendarResult.siteInfo.hoursOfOperation}',
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

                              Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                    builder: (context) => AuditPage()),
                              );
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
                                  borderRadius: BorderRadius.circular(50.0)),
                              onPressed: () {
                                Dialogs.showRescheduleAudit(
                                    context, calendarResult);
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
        ],
      ),
    );
  }
}
