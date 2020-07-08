import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FollowUpCommentSection.dart';
import 'commonQuestionMethods.dart';

class FollowUpDropDownQuestion extends StatefulWidget {
  final int index;
  final List<Question> citations;
  final AutoSizeGroup questionAutoGroup;
  FollowUpDropDownQuestion(
      {Key key, this.index, this.citations, this.questionAutoGroup})
      : super(key: key);
  @override
  _FollowUpDropDownQuestionState createState() =>
      _FollowUpDropDownQuestionState();
}

class _FollowUpDropDownQuestionState extends State<FollowUpDropDownQuestion> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    // Section activeSection = widget.activeSection;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AutoSizeText(widget.citations[index].text,
                  maxLines: 3,
                  group: widget.questionAutoGroup,
                  style: ColorDefs.textBodyBlack20),
            ),
            DropdownButton<String>(
              value: widget.citations[index].userResponse as String ?? "Select",
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: ColorDefs.textBodyBlack20,
              underline: Container(
                height: 2,
                color: (widget.citations[index].userResponse == "Select")
                    ? Colors.red
                    : Colors.green,
              ),
              onChanged: (String newValue) {
                if (Provider.of<AuditData>(context, listen: false)
                        .activeAudit
                        .calendarResult
                        .status !=
                    "Scheduled") {
                  Dialogs.showMessage(
                      context: context,
                      message:
                          "This audit has already been submitted, and cannot be edited",
                      dismissable: true);
                } else {
                  setState(() {
                    widget.citations[index].userResponse = newValue;
                    if (newValue == "Other") {
                      widget.citations[index].textBoxRollOut = true;
                    }
                    // Provider.of<AuditData>(context, listen: false)
                    //     .updateSectionStatus(
                    //         checkSectionDone(widget.activeSection));
                    // Audit thisAudit =
                    //     Provider.of<AuditData>(context, listen: false)
                    //         .activeAudit;
                    // Provider.of<AuditData>(context, listen: false)
                    //     .saveAuditLocally(thisAudit);
                  });
                }
              },
              items: widget.citations[index].dropDownMenu
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            GestureDetector(
              onTap: () {
                widget.citations[index].textBoxRollOut =
                    !widget.citations[index].textBoxRollOut;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.chat_bubble,
                    color: widget.citations[index].optionalComment == null
                        ? ColorDefs.colorChatNeutral
                        : ColorDefs.colorChatSelected),
              ),
            ),
          ],
        ),
        FollowUpCommentSection(
            index: index,
            citations: widget.citations,
            key: UniqueKey(),
            numKeyboard: false,
            mandatory: false)
      ],
    );
  }
}
