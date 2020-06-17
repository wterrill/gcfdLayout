import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

class AuditInfoDialog extends StatelessWidget {
  final CalendarResult calendarResult;
  const AuditInfoDialog({Key key, this.calendarResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 500,
        width: 350,
        child: Column(
          children: [
            //Site Name
            Expanded(
              flex: 1,
              child: Container(
                color: calendarResult.programTypeColor,
                child: Center(
                    child: AutoSizeText(calendarResult.agencyName,
                        textAlign: TextAlign.center,
                        style: ColorDefs.textBodyWhite20)),
              ),
            ),
            // Audit type and time
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: AutoSizeText(
                            'Audit type: ${calendarResult.auditType} - ${calendarResult.programType}',
                            style: ColorDefs.textBodyWhite15),
                      ),
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: AutoSizeText(
                            'Program Number: ${calendarResult.programNum}',
                            style: ColorDefs.textBodyWhite15),
                      ),
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: AutoSizeText(
                            'Auditor: ${calendarResult.programType}',
                            style: ColorDefs.textBodyWhite15),
                      ),
                      Container(
                        // Audit Type
                        color: Colors.black,
                        child: AutoSizeText('Status: ${calendarResult.status}',
                            style: ColorDefs.textBodyWhite15),
                      ),
                      Container(
                        color: Colors.black,
                        child: AutoSizeText(
                            'Start time: ${DateFormat.yMd().add_jm().format(calendarResult.startDateTime)}',
                            style: ColorDefs.textBodyWhite15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Address block and map pic.
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (calendarResult.siteInfo?.address1 != null)
                    Container(
                      // color: Colors.grey,
                      child: AutoSizeText(calendarResult.siteInfo.address1,
                          style: ColorDefs.textBodyBlue20),
                    ),
                  if (calendarResult.siteInfo?.address2 != null)
                    Container(
                      // color: Colors.grey,
                      child: AutoSizeText(calendarResult.siteInfo.address2,
                          style: ColorDefs.textBodyBlue20),
                    ),
                  if (calendarResult.siteInfo?.city != null)
                    Container(
                      // color: Colors.grey,
                      child: AutoSizeText(
                          '${calendarResult.siteInfo.city}, ${calendarResult.siteInfo.state ?? ""},  ${calendarResult.siteInfo.zip ?? ""},',
                          style: ColorDefs.textBodyBlue20),
                    ),
                  if (calendarResult.siteInfo?.contact != null)
                    Container(
                      // color: Colors.grey,
                      child: AutoSizeText('${calendarResult.siteInfo.contact}',
                          style: ColorDefs.textBodyBlue20),
                    ),
                  if (calendarResult.siteInfo?.operateHours != null)
                    Container(
                        child: AutoSizeText.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Open: ', style: ColorDefs.textBodyBlue20),
                          TextSpan(
                              text: ' ${calendarResult.siteInfo.operateHours}',
                              style: ColorDefs.textBodyWhite20),
                        ],
                      ),
                      minFontSize: 5,
                    )),
                ],
              ),
            ),

            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
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

                              switch (calendarResult.programType) {
                                case "Healthy Student Market":
                                  Dialogs.showNotImplemented(context);
                                  break;

                                case "Senior Adults Program":
                                  Dialogs.showNotImplemented(context);
                                  break;
                                case "Pantry Audit":
                                  bool alreadyExist = Provider.of<AuditData>(
                                          context,
                                          listen: false)
                                      .getAudit(calendarResult);
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (context) => AuditPage(
                                            calendarResult: calendarResult,
                                            alreadyExist: alreadyExist)),
                                  );
                                  break;
                                case "Congregate Audit":
                                  Dialogs.showNotImplemented(context);
                                  break;
                                default:
                                  Dialogs.showNotImplemented(context);
                              }
                            },
                            child: AutoSizeText('Begin Audit',
                                style: ColorDefs.textBodyWhite20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                              child: AutoSizeText('Edit Audit',
                                  style: ColorDefs.textBodyBronze20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
