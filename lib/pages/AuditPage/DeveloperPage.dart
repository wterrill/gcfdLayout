import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DeveloperPage extends StatelessWidget {
  final Audit activeAudit;
  const DeveloperPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fillOutAudit() {
      print("filled");
      Audit activeAudit =
          Provider.of<AuditData>(context, listen: false).activeAudit;
      for (Section section in activeAudit.sections) {
        if (!(section.name == "Review" ||
            section.name == "Verification" ||
            section.name == "*Developer*")) {
          for (Question question in section.questions) {
            switch (question.typeOfQuestion) {
              case ("display"):
                break;

              case ("yesNo"):
                question.userResponse = "Yes";
                question.optionalComment =
                    "This, right here, is an optional comment";
                break;

              case ("fillIn"):
                question.userResponse =
                    "This, right here, is a mandatory comment";
                break;

              case ("fillInNum"):
                // question.userResponse = 1;
                break;

              case ("dropDown"):
                question.userResponse = question.dropDownMenu[1];
                question.optionalComment =
                    "This, right here, is an optional comment";
                break;

              case ("yesNoNa"):
                question.userResponse = "Yes";
                question.optionalComment =
                    "This, right here, is an optional comment";
                break;

              case ("date"):
                question.userResponse = DateTime.now().toString();
            }
          }
        }
      }
    }

    return Column(
      children: [
        Text(
          "Developer Page",
        ),
        RaisedButton(
            onPressed: () {
              fillOutAudit();
            },
            child: Text("Fill out Audit"))
      ],
    );
  }
}
