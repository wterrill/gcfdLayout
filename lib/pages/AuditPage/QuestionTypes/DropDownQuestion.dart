import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CommentSection.dart';
import 'commonQuestionMethods.dart';

class DropDownQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  DropDownQuestion(
      {Key key, this.index, this.activeSection, this.questionAutoGroup})
      : super(key: key);
  @override
  _DropDownQuestionState createState() => _DropDownQuestionState();
}

class _DropDownQuestionState extends State<DropDownQuestion> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    Section activeSection = widget.activeSection;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AutoSizeText(widget.activeSection.questions[index].text,
                  maxLines: 3,
                  group: widget.questionAutoGroup,
                  style: ColorDefs.textBodyBlack20),
            ),
            DropdownButton<String>(
              value: widget.activeSection.questions[index].userResponse
                      as String ??
                  "Select",
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: ColorDefs.textBodyBlack20,
              underline: Container(
                height: 2,
                color: (widget.activeSection.questions[index].userResponse ==
                        "Select")
                    ? Colors.red
                    : Colors.green,
              ),
              onChanged: (String newValue) {
                setState(() {
                  widget.activeSection.questions[index].userResponse = newValue;
                  if (newValue == "Other") {
                    widget.activeSection.questions[index].textBoxRollOut = true;
                  }
                  Provider.of<AuditData>(context, listen: false)
                      .updateSectionStatus(
                          checkSectionDone(widget.activeSection));
                  Audit thisAudit =
                      Provider.of<AuditData>(context, listen: false)
                          .activeAudit;
                  Provider.of<AuditData>(context, listen: false)
                      .saveAuditLocally(thisAudit);
                });
              },
              items: widget.activeSection.questions[index].dropDownMenu
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            GestureDetector(
              onTap: () {
                widget.activeSection.questions[index].textBoxRollOut =
                    !widget.activeSection.questions[index].textBoxRollOut;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.chat_bubble,
                    color:
                        widget.activeSection.questions[index].optionalComment ==
                                null
                            ? ColorDefs.colorChatNeutral
                            : ColorDefs.colorChatSelected),
              ),
            ),
          ],
        ),
        CommentSection(
            index: index,
            activeSection: activeSection,
            key: UniqueKey(),
            numKeyboard: false,
            mandatory: false)
      ],
    );
  }
}
