import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';

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
        height: 72,
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
            }));
  }
}

class SectionButton extends StatefulWidget {
  final Section section;
  final AutoSizeGroup buttonAutoGroup;

  SectionButton({
    Key key,
    this.section,
    this.buttonAutoGroup,
  }) : super(key: key);

  @override
  _SectionButtonState createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  @override
  Widget build(BuildContext context) {
    Status status = widget.section.status;
    Widget icon;
    switch (status) {
      case Status.disabled:
        icon = Icon(
          Icons.lock,
          color: ColorDefs.colorAlternateDark,
        );
        break;

      case Status.available:
        icon = Icon(
          Icons.slideshow,
          color: ColorDefs.colorChatSelected,
        );
        break;

      case Status.selected:
        icon = Icon(
          Icons.adjust,
          color: ColorDefs.colorAudit2,
        );
        break;

      case Status.inProgress:
        icon = Icon(
          Icons.watch_later,
          color: ColorDefs.colorAudit4,
        );
        break;

      case Status.completed:
        icon = Icon(
          Icons.check_circle,
          color: ColorDefs.colorButtonYes,
        );
        break;
      default:
        icon = Icon(
          Icons.slideshow,
          color: ColorDefs.colorChatSelected,
        );
    }

    return Column(
      children: [
        Container(
          width: 110,
          child: FlatButton(
            color: Colors.blue,
            onPressed: () {
              print(widget.section.name);
              Provider.of<AuditData>(context, listen: false)
                  .updateActiveSection(widget.section);
            },
            child: AutoSizeText(
              widget.section.name,
              group: widget.buttonAutoGroup,
              maxLines: 2,
              minFontSize: 5,
              style: ColorDefs.textBodyBlack20,
              wrapWords: false,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        icon
      ],
    );
  }
}
