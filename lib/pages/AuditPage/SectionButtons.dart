import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:auditor/Definitions/AuditClasses/Audit.dart';
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
    Map<String, List<Map<String, dynamic>>> photoData = {
      "Photos": [
        <String, dynamic>{"beer": "women"}
      ]
    };
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
    Map<String, List<Map<String, dynamic>>> developerData = {
      "*Developer*": [
        <String, dynamic>{"beer": "women"}
      ]
    };
    Section photo = Section(section: photoData);
    Section review = Section(section: reviewData);
    Section verification = Section(section: verificationData);
    Section developer = Section(section: developerData);
    bool addThem = true;
    for (Section section in buttonSections) {
      if (section.name == 'Photos') {
        addThem = false;
      }
    }
    if (addThem) {
      buttonSections.add(photo);
      buttonSections.add(review);
      buttonSections.add(verification);
      buttonSections.add(developer);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building SectionButtons");
    AutoSizeGroup buttonAutoGroup = AutoSizeGroup();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                LimitedBox(
                  maxHeight: 80,
                  child: Image(
                    image: AssetImage('assets/images/GCFD_Logo_vertical.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  child: Text(
                    widget.activeAudit.name,
                    style: ColorDefs.textBodyBlack30,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            child: ListView.separated(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  Container(width: 5, color: Colors.transparent),
              itemCount: widget.activeAudit.sections.length,
              itemBuilder: (context, index) {
                SectionButton sectionButton = SectionButton(
                    section: widget.activeAudit.sections[index],
                    buttonAutoGroup: buttonAutoGroup);
                if (index == 0)
                  return Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: sectionButton);
                if (index == widget.activeAudit.sections.length - 1)
                  return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: sectionButton);
                return sectionButton;
              },
            ),
          ),
        ],
      ),
    );
  }
}
