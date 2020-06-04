import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CommentSection.dart';
import 'commonQuestionMethods.dart';

class YesNoNaQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  YesNoNaQuestion(
      {Key key, this.index, this.activeSection, this.questionAutoGroup})
      : super(key: key);

  @override
  _YesNoNaQuestionState createState() => _YesNoNaQuestionState();
}

class _YesNoNaQuestionState extends State<YesNoNaQuestion> {
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
            FlatButton(
              color: Colors.blue,
              child: Text("YES"),
              onPressed: () {
                Provider.of<AuditData>(context, listen: false)
                    .updateSectionStatus(
                        checkSectionDone(widget.activeSection));
                setState(() {});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("NO"),
              onPressed: () {
                Provider.of<AuditData>(context, listen: false)
                    .updateSectionStatus(
                        checkSectionDone(widget.activeSection));
                setState(() {});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("N/A"),
              onPressed: () {
                Provider.of<AuditData>(context, listen: false)
                    .updateSectionStatus(
                        checkSectionDone(widget.activeSection));
                setState(() {});
              },
            ),
          ],
        ),
        CommentSection(index: index, activeSection: activeSection)
      ],
    );
  }
}
