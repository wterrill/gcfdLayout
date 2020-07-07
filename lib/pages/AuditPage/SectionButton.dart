import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clay_containers/clay_containers.dart';

class SectionButton extends StatefulWidget {
  final Section section;
  final AutoSizeGroup buttonAutoGroup;

  SectionButton({
    Key key,
    this.section,
    this.buttonAutoGroup,
  }) : super(key: key);

  @override
  _SectionButtonState createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  @override
  Widget build(BuildContext context) {
    Status status = widget.section.status;
    Widget icon;
    Color buttonColor;
    bool buttonDisabled = false;
    switch (status) {
      case Status.disabled:
        icon = Icon(
          Icons.lock,
          color: ColorDefs.colorAlternateDark,
        );
        buttonColor = ColorDefs.colorAlternateDark;
        buttonDisabled = true;
        break;

      case Status.available:
        icon = Icon(
          Icons.slideshow,
          color: ColorDefs.colorChatSelected,
        );
        buttonColor = ColorDefs.colorChatSelected;
        buttonDisabled = false;
        break;

      case Status.selected:
        icon = Icon(
          Icons.adjust,
          color: ColorDefs.colorAudit2,
        );
        buttonColor = ColorDefs.colorAudit2;
        buttonDisabled = false;
        break;

      case Status.inProgress:
        icon = Icon(
          Icons.watch_later,
          color: ColorDefs.colorAudit4,
        );
        buttonColor = ColorDefs.colorAudit4;
        buttonDisabled = false;
        break;

      case Status.completed:
        icon = Icon(
          Icons.check_circle,
          color: ColorDefs.colorButtonYes,
        );
        buttonColor = ColorDefs.colorButtonYes;
        buttonDisabled = false;
        break;
      default:
        icon = Icon(
          Icons.slideshow,
          color: ColorDefs.colorChatSelected,
        );
        buttonColor = ColorDefs.colorChatSelected;
        buttonDisabled = false;
    }
    Widget built;
    (widget.section == null)
        ? built = Text("")
        : built = Column(
            children: [
              //       child: Center(
              //   child: ClayContainer(
              //     color: baseColor,
              //     height: 200,
              //     width: 200,
              //   ),
              // ),

              //Clay
              //Clay
              Container(
                width: 110,
                height: 70,
                child: FlatButton(
                  color: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: ColorDefs.colorDarkBackground),
                  ),
                  // color: buttonColor,
                  onPressed: () {
                    buttonDisabled
                        ? null
                        : {
                            Provider.of<AuditData>(context, listen: false)
                                .updateActiveSection(widget.section),
                            Provider.of<AuditData>(context, listen: false)
                                .saveActiveAudit(),
                            Provider.of<AuditData>(context, listen: false)
                                .makeCitations(),
                          };
                  },
                  child: AutoSizeText(
                    widget.section.name,
                    group: widget.buttonAutoGroup,
                    maxLines: 2,
                    minFontSize: 14,
                    style: ColorDefs.textBodyBlack10,
                    wrapWords: true,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              icon
            ],
          );
    return built;
  }
}
