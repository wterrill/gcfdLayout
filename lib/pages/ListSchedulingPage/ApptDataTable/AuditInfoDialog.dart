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
    bool auditAlreadyStarted = Provider.of<AuditData>(context, listen: false).auditExists(calendarResult);

    // Widget oldVersion = Material(
    //   child: Container(
    //     decoration: BoxDecoration(color: ColorDefs.colorTopHeader, borderRadius: BorderRadius.all(Radius.circular(25.0))),
    //     height: 500,
    //     width: 700,
    //     child: Column(
    //       children: [
    //         //Site Name
    //         Expanded(
    //           flex: 1,
    //           child: Container(
    //             color: calendarResult.programTypeColor,
    //             child: Center(child: AutoSizeText(calendarResult.agencyName, textAlign: TextAlign.center, style: ColorDefs.textBodyWhite20)),
    //           ),
    //         ),
    //         // Audit type and time
    //         Expanded(
    //           flex: 3,
    //           child: Container(
    //             width: double.infinity,
    //             color: Colors.black,
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Container(
    //                     // Audit Type
    //                     color: Colors.black,
    //                     child: AutoSizeText('Audit type: ${calendarResult.auditType} - ${calendarResult.programType}', style: ColorDefs.textBodyWhite15),
    //                   ),
    //                   Container(
    //                     // Audit Type
    //                     color: Colors.black,
    //                     child: AutoSizeText('Program Number: ${calendarResult.programNum}', style: ColorDefs.textBodyWhite15),
    //                   ),
    //                   Container(
    //                     // Audit Type
    //                     color: Colors.black,
    //                     child: AutoSizeText('Auditor: ${calendarResult.auditor}', style: ColorDefs.textBodyWhite15),
    //                   ),
    //                   Container(
    //                     // Audit Type
    //                     color: Colors.black,
    //                     child: AutoSizeText('Status: ${calendarResult.status}', style: ColorDefs.textBodyWhite15),
    //                   ),
    //                   Container(
    //                     color: Colors.black,
    //                     child: AutoSizeText('Start time: ${DateFormat.yMd().add_jm().format(calendarResult.startDateTime)}', style: ColorDefs.textBodyWhite15),
    //                   ),
    //                   Container(
    //                     color: Colors.black,
    //                     child: AutoSizeText('DeviceID: ${calendarResult.deviceid}', style: ColorDefs.textBodyBronze15),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         // Address block and map pic.
    //         Expanded(
    //           flex: 4,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               if (calendarResult.siteInfo?.address1 != null)
    //                 Container(
    //                   // color: Colors.grey,
    //                   child: AutoSizeText(calendarResult.siteInfo.address1, style: ColorDefs.textBodyBlue20),
    //                 ),
    //               if (calendarResult.siteInfo?.address2 != null)
    //                 Container(
    //                   // color: Colors.grey,
    //                   child: AutoSizeText(calendarResult.siteInfo.address2, style: ColorDefs.textBodyBlue20),
    //                 ),
    //               if (calendarResult.siteInfo?.city != null)
    //                 Container(
    //                   // color: Colors.grey,
    //                   child: AutoSizeText('${calendarResult.siteInfo.city}, ${calendarResult.siteInfo.state ?? ""},  ${calendarResult.siteInfo.zip ?? ""},',
    //                       style: ColorDefs.textBodyBlue20),
    //                 ),
    //               if (calendarResult.siteInfo?.contact != null)
    //                 Container(
    //                   // color: Colors.grey,
    //                   child: AutoSizeText('${calendarResult.siteInfo.contact}', style: ColorDefs.textBodyBlue20),
    //                 ),
    //               // if (calendarResult.siteInfo?.contactEmail != null)
    //               //   Container(
    //               //     // color: Colors.grey,
    //               //     child: AutoSizeText(
    //               //         '${calendarResult.siteInfo.contactEmail}',
    //               //         style: ColorDefs.textBodyBlue20),
    //               //   ),
    //               if (calendarResult.siteInfo?.operateHours != null)
    //                 Container(
    //                     child: RaisedButton(
    //                         onPressed: () {
    //                           Dialogs.showMessage(
    //                               context: context,
    //                               message: calendarResult.siteInfo.operateHours.replaceAll("\$", "").replaceAll("||", "    ").replaceAll("\\n", "\n\n").replaceAll("|", "   "),
    //                               dismissable: true);
    //                         },
    //                         child: Text("Show operating hours"))
    //                     //     AutoSizeText.rich(
    //                     //   TextSpan(
    //                     //     children: <TextSpan>[("")
    //                     //       TextSpan(
    //                     //           text: 'Open: ', style: ColorDefs.textBodyBlue20),
    //                     //       TextSpan(
    //                     //           text: ' ${calendarResult.siteInfo.operateHours}',
    //                     //           style: ColorDefs.textBodyWhite20),
    //                     //     ],
    //                     //   ),
    //                     //   minFontSize: 5,
    //                     // ),
    //                     ),
    //             ],
    //           ),
    //         ),

    //         Expanded(
    //           flex: 3,
    //           child: Column(
    //             children: [
    //               Container(
    //                 color: Colors.black,
    //                 child: Center(
    //                   child: ListTile(
    //                     title: DecoratedBox(
    //                       decoration:
    //                           BoxDecoration(color: ColorDefs.colorUserAccent, borderRadius: BorderRadius.circular(50.0), border: Border.all(width: 2.0, color: Colors.transparent)),
    //                       child: FlatButton(
    //                         disabledTextColor: Colors.blue,
    //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    //                         onPressed: () {
    //                           Provider.of<AuditData>(context, listen: false).toggleStartAudit();

    //                           // switch (calendarResult.programType) {
    //                           //   case "Healthy Student Market":
    //                           //     Dialogs.showNotImplemented(context);
    //                           //     break;

    //                           //   case "Senior Adults Program":
    //                           //     Dialogs.showNotImplemented(context);
    //                           //     break;
    //                           //   case "Pantry":
    //                           Navigator.of(context).pop();
    //                           Navigator.push<dynamic>(
    //                             context,
    //                             MaterialPageRoute<dynamic>(
    //                               builder: (context) => AuditPage(calendarResult: calendarResult, alreadyExist: alreadyExist),
    //                             ),
    //                           );

    //                           //     break;
    //                           //   case "Congregate":
    //                           //     Navigator.of(context).pop();
    //                           //     Navigator.push<dynamic>(
    //                           //       context,
    //                           //       MaterialPageRoute<dynamic>(
    //                           //         builder: (context) => AuditPage(
    //                           //             calendarResult: calendarResult,
    //                           //             alreadyExist: alreadyExist),
    //                           //       ),
    //                           //     );
    //                           //     break;
    //                           //   default:
    //                           //     Dialogs.showNotImplemented(context);
    //                           // }
    //                         },
    //                         child: AutoSizeText(alreadyExist ? 'View Audit' : 'Begin Audit', style: ColorDefs.textBodyWhite20),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               if (!alreadyExist)
    //                 Container(
    //                   color: Colors.black,
    //                   child: Center(
    //                     child: Padding(
    //                       padding: const EdgeInsets.only(bottom: 10.0),
    //                       child: ListTile(
    //                         title: DecoratedBox(
    //                           decoration: BoxDecoration(
    //                               color: Colors.transparent, borderRadius: BorderRadius.circular(50.0), border: Border.all(width: 2.0, color: ColorDefs.colorBigDrawerBronze)),
    //                           child: FlatButton(
    //                             disabledTextColor: Colors.blue,
    //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    //                             onPressed: () {
    //                               bool followup = false;
    //                               if (calendarResult.auditType == "Follow Up") {
    //                                 followup = true;
    //                               }
    //                               Dialogs.showRescheduleAudit(context, calendarResult: calendarResult, followup: followup);
    //                             },
    //                             child: AutoSizeText('Revise Audit', style: ColorDefs.textBodyBronze20),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               if (calendarResult.status == "Site Visit Req.")
    //                 Container(
    //                   color: Colors.black,
    //                   child: Center(
    //                     child: Padding(
    //                       padding: const EdgeInsets.only(bottom: 10.0),
    //                       child: ListTile(
    //                         title: DecoratedBox(
    //                           decoration: BoxDecoration(
    //                               color: Colors.transparent, borderRadius: BorderRadius.circular(50.0), border: Border.all(width: 2.0, color: ColorDefs.colorBigDrawerBronze)),
    //                           child: FlatButton(
    //                             disabledTextColor: Colors.blue,
    //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    //                             onPressed: () {
    //                               Dialogs.showRescheduleAudit(context, calendarResult: calendarResult, followup: true);
    //                             },
    //                             child: AutoSizeText('Schedule Followup Audit', style: ColorDefs.textBodyBronze20),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    Widget newWidget = Container(
        decoration:
            BoxDecoration(color: ColorDefs.colorTopHeader, borderRadius: BorderRadius.all(Radius.circular(25.0))),
        height: 700,
        width: 600,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    decoration: BoxDecoration(
                        color: calendarResult.programTypeColor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(calendarResult.agencyName,
                              // textAlign: TextAlign.left,
                              style: ColorDefs.textBodyWhite30),
                          // Spacer(),
                          Container(height: 0),
                          if (calendarResult.siteInfo?.address1 != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText(calendarResult.siteInfo.address1, style: ColorDefs.textBodyWhite20),
                            ),
                          if (calendarResult.siteInfo?.address2 != null && calendarResult.siteInfo?.address2 != "")
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText(calendarResult.siteInfo.address2, style: ColorDefs.textBodyWhite20),
                            ),
                          if (calendarResult.siteInfo?.city != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText(
                                  '${calendarResult.siteInfo.city}, ${calendarResult.siteInfo.state ?? ""},  ${calendarResult.siteInfo.zip ?? ""}',
                                  style: ColorDefs.textBodyWhite20),
                            ),
                          Spacer(),
                          if (calendarResult.siteInfo?.contact != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText('Contact Name: ${calendarResult.siteInfo.contact}',
                                  style: ColorDefs.textBodyWhiteBold20),
                            ),
                          if (calendarResult.siteInfo?.contactEmail != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText('${calendarResult.siteInfo.contactEmail}',
                                  style: ColorDefs.textBodyWhite20),
                            ),
                          Spacer(),

                          FlatButton(
                            color: ColorDefs.colorTopHeader,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: ColorDefs.colorLogoLightGreen, width: 3.0),
                            ),
                            onPressed: () {
                              Dialogs.showSites(
                                  context: context, agencyNum: calendarResult.agencyNum, singleSite: true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                              child: Text("Site Information", style: ColorDefs.textBodyBlack20),
                            ),
                          ),
                        ],
                      ),
                    ))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorDefs.colorAlternatingDark,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10),
                      AutoSizeText("Audit Notes",
                          // textAlign: TextAlign.left,
                          style: ColorDefs.textBodyWhite30),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Start Time:", style: ColorDefs.textBodyWhite25),
                              Text("Program Number:", style: ColorDefs.textBodyWhite25),
                              Text("Audit Type:", style: ColorDefs.textBodyWhite25),
                              Text("Auditor:", style: ColorDefs.textBodyWhite25),
                              Text("Status:", style: ColorDefs.textBodyWhite25)
                            ],
                          ),
                          Container(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${DateFormat.yMd().add_jm().format(calendarResult.startDateTime)}',
                                  style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.programNum}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.auditType}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.auditor}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.status}', style: ColorDefs.textBodyWhite25),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            color: ColorDefs.colorTopHeader,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),

                            // disabledTextColor: Colors.blue,
                            onPressed: () {
                              Provider.of<AuditData>(context, listen: false).toggleStartAudit();
                              Navigator.of(context).pop();
                              Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (context) => AuditPage(
                                      calendarResult: calendarResult, auditAlreadyStarted: auditAlreadyStarted),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                              child: AutoSizeText(auditAlreadyStarted ? 'View Audit' : 'Begin Audit',
                                  style: ColorDefs.textBodyBlack20),
                            ),
                          ),
                          // FlatButton(
                          //   color: ColorDefs.colorTopHeader,
                          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0), side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),
                          //   onPressed: () async {

                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                          //     child: Text("Delete Audit", style: ColorDefs.textBodyBlack20),
                          //   ),
                          // ),
                          if (!(calendarResult.status == "Completed" || calendarResult.status == "Site Visit Req."))
                            FlatButton(
                              color: ColorDefs.colorTopHeader,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),
                              onPressed: () {
                                bool followup = false;
                                if (calendarResult.auditType == "Follow Up") {
                                  followup = true;
                                }
                                Dialogs.showRescheduleAudit(context,
                                    calendarResult: calendarResult,
                                    followup: followup,
                                    auditAlreadyStarted: auditAlreadyStarted);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                                child: AutoSizeText('Revise Audit', style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                          if (calendarResult.status == "Site Visit Req.")
                            FlatButton(
                              color: ColorDefs.colorTopHeader,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),
                              onPressed: () {
                                Dialogs.showRescheduleAudit(context,
                                    calendarResult: calendarResult, followup: true, auditAlreadyStarted: false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                                child: AutoSizeText('Schedule Followup', style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));

    return newWidget;
  }
}
