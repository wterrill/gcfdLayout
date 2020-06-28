import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'LookAhead.dart';

class NewAuditDialog extends StatefulWidget {
  final CalendarResult calendarResult;
  final bool followup;
  NewAuditDialog({Key key, this.calendarResult, @required this.followup})
      : super(key: key);

  @override
  _NewAuditDialogState createState() => _NewAuditDialogState();
}

class _NewAuditDialogState extends State<NewAuditDialog> {
  final _formKey = GlobalKey<FormState>();
  String selectedAuditType = "Select";
  String selectedProgType = "Select";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);
  String selectedSiteName;
  String selectedProgramNumber;
  String selectedAgencyNum;
  String selectedAuditor = "Select";
  bool alreadyExisted = false;
  // String auditor;

  @override
  void initState() {
    super.initState();
    if (widget.calendarResult != null) {
      this.selectedAuditType = widget.calendarResult.auditType;
      this.selectedProgType = widget.calendarResult.programType;
      this.selectedDate = widget.calendarResult.startDateTime;
      this.selectedTime =
          TimeOfDay.fromDateTime(widget.calendarResult.startDateTime);
      this.selectedSiteName = widget.calendarResult.agencyName;
      this.selectedProgramNumber = widget.calendarResult.programNum;
      this.selectedAuditor = widget.calendarResult.auditor;
      this.selectedAgencyNum = widget.calendarResult.agencyNum;
      alreadyExisted = true;
    }

    auditorDropDownMenu = Provider.of<ListCalendarData>(context, listen: false)
        .auditorList
        .getAuditorDropDown();
    siteList = Provider.of<SiteData>(context, listen: false).siteList;
  }

  List<String> auditorDropDownMenu;

  List<String> auditTypeDropDownMenu = [
    "Select",
    "Annual",
    "Food Rescue",
    "CEDA",
    "Bi-Annual",
    "Complaint",
    "Follow Up",
    "Grant"
  ];

  SiteList siteList;

  // List<String> auditorDropDownMenu = [
  //   "Select",
  //   "Will Terrill",
  //   "Abraham Jimenez",
  //   "Andrei Kliuchnik",
  // ];

  List<String> programTypeDropDownMenu = [
    "Select",
    "Healthy Student Market",
    "Senior Adults Program",
    "Pantry Audit",
    "Congregate Audit"
  ];

  @override
  Widget build(BuildContext context) {
    bool timeInPastOK = false;
    bool validateEntry() {
      bool validated = true;
      if (selectedAuditType == "Select") {
        validated = false;
      } else if (selectedAuditor == "Select") {
        validated = false;
      } else if (selectedProgType == "Select") {
        validated = false;
      } else if (selectedProgramNumber == null) {
        validated = false;
      } else if (selectedSiteName == null) {
        validated = false;
      } else if (selectedTime == null) {
        validated = false;
      }

      return validated;
    }

    bool pastTimeWarning() {
      bool pastTime = false;
      DateTime enteredTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, selectedTime.hour, selectedTime.minute);
      if (DateTime.now().isAfter(enteredTime)) {
        pastTime = true;
      }
      return pastTime;
    }

    List<DropdownMenuItem<String>> dropdown(List<String> stringArray) {
      List<DropdownMenuItem<String>> dropDownList =
          stringArray.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: ColorDefs.textBodyBlue20,
          ),
        );
      }).toList();
      return dropDownList;
    }

    return Container(
      width: 500,
      height: 500,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            LookAhead(
              disable: widget.followup,
              setValue: selectedSiteName,
              programNumber: (widget.followup) ? selectedProgramNumber : null,
              lookAheadCallback: (List<String> val) {
                selectedSiteName = val[0];
                selectedProgramNumber = val[1];
                selectedAgencyNum =
                    siteList.agencyNumFromAgencyName(selectedSiteName);
                print(selectedAgencyNum);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Audit Type",
                  style: ColorDefs.textBodyBlue20,
                ),
                Container(
                  child: DropdownButton<String>(
                    isExpanded: false,
                    value: selectedAuditType ?? "Select",
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: ColorDefs.textBodyBlack20,
                    underline: Container(
                      height: 2,
                      color:
                          (selectedAuditType == "") ? Colors.red : Colors.green,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        if (widget.followup) {
                          newValue = "Follow Up";
                        }
                        selectedAuditType = newValue;
                      });
                    },
                    items: dropdown(auditTypeDropDownMenu),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Program Type", style: ColorDefs.textBodyBlue20),
                DropdownButton<String>(
                  // isExpanded: true,
                  value: selectedProgType ?? "Select",
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 100,
                  style: ColorDefs.textBodyBlack20,
                  underline: Container(
                    height: 2,
                    color: (selectedProgType == "") ? Colors.red : Colors.green,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      if (widget.followup) {
                        newValue = selectedProgType;
                      }
                      selectedProgType = newValue;
                    });
                  },
                  items: dropdown(programTypeDropDownMenu),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date", style: ColorDefs.textBodyBlue20),
                GestureDetector(
                  onTap: () async {
                    DateTime fromCalendar;
                    fromCalendar = await showDatePicker(
                      helpText: "Select a Date",
                      cancelText: "Cancel",
                      confirmText: "Confirm",
                      errorFormatText: "errorFormat",
                      errorInvalidText: "errorInvalidText",
                      fieldHintText: "fieldHintText",
                      fieldLabelText: "fieldLabelText",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                      // builder: (BuildContext context, Widget child) {
                      //   return Theme(
                      //     data: ThemeData.dark().copyWith(
                      //       primaryColor: Colors.yellow, //Color(0xFF8CE7F1),
                      //       accentColor: Color(0xFF8CE7F1),
                      //       colorScheme:
                      //           ColorScheme.dark(primary: Color(0xFF8CE7F1)),
                      //       buttonTheme: ButtonThemeData(
                      //           textTheme: ButtonTextTheme.primary),

                      //       brightness: Brightness.dark,
                      //       // primaryColor: Colors.lightBlue[800],
                      //       // accentColor: Colors.cyan[600],
                      //       // fontFamily: 'Georgia',
                      //       textTheme:
                      //           TextTheme(headline1: ColorDefs.textBodyWhite20),
                      //     ),
                      //     child: child,
                      //   );
                      // },
                    );

                    setState(() {
                      if (fromCalendar != null) {
                        selectedDate = fromCalendar;
                      }
                    });
                  },
                  child:
                      Text(DateFormat('EEE MM-dd-yyyy').format(selectedDate)),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Start Time", style: ColorDefs.textBodyBlue20),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay fromTimeSelector = await showTimePicker(
                        context: context, initialTime: selectedTime
                        // builder: (BuildContext context, Widget child) {
                        //   return Directionality(
                        //     // textDirection: TextDirection.LTR,
                        //     child: child,
                        //   );
                        // },
                        );
                    setState(() {
                      if (fromTimeSelector != null) {
                        selectedTime = fromTimeSelector;
                      }
                    });
                  },
                  child: Text(selectedTime.format(context).toString()),
                ),
              ],
            ),

            ////////////////////////

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Auditor",
                  style: ColorDefs.textBodyBlue20,
                ),
                Container(
                  child: DropdownButton<String>(
                    isExpanded: false,
                    value: selectedAuditor ?? "Select",
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: ColorDefs.textBodyBlack20,
                    underline: Container(
                      height: 2,
                      color:
                          (selectedAuditType == "") ? Colors.red : Colors.green,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        selectedAuditor = newValue;
                      });
                    },
                    items: dropdown(auditorDropDownMenu),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              child: FlatButton(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: ColorDefs.colorAudit2)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print(selectedDate);
                    print(selectedTime.format(context).toString());
                    bool validateDateTime = pastTimeWarning();
                    if (validateDateTime) {
                      Function callBack = () {
                        timeInPastOK = true;
                      };
                      await Dialogs.timeInPast(context, callBack);
                    } else {
                      timeInPastOK = true;
                    }

                    bool validated = validateEntry();

                    if (validated && timeInPastOK) {
                      if (alreadyExisted) {
                        Provider.of<ListCalendarData>(context, listen: false)
                            .deleteCalendarItem(widget.calendarResult);
                      }

                      // TimeOfDay t;
                      // final now = new DateTime.now();
                      DateTime selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute);
                      print(selectedDateTime.toString());
                      print(selectedSiteName);
                      print(selectedProgramNumber);

                      // Provider.of<ListCalendarData>(context, listen: false)
                      //     .addEvent({
                      //   'startTime': selectedDateTime.toString(),
                      //   'message': '',
                      //   'agency': selectedSiteName,
                      //   'auditType': selectedAuditType,
                      //   'programNum': selectedProgramNumber,
                      //   'programType': selectedProgType,
                      //   'auditor': selectedAuditor,
                      //   'status': "scheduled"
                      // });
                      String deviceid =
                          Provider.of<GeneralData>(context, listen: false)
                              .deviceid;

                      Provider.of<ListCalendarData>(context, listen: false)
                          .addBoxEvent(event: {
                        'startTime': selectedDateTime.toString(),
                        'message': '',
                        'agencyName': selectedSiteName,
                        'agencyNum': selectedAgencyNum,
                        'auditType': selectedAuditType,
                        'programNum': selectedProgramNumber,
                        'programType': selectedProgType,
                        'auditor': selectedAuditor,
                        'status': "Scheduled",
                        'deviceid': deviceid,
                      }, notify: true);

                      Navigator.of(context).pop();
                      if (alreadyExisted) {
                        Navigator.of(context).pop();
                      }
                    } else {
                      Dialogs.showBadSchedule(context);
                    }
                  }
                },
                child: (alreadyExisted)
                    ? (widget.followup)
                        ? Text("Schedule Follow-Up Audit",
                            style: ColorDefs.textBodyBlue20)
                        : Text("Save Audit", style: ColorDefs.textBodyBlue20)
                    : Text("Schedule Audit", style: ColorDefs.textBodyBlue20),
              ),
            ),

            if (alreadyExisted && !widget.followup)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: FlatButton(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: ColorDefs.colorAudit5)),
                    onPressed: () async {
                      bool result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text(
                                'Do you want to delete this Scheduled Audit?'),
                            actions: <Widget>[
                              new FlatButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop(
                                      false); // dismisses only the dialog and returns false
                                },
                                child: Text('Cancel'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(true);
                                  Provider.of<ListCalendarData>(context,
                                          listen: false)
                                      .deleteCalendarItem(
                                          widget.calendarResult);
                                  setState(
                                      () {}); // dismisses only the dialog and returns true
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );

                      if (result) {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print(selectedDate);
                          print(selectedTime.format(context).toString());

                          Provider.of<ListCalendarData>(context, listen: false)
                              .deleteCalendarItem(widget.calendarResult);

                          Navigator.of(context).pop();
                          if (alreadyExisted) {
                            Navigator.of(context).pop();
                          }
                        }
                      } else {
                        Navigator.of(context)
                            .pop(); // dismisses the entire widget
                      }
                    },
                    child:
                        Text("Delete Audit", style: ColorDefs.textBodyBlue20)),
              ),
          ],
        ),
      ),
    );
  }
}
