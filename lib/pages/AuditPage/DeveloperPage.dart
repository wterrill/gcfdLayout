import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeveloperPage extends StatelessWidget {
  final Audit activeAudit;
  const DeveloperPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void fillOutAngryAudit() {
      print("filled");
      Audit activeAudit =
          Provider.of<AuditData>(context, listen: false).activeAudit;
      Provider.of<AuditData>(context, listen: false).citations = [];
      for (Section section in activeAudit.sections) {
        section.status = Status.completed;
        section.lastStatus = Status.completed;
        if (!(section.name == "Photos" ||
            section.name == "Review" ||
            section.name == "Verification" ||
            section.name == "*Developer*")) {
          for (Question question in section.questions) {
            if (question.text.contains("Findings Found:")) {
              print("this one");
            }
            switch (question.typeOfQuestion) {
              case ("display"):
                print("display");
                break;

              case ("yesNo"):
                print("yesNo");
                try {
                  String answer =
                      question.happyPathResponse.contains("No") ? "Yes" : "No";
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = "Yes";
                }
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("issuesNoIssues"):
                print("issuesNoIssues");
                try {
                  String answer =
                      question.happyPathResponse.contains("No Issues")
                          ? "Issues"
                          : "No Issues";
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = "No Issues";
                }
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("fillIn"):
                print("fillIn");
                if (!question.text
                    .contains("If yes, how many and from where")) {
                  question.userResponse = question.text +
                      " This, right here, is a mandatory comment";
                } else {
                  question.userResponse = "Illinois and Wisconsin";
                }

                break;

              case ("fillInNum"):
                print("fillInNum");
                question.userResponse = 12;
                break;

              case ("dropDown"):
                print("dropDown");

                try {
                  String answer = question.dropDownMenu[1];
                  for (String item in question.dropDownMenu) {
                    if (item != "Select") {
                      if (!question.happyPathResponse.contains(item)) {
                        answer = item;
                      }
                    }
                  }
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = question.dropDownMenu[1];
                }
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("yesNoNa"):
                print("yesNoNa");
                try {
                  String answer =
                      question.happyPathResponse.contains("No") ? "Yes" : "No";
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = "NA";
                }

                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("date"):
                print("date");
                print(question.userResponse);
                print(DateTime.now().toString());
                question.userResponse = DateTime.now().toString();
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;
            }
          }
        }
      }
      Provider.of<AuditData>(context, listen: false).notifyTheListeners();
    }

    void fillOutHappyAudit() {
      print("filled");
      Audit activeAudit =
          Provider.of<AuditData>(context, listen: false).activeAudit;
      Provider.of<AuditData>(context, listen: false).citations = [];
      for (Section section in activeAudit.sections) {
        section.status = Status.completed;
        section.lastStatus = Status.completed;
        if (!(section.name == "Photos" ||
            section.name == "Review" ||
            section.name == "Verification" ||
            section.name == "*Developer*")) {
          for (Question question in section.questions) {
            if (question.text.contains("Findings Found:")) {
              print("this one");
            }
            switch (question.typeOfQuestion) {
              case ("display"):
                print("display");
                break;

              case ("yesNo"):
                print("yesNo");
                try {
                  question.userResponse = question.happyPathResponse[0];
                } catch (err) {
                  question.userResponse = "No";
                }
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("issuesNoIssues"):
                print("issuesNoIssues");
                try {
                  question.userResponse = question.happyPathResponse[0];
                } catch (err) {
                  question.userResponse = "No Issues";
                }
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("fillIn"):
                print("fillIn");
                if (!question.text
                    .contains("If yes, how many and from where")) {
                  question.userResponse = question.text +
                      " This, right here, is a mandatory comment";
                } else {
                  question.userResponse = "Illinois and Wisconsin";
                }

                break;

              case ("fillInNum"):
                print("fillInNum");
                question.userResponse = 1;
                break;

              case ("dropDown"):
                print("dropDown");
                String first = question.dropDownMenu[1];
                try {
                  if (question.happyPathResponse.contains(first)) {
                    question.userResponse = question.dropDownMenu[1];
                  } else {
                    print("problem");
                  }
                } catch (err) {
                  question.userResponse = question.dropDownMenu[1];
                }
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("yesNoNa"):
                print("yesNoNa");
                try {
                  question.userResponse = question?.happyPathResponse[0];
                } catch (err) {
                  question.userResponse = "NA";
                }

                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;

              case ("date"):
                print("date");
                print(question.userResponse);
                print(DateTime.now().toString());
                question.userResponse = DateTime.now().toString();
                question.optionalComment =
                    question.text + " This, right here, is an optional comment";
                break;
            }
          }
        }
      }
      Provider.of<AuditData>(context, listen: false).notifyTheListeners();
    }

    return Column(
      children: [
        Text(
          "Developer Page",
        ),
        RaisedButton(
            onPressed: () {
              fillOutHappyAudit();
              Provider.of<AuditData>(context, listen: false)
                  .saveAuditLocally(activeAudit);
            },
            child: Text("Fill out Audit -> Happy Path")),
        RaisedButton(
            onPressed: () {
              fillOutAngryAudit();
              Provider.of<AuditData>(context, listen: false)
                  .saveAuditLocally(activeAudit);
            },
            child: Text("Fill out Audit -> Angry Path"))
      ],
    );
  }
}
