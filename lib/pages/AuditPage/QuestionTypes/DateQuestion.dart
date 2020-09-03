import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'CommentSection.dart';
import 'commonQuestionMethods.dart';

class DateQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  final Audit activeAudit;
  DateQuestion({Key key, this.index, this.activeSection, this.questionAutoGroup, @required this.activeAudit})
      : super(key: key);

  @override
  _DateQuestionState createState() => _DateQuestionState();
}

class _DateQuestionState extends State<DateQuestion> {
  bool myBubbleOn = false;
  DateTime selectedDate;
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
              (widget.activeSection.questions[index].userResponse != null)
                  ? Text(
                      DateFormat.yMMMMd('en_US')
                          .format(DateTime.parse(widget.activeSection.questions[index].userResponse as String))
                          .toString(),
                    )
                  : Text(""),
              FlatButton(
                  onPressed: () async {
                    if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status !=
                        "Scheduled") {
                      Dialogs.showMessage(
                          context: context,
                          message: "This audit has already been submitted, and cannot be edited",
                          dismissable: true);
                    } else {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: (selectedDate != null) ? selectedDate : DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        widget.activeSection.questions[index].userResponse = selectedDate.toString();
                        Provider.of<AuditData>(context, listen: false)
                            .updateSectionStatus(checkSectionDone(widget.activeSection));
                        Provider.of<AuditData>(context, listen: false)
                            .tallySingleQuestion(index: index, section: activeSection, audit: widget.activeAudit);
                        Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
                        Provider.of<AuditData>(context, listen: false).saveAuditLocally(thisAudit);
                        setState(() {});
                      }
                    }
                  },
                  child: Icon(Icons.calendar_today,
                      color: (widget.activeSection.questions[index].userResponse == null) ? Colors.red : Colors.green)),
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
                ),
              ),
            ],
          ),
          CommentSection(
            index: index,
            activeSection: activeSection,
            // key: UniqueKey(),
            numKeyboard: false,
            mandatory: false,
            bubbleCallback: (String val) {
              setState(() {
                if (val.length > 0) {
                  myBubbleOn = true;
                } else {
                  myBubbleOn = false;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
