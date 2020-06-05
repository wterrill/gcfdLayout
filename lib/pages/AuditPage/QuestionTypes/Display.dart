import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  Display({
    Key key,
    this.index,
    this.activeSection,
    this.questionAutoGroup,
  }) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
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
          ],
        ),
      ],
    );
  }
}
