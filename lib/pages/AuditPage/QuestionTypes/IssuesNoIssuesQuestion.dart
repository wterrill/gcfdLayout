import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CommentSection.dart';
import 'commonQuestionMethods.dart';

class IssuesNoIssuesQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  IssuesNoIssuesQuestion({
    Key key,
    this.index,
    this.activeSection,
    this.questionAutoGroup,
  }) : super(key: key);

  @override
  _IssuesNoIssuesQuestionState createState() => _IssuesNoIssuesQuestionState();
}

class _IssuesNoIssuesQuestionState extends State<IssuesNoIssuesQuestion> {
  bool myBubbleOn = false;
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    Section activeSection = widget.activeSection;
    return Container(
      color: widget.activeSection.questions[index].highlight ? ColorDefs.colorHighlight : Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AutoSizeText(widget.activeSection.questions[index].text,
                    maxLines: 3, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
              ),

////////
////////
              GestureDetector(
                onTap: () {
                  if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
                    Dialogs.showMessage(
                        context: context,
                        message: "This audit has already been submitted, and cannot be edited",
                        dismissable: true);
                  } else {
                    String result =
                        setQuestionValue(widget.activeSection.questions[index].userResponse as String, "No Issues");
                    widget.activeSection.questions[index].userResponse = result;
                    Provider.of<AuditData>(context, listen: false)
                        .updateSectionStatus(checkSectionDone(widget.activeSection));
                    Provider.of<AuditData>(context, listen: false).tallyScore(index);

                    Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
                    Provider.of<AuditData>(context, listen: false).saveAuditLocally(thisAudit);
                    setState(() {});
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: buttonColorPicker(widget.activeSection.questions[index], "No Issues"),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 100,
                  child: Center(child: Text("No Issues", style: ColorDefs.textBodyBlack20)),
                ),
              ),

////////
////////
              GestureDetector(
                onTap: () {
                  if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
                    Dialogs.showMessage(
                        context: context,
                        message: "This audit has already been submitted, and cannot be edited",
                        dismissable: true);
                  } else {
                    String result =
                        setQuestionValue(widget.activeSection.questions[index].userResponse as String, "Issues");
                    widget.activeSection.questions[index].userResponse = result;
                    Provider.of<AuditData>(context, listen: false)
                        .updateSectionStatus(checkSectionDone(widget.activeSection));
                    Provider.of<AuditData>(context, listen: false).tallyScore(index);
                    Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
                    Provider.of<AuditData>(context, listen: false).saveAuditLocally(thisAudit);
                    setState(() {});
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: buttonColorPicker(widget.activeSection.questions[index], "Issues"),
                    borderRadius: BorderRadius.circular(20.0),
                    // border:
                    //     Border.all(width: 2.0, color: Colors.grey)
                  ),
                  width: 80,
                  child: Center(child: Text("Issues", style: ColorDefs.textBodyBlack20)),
                ),
              ),
////////
////////
              GestureDetector(
                onTap: () {
                  widget.activeSection.questions[index].textBoxRollOut =
                      !widget.activeSection.questions[index].textBoxRollOut;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(Icons.chat_bubble,
                      color: myBubbleOn ? ColorDefs.colorChatSelected : ColorDefs.colorChatNeutral),
                  // Icon(Icons.chat_bubble,
                  //     color: widget.activeSection.questions[index].optionalComment == null
                  //         ? ColorDefs.colorChatNeutral
                  //         : ColorDefs.colorChatSelected),
                ),
              ),
            ],
          ),
          CommentSection(
              index: index,
              activeSection: activeSection,
              bubbleCallback: (String val) {
                setState(() {
                  if (val.length > 0) {
                    myBubbleOn = true;
                  } else {
                    myBubbleOn = false;
                  }
                });
              },
              numKeyboard: false,
              mandatory: false)
        ],
      ),
    );
  }
}
