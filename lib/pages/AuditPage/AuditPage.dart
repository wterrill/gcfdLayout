import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/CalendarResult.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<AuditData>(context, listen: false).loadExisting();
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
                    if (activeSection.name != "Review" &&
                        activeSection.name != "Verification")
                      Container(
                        child: AuditQuestions(activeSection: activeSection),
                      ),
                    if (activeSection.name == "Confirm Details")
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        child:
                            Text("Confirm", style: ColorDefs.textBodyBlack20),
                        onPressed: () {
                          for (Section section in activeAudit.sections) {
                            section.status = Status.available;
                            activeSection.status = Status.completed;
                            setState(() {});
                          }
                        },
                      ),
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
