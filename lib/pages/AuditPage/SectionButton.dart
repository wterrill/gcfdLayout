import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clay_containers/clay_containers.dart';

class SectionButton extends StatefulWidget {
  final Section section;
  final AutoSizeGroup buttonAutoGroup;
  final Audit activeAudit;

  SectionButton({Key key, @required this.section, @required this.buttonAutoGroup, @required this.activeAudit})
      : super(key: key);

  @override
  _SectionButtonState createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = Provider.of<GeneralData>(context).questionScrollController;
    Status status = widget.section.status;
    if (widget.section.lastStatus == null) {
      widget.section.lastStatus = Status.available;
    }
    Status iconStatus = widget.section.lastStatus;
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
        if (iconStatus == Status.available) {
          icon = Icon(
            Icons.slideshow,
            color: ColorDefs.colorChatSelected,
          );
        }
        if (iconStatus == Status.inProgress) {
          icon = Icon(
            Icons.watch_later,
            color: ColorDefs.colorAudit4,
          );
        }
        if (iconStatus == Status.completed) {
          icon = Icon(
            Icons.check_circle,
            color: ColorDefs.colorButtonYes,
          );
        }
        if (iconStatus == Status.selected) {
          icon = Icon(
            Icons.slideshow,
            color: ColorDefs.colorChatSelected,
          );
        }
        if (iconStatus == null) {
          icon = Icon(
            Icons.slideshow,
            color: ColorDefs.colorChatSelected,
          );
        }

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
              (widget.section.maxPoints != 0 &&
                      widget.activeAudit.calendarResult.programType != "Senior Adults Program" &&
                      widget.activeAudit.calendarResult.programType != "Healthy Student Market")
                  ? Text(widget.section.currentPoints.toString() + "/" + widget.section.maxPoints.toString())
                  : Text(""),

              Container(
                width: 122,
                height: 60,
                child: FlatButton(
                  color: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: ColorDefs.colorDarkBackground),
                  ),
                  // color: buttonColor,
                  onPressed: () {
                    try {
                      _scrollController.jumpTo(0);
                    } catch (err) {
                      // this is not an error
                    }
                    buttonDisabled
                        ? null
                        : {
                            Provider.of<AuditData>(context, listen: false).updateActiveSection(widget.section),
                            Provider.of<AuditData>(context, listen: false).saveActiveAudit(),
                            Provider.of<AuditData>(context, listen: false).makeCitations(),
                          };
                  },
                  // child: Text("boob")
                  child: AutoSizeText(
                    widget.section.name,
                    group: widget.buttonAutoGroup,
                    maxLines: 2,
                    minFontSize: 14,
                    maxFontSize: 14,
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
