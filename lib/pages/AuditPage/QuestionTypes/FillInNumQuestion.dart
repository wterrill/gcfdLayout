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

class FillInNumQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  FillInNumQuestion(
      {Key key, this.index, this.activeSection, this.questionAutoGroup})
      : super(key: key);

  @override
  _FillInNumQuestionState createState() => _FillInNumQuestionState();
}

class _FillInNumQuestionState extends State<FillInNumQuestion> {
  @override
  void initState() {
    super.initState();
    widget.activeSection.questions[widget.index].textBoxRollOut = true;
  }

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
            GestureDetector(
              onTap: () {
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
                  String result = setQuestionValue(
                      widget.activeSection.questions[index].userResponse
                          as String,
                      "0");
                  widget.activeSection.questions[index].userResponse = result;
                  Provider.of<AuditData>(context, listen: false)
                      .updateSectionStatus(
                          checkSectionDone(widget.activeSection));
                  Audit thisAudit =
                      Provider.of<AuditData>(context, listen: false)
                          .activeAudit;
                  Provider.of<AuditData>(context, listen: false)
                      .saveAuditLocally(thisAudit);
                  setState(() {});
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: buttonColorPicker(
                        widget.activeSection.questions[index], 'NA'),
                    borderRadius: BorderRadius.circular(20.0),
                    // border:
                    //     Border.all(width: 2.0, color: Colors.grey)
                  ),
                  width: 80,
                  child: Center(
                      child: Text("N/A", style: ColorDefs.textBodyBlack20)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.activeSection.questions[index].textBoxRollOut =
                    !widget.activeSection.questions[index].textBoxRollOut;
                Audit thisAudit =
                    Provider.of<AuditData>(context, listen: false).activeAudit;
                Provider.of<AuditData>(context, listen: false)
                    .saveAuditLocally(thisAudit);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.chat_bubble,
                    color: widget.activeSection.questions[index].userResponse ==
                            null
                        ? ColorDefs.colorChatRequired
                        // : ColorDefs.colorChatSelected),
                        : ColorDefs.colorButtonYes),
              ),
            ),
          ],
        ),
        CommentSection(
            index: index,
            activeSection: activeSection,
            mandatory: true,
            numKeyboard: true,
            key: UniqueKey())
      ],
    );
  }
}
