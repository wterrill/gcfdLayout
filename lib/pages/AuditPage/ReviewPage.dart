import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatelessWidget {
  final Audit activeAudit;
  const ReviewPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700,
        child: ListView.builder(
          itemCount: activeAudit.sections.length - 3,
          itemBuilder: (context, i) {
            return new ExpansionTile(
              title: new Text(
                activeAudit.sections[i + 1].name,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              children: <Widget>[
                ExpandableContent(sectionData: activeAudit.sections[i + 1]),
              ],
            );
          },
        )

        // Text("Review Page"),
        );
  }
}

class ExpandableContent extends StatelessWidget {
  const ExpandableContent({Key key, this.sectionData}) : super(key: key);
  final Section sectionData;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnContent = [];
    for (Question question in sectionData.questions) {
      String dateString;
      if (question.typeOfQuestion.toLowerCase() == "date") {
        DateTime dateTime = question.userResponse as DateTime;

        dateString = DateFormat('EEE, MMM-dd-yyyy').format(dateTime);
      }
      columnContent.add(
        ListTile(
          dense: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    question.text,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              if (question.userResponse != null &&
                  question.typeOfQuestion.toLowerCase() != "date")
                Text(question.userResponse as String),
              if (question.optionalComment != null)
                Text(question.optionalComment),
              if (question.typeOfQuestion.toLowerCase() == "date")
                Text(dateString)
            ],
          ),
          // leading: new Text(question.userResponse),
        ),
      );
    }
    return Column(
      children: [...columnContent],
    );
  }
}
