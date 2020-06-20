import 'package:auditor/Definitions/AuditClasses/Audit.dart';
// import 'package:auditor/Definitions/AuditClasses/Question.dart';
// import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/pages/AuditPage/ReviewSection/ExpandableReview.dart';
import 'package:auditor/pages/AuditPage/ReviewSection/FollowupCitationsSections.dart';
// import 'package:auditor/pages/AuditPage/ReviewSection/ReviewQuestionTypes/ReviewCommentSection.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class ReviewPage extends StatelessWidget {
  final Audit activeAudit;
  const ReviewPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 500,
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
            )

            // Text("Review Page"),
            ),
        Text(
          "Follow-Up / Citations",
          style: ColorDefs.textBodyBlack30,
        ),
        Container(
            height: 700,
            child: FollowupCitationsSections(
              activeAudit: activeAudit,
            ))
      ],
    );
  }
}
