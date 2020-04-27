import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuditButtons extends StatefulWidget {
  AuditButtons({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _AuditButtonsState createState() => _AuditButtonsState();
}

class _AuditButtonsState extends State<AuditButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,

//       ListView.separated(
//   separatorBuilder: (context, index) => Divider(
//         color: Colors.black,
//       ),
//   itemCount: 20,
//   itemBuilder: (context, index) => Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Center(child: Text("Index $index")),
//       ),
// )

        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                Container(width: 5, color: Colors.transparent),
            itemCount: widget.activeAudit.sections.length,
            itemBuilder: (context, index) {
              return makeButton(widget.activeAudit.sections[index]);
            }));
  }

  // List<Widget> makeButtons(List<Section> sections) {
  //   List<Widget> buttons = [];
  //   for (Section section in sections) {
  //     buttons.add(

  //       Container(
  //         width: 80,
  //         child: FlatButton(
  //           color: Colors.blue,
  //           onPressed: () {
  //             print(section.name);
  //             Provider.of<AuditData>(context, listen: false)
  //                 .updateActiveSection(section);
  //           },
  //           child: AutoSizeText(
  //             section.name,
  //             maxLines: 2,
  //             minFontSize: 5,
  //             style: ColorDefs.textBodyBlack10,
  //             wrapWords: false,
  //             softWrap: true,
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return buttons;
  // }

  Widget makeButton(Section section) {
    Widget button = Container(
      width: 60,
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          print(section.name);
          Provider.of<AuditData>(context, listen: false)
              .updateActiveSection(section);
        },
        child: AutoSizeText(
          section.name,
          maxLines: 2,
          minFontSize: 5,
          style: ColorDefs.textBodyBlack10,
          wrapWords: false,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
    return button;
  }
}
