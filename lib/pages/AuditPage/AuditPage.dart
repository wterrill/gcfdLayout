import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DeveloperPage.dart';
import 'ReviewPage.dart';
import 'SectionButtons.dart';
import 'AuditQuestions.dart';
import 'VerificationPage.dart';

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
  @override
  void initState() {
    super.initState();
    if (widget.alreadyExist) {
      Provider.of<AuditData>(context, listen: false)
          .loadExisting(widget.calendarResult);
    } else {
      Provider.of<AuditData>(context, listen: false)
          .createNewAudit(widget.calendarResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building AuditPage");

    Audit activeAudit = Provider.of<AuditData>(context).activeAudit;
    Section activeSection = Provider.of<AuditData>(context).activeSection;
    double mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    double mediaHeight = Provider.of<LayoutData>(context).mediaArea.height;
    CalendarResult activeCalendarResult =
        Provider.of<AuditData>(context).activeCalendarResult;
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
                  children: <Widget>[
                    Container(child: SectionButtons(activeAudit: activeAudit)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: ColorDefs.colorAlternatingDark,
                        thickness: 1,
                      ),
                    ),
                    if (activeSection.name == "Review")
                      ReviewPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection.name == "Verification")
                      VerificationPage(),
                    if (activeSection.name == "*Developer*") DeveloperPage(),
                    if (activeSection.name != "Review" &&
                        activeSection.name != "Verification")
                      Container(
                        child: AuditQuestions(
                            activeSection: activeSection,
                            activecalendarResult: activeCalendarResult),
                      ),
                    if (activeSection.name == "Confirm Details")
                      RaisedButton(
                        disabledColor: ColorDefs.colorButtonNeutral,
                        color: Colors.blue,
                        textColor: Colors.black,
                        child:
                            Text("Confirm", style: ColorDefs.textBodyBlack20),
                        onPressed: (activeSection.status != Status.completed)
                            ? null
                            : () {
                                for (Section section in activeAudit.sections) {
                                  section.status = Status.available;
                                  activeSection.status = Status.completed;
                                  setState(() {});
                                }
                              },
                      ),
                    if (activeSection.name == "Review")
                      RaisedButton(
                          disabledColor: ColorDefs.colorButtonNeutral,
                          color: Colors.blue,
                          textColor: Colors.black,
                          child:
                              Text("Submit", style: ColorDefs.textBodyBlack20),
                          onPressed: (
                              // activeSection.status != Status.completed)
                              //   ? null
                              //   :
                              () {
                            Map<String, dynamic> resultMap =
                                <String, dynamic>{};
                            for (Section section in activeAudit.sections) {
                              for (Question question in section.questions) {
                                String name = question
                                    .questionMap['databaseVar'] as String;
                                if (name != null) {
                                  print("beer");
                                }
                                String qtype = question
                                    .questionMap['databaseVarType'] as String;
                                String comment = question
                                    .questionMap['databaseOptCom'] as String;

                                if (qtype == "bool") {
                                  if (question.userResponse == "Yes") {
                                    resultMap[name] = 1;
                                  } else if (question.userResponse == "No") {
                                    resultMap[name] = 0;
                                  } else {
                                    resultMap[name] = null;
                                  }
                                  try {
                                    resultMap[comment] =
                                        question.optionalComment;
                                  } catch (err) {
                                    print(err);
                                    print("moving on");
                                  }
                                }

                                if (qtype == "string") {
                                  resultMap[name] = question.userResponse;
                                  try {
                                    resultMap[comment] =
                                        question.optionalComment;
                                  } catch (err) {
                                    print(err);
                                    print("moving on");
                                  }
                                }

                                if (qtype == "date") {
                                  resultMap[name] = question.userResponse;

                                  try {
                                    resultMap[comment] =
                                        question.optionalComment;
                                  } catch (err) {
                                    print(err);
                                    print("moving on");
                                  }
                                }
                              }
                            }
                            print(resultMap);
                          })),
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.black,
                      child: Text("Cancel Audit",
                          style: ColorDefs.textBodyBlack20),
                      onPressed: () {
                        Provider.of<AuditData>(context, listen: false)
                            .toggleStartAudit();
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
