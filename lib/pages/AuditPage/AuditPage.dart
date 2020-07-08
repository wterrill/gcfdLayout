import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/pages/AuditPage/PhotoPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DeveloperPage.dart';
import 'FollowUpReviewSection/FollowUpReview.dart';
import 'ReviewSection/ReviewPage.dart';
import 'SectionButtons.dart';
import 'AuditQuestions.dart';
import 'VerificationGoodPage.dart';
import 'VerificationBadPage.dart';
import 'dart:typed_data';

class AuditPage extends StatefulWidget {
  final bool alreadyExist;
  final CalendarResult calendarResult;
  // final String programType;
  AuditPage(
      {Key key, @required this.calendarResult, @required this.alreadyExist})
      : super(key: key);
  @override
  _AuditPageState createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  Audit activeAudit;
  Section activeSection;
  void paintButtons() {
    for (Section section in activeAudit.sections) {
      print(section.status);

      // section.status = Status.available;
      // activeSection.status = Status.completed;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.alreadyExist) {
      Provider.of<AuditData>(context, listen: false)
          .loadExisting(widget.calendarResult);
    } else {
      Provider.of<AuditData>(context, listen: false)
          .createNewAudit(widget.calendarResult);
      if (widget.calendarResult.citationsToFollowUp != null) {
        Provider.of<AuditData>(context, listen: false)
            .buildQuestionFromCitation(widget.calendarResult);
        // List<Question> beer = Provider.of<AuditData>(context).previousCitations;
        // print(beer);
      }
    }
    activeAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
    activeSection =
        Provider.of<AuditData>(context, listen: false).activeSection;
    Provider.of<AuditData>(context, listen: false).citations =
        activeAudit.citations;
    Provider.of<AuditData>(context, listen: false).previousCitations =
        activeAudit.previousCitations;
    paintButtons();
  }

  @override
  Widget build(BuildContext context) {
    print("building AuditPage");

    Audit activeAudit = Provider.of<AuditData>(context).activeAudit;
    Section activeSection = Provider.of<AuditData>(context).activeSection;
    double mediaWidth = Provider.of<GeneralData>(context).mediaArea.width;
    double mediaHeight = Provider.of<GeneralData>(context).mediaArea.height;
    CalendarResult activeCalendarResult =
        Provider.of<AuditData>(context).activeCalendarResult;
    Uint8List siteRepresentativeSignature =
        Provider.of<AuditData>(context).siteRepresentativeSignature;
    Uint8List foodDepositoryMonitorSignature =
        Provider.of<AuditData>(context).foodDepositoryMonitorSignature;
    bool showSubmitButton = (siteRepresentativeSignature != null &&
            activeAudit.citations.length == 0 ||
        siteRepresentativeSignature != null &&
            foodDepositoryMonitorSignature != null);

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        textTheme: TextTheme(),
      ),
      home: Scaffold(
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: ColorDefs.colorTopHeader,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 2.0, color: Colors.grey)),
              height: mediaHeight * 0.95,
              width: mediaWidth * 0.9,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(child: SectionButtons(activeAudit: activeAudit)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: ColorDefs.colorAlternatingDark,
                        thickness: 1,
                      ),
                    ),
                    if (activeSection?.name == "Review")
                      ReviewPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Follow Up Review")
                      FollowUpReviewPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Photos")
                      PhotoPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Verification" &&
                        activeAudit.citations.length == 0)
                      VerificationGoodPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Verification" &&
                        activeAudit.citations.length != 0)
                      VerificationBadPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "*Developer*") DeveloperPage(),
                    if (activeSection?.name != "Review" &&
                        activeSection?.name != "Verification" &&
                        activeSection?.name != "Follow Up Review")
                      Container(
                        child: AuditQuestions(
                            activeSection: activeSection,
                            activecalendarResult: activeCalendarResult),
                      ),
                    if (activeSection?.name == "Confirm Details" &&
                        activeAudit.detailsConfirmed == false)
                      RaisedButton(
                        disabledColor: ColorDefs.colorButtonNeutral,
                        color: Colors.blue,
                        textColor: Colors.black,
                        child:
                            Text("Confirm", style: ColorDefs.textBodyBlack20),
                        onPressed: (false)
                            ? null
                            : () {
                                activeAudit.detailsConfirmed = true;
                                for (Section section in activeAudit.sections) {
                                  section.status = Status.available;
                                  section.lastStatus = Status.available;
                                  activeSection.status = Status.completed;
                                  activeSection.lastStatus = Status.completed;
                                  setState(() {});
                                }
                              },
                      ),
                    if (activeSection?.name == "Verification")
                      if (showSubmitButton)
                        RaisedButton(
                            disabledColor: ColorDefs.colorButtonNeutral,
                            color: Colors.blue,
                            textColor: Colors.black,
                            child: Text("Submit Audit",
                                style: ColorDefs.textBodyBlack20),
                            onPressed: (() async {
                              // this is done to prevent "Verification" from showing as selected when opening again.
                              for (var i = activeAudit.sections.length - 1;
                                  i > -1;
                                  i--) {
                                if (activeAudit.sections[i].name ==
                                    "Verification") {
                                  activeAudit.sections[i].status =
                                      Status.completed;
                                  break;
                                }
                              }
                              // Save citations, and update status
                              activeAudit.citations =
                                  Provider.of<AuditData>(context, listen: false)
                                      .citations;
                              activeAudit.previousCitations =
                                  Provider.of<AuditData>(context, listen: false)
                                      .citations;
                              String status = "Completed";
                              if (activeAudit.siteVisitRequired == true) {
                                status = "Site Visit Req.";
                              }

                              activeAudit.calendarResult.status = status;
                              Provider.of<AuditData>(context, listen: false)
                                  .saveAuditLocally(activeAudit);
                              // the calendar item needs to be updated due to the status change.
                              Provider.of<ListCalendarData>(context,
                                      listen: false)
                                  .addCalendarItem(activeAudit.calendarResult);
                              Provider.of<AuditData>(context, listen: false)
                                  .notifyTheListeners();
                              Provider.of<AuditData>(context, listen: false)
                                  .saveAuditToSend(activeAudit);

                              await Dialogs.showSuccess(context);
                              Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                              Provider.of<AuditData>(context, listen: false)
                                  .resetAudit();
                            })),
                    if (activeAudit?.calendarResult?.status == 0)
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        child: Text("Cancel Audit",
                            style: ColorDefs.textBodyBlack20),
                        onPressed: () {
                          Provider.of<AuditData>(context, listen: false)
                              .toggleStartAudit();
                          Provider.of<AuditData>(context, listen: false)
                              .resetAudit();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.black,
                      child: Text("Close and Save Audit",
                          style: ColorDefs.textBodyBlack20),
                      onPressed: () {
                        Provider.of<AuditData>(context, listen: false)
                            .toggleStartAudit();
                        Provider.of<AuditData>(context, listen: false)
                            .resetAudit();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
