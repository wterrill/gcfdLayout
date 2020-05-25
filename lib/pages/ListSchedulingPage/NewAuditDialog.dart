import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'LookAhead.dart';

class NewAuditDialog extends StatefulWidget {
  NewAuditDialog({Key key}) : super(key: key);

  @override
  _NewAuditDialogState createState() => _NewAuditDialogState();
}

class _NewAuditDialogState extends State<NewAuditDialog> {
  final _formKey = GlobalKey<FormState>();
  String selectedAuditType = "Select";
  String selectedProgType = "Select";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedSiteName;
  String selectedProgramNumber;
  String auditor;

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

  List<String> programTypeDropDownMenu = [
    "Select",
    "Healthy Student Market",
    "Older Adults",
    "Pantry",
    "Congregate"
  ];

  @override
  Widget build(BuildContext context) {
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
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            primaryColor: Colors.yellow, //Color(0xFF8CE7F1),
                            accentColor: Color(0xFF8CE7F1),
                            colorScheme:
                                ColorScheme.dark(primary: Color(0xFF8CE7F1)),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),

                            brightness: Brightness.dark,
                            // primaryColor: Colors.lightBlue[800],
                            // accentColor: Colors.cyan[600],
                            // fontFamily: 'Georgia',
                            textTheme:
                                TextTheme(headline1: ColorDefs.textBodyWhite20),
                          ),
                          child: child,
                        );
                      },
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
                      context: context,
                      initialTime: TimeOfDay.now(),
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
            LookAhead(
              lookAheadCallback: (List<String> val) {
                selectedSiteName = val[1];
                selectedProgramNumber = val[1];
              },
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              child: FlatButton(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: ColorDefs.colorAudit2)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print(selectedDate);
                    print(selectedTime.format(context).toString());

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
                    Provider.of<ListCalendarData>(context, listen: false)
                        .addEvent({
                      'startTime': selectedDateTime.toString(),
                      'message': '',
                      'agency': selectedSiteName,
                      'auditType': selectedAuditType,
                      'programNum': selectedProgramNumber,
                      'programType': selectedProgType,
                      'auditor': "jenny bear",
                      'status': "scheduled"
                    });

                    Navigator.of(context).pop();
                  }
                },
                child: Text("Schedule Audit", style: ColorDefs.textBodyBlue20),
              ),
            ),
            // SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
