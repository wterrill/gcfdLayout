import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuditButtons extends StatefulWidget {
  AuditButtons({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _AuditButtonsState createState() => _AuditButtonsState();
}

class _AuditButtonsState extends State<AuditButtons> {
  @override
  Widget build(BuildContext context) {
    print("building auditButtons");
    AutoSizeGroup buttonAutoGroup = AutoSizeGroup();
    return Container(
        height: 50,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                Container(width: 5, color: Colors.transparent),
            itemCount: widget.activeAudit.sections.length,
            itemBuilder: (context, index) {
              return makeButton(
                  widget.activeAudit.sections[index], buttonAutoGroup);
            }));
  }

  Widget makeButton(Section section, AutoSizeGroup buttonAutoGroup) {
    Widget button = Container(
      width: 110,
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          print(section.name);
          Provider.of<AuditData>(context, listen: false)
              .updateActiveSection(section);
        },
        child: AutoSizeText(
          section.name,
          group: buttonAutoGroup,
          maxLines: 2,
          minFontSize: 5,
          style: ColorDefs.textBodyBlack20,
          wrapWords: false,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
    return button;
  }
}
