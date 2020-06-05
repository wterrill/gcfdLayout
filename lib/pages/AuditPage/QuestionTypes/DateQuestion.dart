import 'package:auditor/AuditClasses/Section.dart';
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
  DateQuestion(
      {Key key, this.index, this.activeSection, this.questionAutoGroup})
      : super(key: key);

  @override
  _DateQuestionState createState() => _DateQuestionState();
}

class _DateQuestionState extends State<DateQuestion> {
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
            (widget.activeSection.questions[index].userResponse != null)
                ? Text(
                    DateFormat.yMMMMd('en_US')
                        .format(widget.activeSection.questions[index]
                            .userResponse as DateTime)
                        .toString(),
                  )
                : Text(""),
            FlatButton(
                onPressed: () async {
                  DateTime selectedDate;
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2030),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    },
                  );
                  widget.activeSection.questions[index].userResponse =
                      selectedDate;
                  Provider.of<AuditData>(context, listen: false)
                      .updateSectionStatus(
                          checkSectionDone(widget.activeSection));
                },
                child: Icon(Icons.calendar_today,
                    color:
                        (widget.activeSection.questions[index].userResponse ==
                                null)
                            ? Colors.red
                            : Colors.green)),
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
            index: index, activeSection: activeSection, key: UniqueKey())
      ],
    );
  }
}
