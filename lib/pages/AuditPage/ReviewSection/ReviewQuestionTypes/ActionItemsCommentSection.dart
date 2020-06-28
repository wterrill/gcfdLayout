import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

class ActionItemsCommentSection extends StatefulWidget {
  final int index;
  final List<Question> questions;
  final bool mandatory;
  final bool numKeyboard;
  final bool actionItem;
  ActionItemsCommentSection(
      {Key key,
      @required this.index,
      @required this.questions,
      @required this.mandatory,
      @required this.numKeyboard,
      @required this.actionItem})
      : super(key: key);

  @override
  _ActionItemsCommentSectionState createState() =>
      _ActionItemsCommentSectionState();
}

class _ActionItemsCommentSectionState extends State<ActionItemsCommentSection> {
  @override
  void initState() {
    super.initState();

    String text;

    if (widget.mandatory) {
      text = widget.questions[widget.index].userResponse?.toString();
    } else {
      if (widget.actionItem == true) {
        if (widget.questions[widget.index].actionItem ==
            "action item does not exist for this question") {
          text = " --> " + widget.questions[widget.index].text;
        }

        text = widget.questions[widget.index].actionItem + (text ?? "");
      } else {
        text = widget.questions[widget.index].optionalComment;
      }
    }

    if (text != null) {
      controller.text = text;
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    return AnimatedContainer(
      height: widget.questions[index].unflagged ? 0 : 70,
      color: ColorDefs.colorAudit4,
      duration: Duration(milliseconds: 300),
      child: TextField(
        keyboardType:
            widget.numKeyboard ? TextInputType.number : TextInputType.text,
        controller: controller,
        onChanged: (value) {
          widget.questions[index].actionItemComment = value;
        },
        maxLines: null,
        style: ColorDefs.textBodyBlack20,
        decoration: InputDecoration(
            suffixIcon: (!widget.questions[index].unflagged)
                ? IconButton(
                    onPressed: () => controller.clear(),
                    icon: Icon(Icons.clear),
                  )
                : null,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: "Enter action item comments "),
      ),
    );
  }
}
