import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
// import 'package:auditor/Definitions/AuditClasses/Question.dart';
// import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

import 'ExpandableReview.dart';
import 'FollowupCitationsSections.dart';
// import 'ReviewQuestionTypes/FillInQuestion.dart';
// import 'ReviewQuestionTypes/ReviewCommentSection.dart';
// import 'ReviewQuestionTypes/YesNoQuestion.dart';

class ReviewPage extends StatelessWidget {
  final Audit activeAudit;
  const ReviewPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Question> citations = Provider.of<AuditData>(context).citations;
    return Expanded(
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: activeAudit.sections.length - 4,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                        color: ColorDefs.colorAlternateLight,
                        border: Border.all(
                            color: ColorDefs.colorAlternateDark, width: 3)),
                    child: ExpansionTile(
                      trailing: Icon(Icons.arrow_drop_down),
                      backgroundColor: ColorDefs.colorChatSelected,
                      title: Text(activeAudit.sections[i + 1].name,
                          style: ColorDefs.textBodyBlack20),
                      children: <Widget>[
                        ExpandableReviewContent(
                            sectionData: activeAudit.sections[i + 1]),
                      ],
                    ),
                  );
                },
              )),

          // if (activeAudit.citations.length != 0)
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FollowupCitationsSections(
                  // activeAudit: activeAudit,
                  )),
          Container(height: 100),
          // Container(
          //   height: 800,
          // )
        ],
      ),
    );
  }
}
