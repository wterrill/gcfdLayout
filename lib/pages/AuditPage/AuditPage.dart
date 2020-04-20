import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:auditor/definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AuditButtons.dart';
import 'AuditQuestions.dart';

class AuditPage extends StatefulWidget {
  AuditPage({Key key}) : super(key: key);
  @override
  _AuditPageState createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  @override
  Widget build(BuildContext context) {
    Audit activeAudit = Provider.of<AuditData>(context).activeAudit;
    Section activeSection = Provider.of<AuditData>(context).activeSection;
    bool startAudit = Provider.of<AuditData>(context).auditStarted;
    double mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    double mediaHeight = Provider.of<LayoutData>(context).mediaArea.height;
    return IgnorePointer(
      ignoring: !startAudit,
      child: AnimatedOpacity(
        curve: Curves.ease,
        opacity: startAudit ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: Center(
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
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.black,
                      // color: ColorDefs.colorTopDrawerAlternating,
                      child: Text("Cancel Audit",
                          style: ColorDefs.textBodyBlack20),
                      onPressed: () {
                        Provider.of<AuditData>(context, listen: false)
                            .toggleStartAudit();
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
