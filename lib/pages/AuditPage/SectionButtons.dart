import 'package:auditor/AuditClasses/Section.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:auditor/AuditClasses/Audit.dart';
// import 'package:auditor/AuditClasses/Section.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/providers/AuditData.dart';

import 'SectionButton.dart';

class SectionButtons extends StatefulWidget {
  SectionButtons({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _SectionButtonsState createState() => _SectionButtonsState();
}

class _SectionButtonsState extends State<SectionButtons> {
  @override
  void initState() {
    super.initState();
    List<Section> buttonSections = widget.activeAudit.sections;
    Map<String, List<Map<String, dynamic>>> reviewData = {
      "Review": [
        <String, dynamic>{"beer": "women"}
      ]
    };
    Map<String, List<Map<String, dynamic>>> verificationData = {
      "Verification": [
        <String, dynamic>{"beer": "women"}
      ]
    };
    Section review = Section(section: reviewData);
    Section verification = Section(section: verificationData);
    buttonSections.add(review);
    buttonSections.add(verification);
  }

  @override
  Widget build(BuildContext context) {
    print("building SectionButtons");
    AutoSizeGroup buttonAutoGroup = AutoSizeGroup();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
      child: Container(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          separatorBuilder: (context, index) =>
              Container(width: 5, color: Colors.transparent),
          itemCount: widget.activeAudit.sections.length,
          itemBuilder: (context, index) {
            return SectionButton(
                section: widget.activeAudit.sections[index],
                buttonAutoGroup: buttonAutoGroup);
          },
        ),
      ),
    );
  }
}