import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AuditButtons.dart';
import 'AuditQuestions.dart';

class AuditPage extends StatefulWidget {
  final String programType;
  AuditPage({Key key, this.programType}) : super(key: key);
  @override
  _AuditPageState createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuditData>(context, listen: false)
        .createNewAudit(widget.programType);
  }

  // bool auditBuilt = false;
  @override
  Widget build(BuildContext context) {
    print("building AuditPage");

    Audit activeAudit = Provider.of<AuditData>(context).activeAudit;
    Section activeSection = Provider.of<AuditData>(context).activeSection;
    // bool startAudit = Provider.of<AuditData>(context).auditStarted;
    double mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    double mediaHeight = Provider.of<LayoutData>(context).mediaArea.height;
    bool auditBuilt = true;
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
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
                    Container(child: AuditButtons(activeAudit: activeAudit)),
                    Container(
                      child: AuditQuestions(activeSection: activeSection),
                    ),
                    if (activeSection.name == "Confirm Details")
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        // color: ColorDefs.colorTopDrawerAlternating,
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
                      // color: ColorDefs.colorTopDrawerAlternating,
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
