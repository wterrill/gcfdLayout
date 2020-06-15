import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'CommentSection.dart';

class FillInQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  FillInQuestion(
      {Key key, this.index, this.activeSection, this.questionAutoGroup})
      : super(key: key);

  @override
  _FillInQuestionState createState() => _FillInQuestionState();
}

class _FillInQuestionState extends State<FillInQuestion> {
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
                widget.activeSection.questions[index].textBoxRollOut =
                    !widget.activeSection.questions[index].textBoxRollOut;
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
            numKeyboard: false,
            key: UniqueKey())
      ],
    );
  }
}
