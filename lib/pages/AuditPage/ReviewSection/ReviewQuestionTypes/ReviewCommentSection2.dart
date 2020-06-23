import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

import 'commonQuestionMethods.dart';

class ReviewCommentSection2 extends StatefulWidget {
  final int index;
  final List<Question> questions;
  final bool mandatory;
  final bool numKeyboard;
  final bool actionItem;
  ReviewCommentSection2(
      {Key key,
      @required this.index,
      @required this.questions,
      @required this.mandatory,
      @required this.numKeyboard,
      @required this.actionItem})
      : super(key: key);

  @override
  _ReviewCommentSection2State createState() => _ReviewCommentSection2State();
}

class _ReviewCommentSection2State extends State<ReviewCommentSection2> {
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
      height: 80, //widget.questions[index].textBoxRollOut ? 80 : 0,
      color: ColorDefs.colorAudit4,
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
        style: ColorDefs.textBodyBlack20,
        //widget.questions[index].textBoxRollOut
        // ? ColorDefs.textBodyBlack20
        // : ColorDefs.textTransparent,
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
