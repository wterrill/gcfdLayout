import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';

import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

import 'commonQuestionMethods.dart';

class CommentSection extends StatefulWidget {
  final int index;
  final Section activeSection;
  final bool mandatory;
  CommentSection({
    Key key,
    this.index,
    this.activeSection,
    this.mandatory,
  }) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    Section activeSection = widget.activeSection;
    return AnimatedContainer(
      height: widget.activeSection.questions[index].textBoxRollOut ? 100 : 0,
      color: Colors.white,
      duration: Duration(milliseconds: 300),
      child: TextField(
        onChanged: (value) {
          widget.activeSection.questions[index].optionalComment = value;
          if (widget.mandatory) {
            widget.activeSection.questions[index].userResponse = value;
            Status sectionStatus = checkSectionDone(activeSection);
            Provider.of<AuditData>(context, listen: false)
                .updateSectionStatus(sectionStatus);
          }

          if (value.length < 2) {
            // setState(() {});
          }
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: widget.activeSection.questions[index].textBoxRollOut
            ? ColorDefs.textBodyBlack20
            : ColorDefs.textTransparent,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: "Enter comments here"),
      ),
    );
  }
}
