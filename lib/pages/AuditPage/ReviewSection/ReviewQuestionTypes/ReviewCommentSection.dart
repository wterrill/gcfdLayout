import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/colorDefs.dart';

class ReviewCommentSection extends StatefulWidget {
  final int index;
  final List<Question> questions;
  final bool mandatory;
  final bool numKeyboard;
  final bool actionItem;
  ReviewCommentSection(
      {Key key,
      @required this.index,
      @required this.questions,
      @required this.mandatory,
      @required this.numKeyboard,
      @required this.actionItem})
      : super(key: key);

  @override
  _ReviewCommentSectionState createState() => _ReviewCommentSectionState();
}

class _ReviewCommentSectionState extends State<ReviewCommentSection> {
  @override
  void initState() {
    super.initState();

    String text;

    if (widget.mandatory) {
      text = widget.questions[widget.index].userResponse?.toString();
    } else {
      if (widget.actionItem == true) {
        text = widget.questions[widget.index].actionItemComment;
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
      height: widget.questions[index].textBoxRollOut ? 80 : 0,
      color: Colors.white,
      duration: Duration(milliseconds: 150),
      child: TextField(
        keyboardType:
            widget.numKeyboard ? TextInputType.number : TextInputType.text,
        controller: controller,
        onChanged: (value) {
          // if (widget.mandatory) {
          //   if (widget.numKeyboard) {
          //     try {
          //       widget.questions[index].userResponse =
          //           int.parse(value);
          //     } catch (error) {
          //       Dialogs.failedAuthentication(context);
          //     }
          //   } else {
          //     widget.questions[index].userResponse = value;
          //   }
          //   // Status sectionStatus = checkSectionDone(activeSection);
          //   // Provider.of<AuditData>(context, listen: false)
          //   //     .updateSectionStatus(sectionStatus);
          // } else {
          widget.questions[index].actionItemComment = value;
          // }

          // Audit thisAudit =
          //     Provider.of<AuditData>(context, listen: false).activeAudit;
          // Provider.of<AuditData>(context, listen: false).saveAudit(thisAudit);
        },
        maxLines: null,
        style: widget.questions[index].textBoxRollOut
            ? ColorDefs.textBodyBlack20
            : ColorDefs.textTransparent,
        decoration: new InputDecoration(
            suffixIcon: IconButton(
              onPressed: () => controller.clear(),
              icon: Icon(Icons.clear),
            ),
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
