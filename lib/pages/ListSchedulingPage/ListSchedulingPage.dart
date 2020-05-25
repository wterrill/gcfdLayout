// import 'dart:async';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/pages/ListSchedulingPage/jsonDataTabledemo.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ApptDataTable.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
// import 'package:auditor/Definitions/Event.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'LookAhead.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/LayoutData.dart';
import 'package:rxdart/rxdart.dart';

// import 'dart:developer';

class ListSchedulingPage extends StatefulWidget {
  // final controller = StreamController<String>();

  @override
  _ListSchedulingPageState createState() => _ListSchedulingPageState();
}

class _ListSchedulingPageState extends State<ListSchedulingPage> {
  // final controller = BehaviorSubject<String>();
  bool backgroundDisable = false;
  final filterTextController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaWidth = Provider.of<LayoutData>(context).mediaArea.width;
    backgroundDisable = Provider.of<LayoutData>(context).backgroundDisable;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                TopWhiteHeaderWidget(), // white bar
                Expanded(
                  child: Container(
                    color: ColorDefs.colorDarkBackground,
                    child: Provider.of<ListCalendarData>(context).initialized
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // SizedBox(width: 50),
                                      FlatButton(
                                        color: ColorDefs.colorAudit2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: ColorDefs
                                                    .colorAlternateDark)),
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      StateSetter setState) {
                                                    return NewAuditDialog();
                                                    // return MyDialog();
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text("Schedule New Audit",
                                            style: ColorDefs.textBodyWhite20),
                                      ),
                                      // SizedBox(width: 10),
                                      FlatButton(
                                        color: ColorDefs.colorAudit2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: ColorDefs
                                                    .colorAlternateDark)),
                                        onPressed: () {
                                          print("Show this week pressed");
                                        },
                                        child: Text("Show This Week",
                                            style: ColorDefs.textBodyWhite20),
                                      ),
                                      // SizedBox(width: 10),
                                      SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextField(
                                          onChanged: (text) {
                                            Provider.of<ListCalendarData>(
                                                    context,
                                                    listen: false)
                                                .updateFilterValue(
                                                    filterTextController.text);
                                          },
                                          controller: filterTextController,
                                          style: ColorDefs.textBodyBlack20,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.teal,
                                                ),
                                              ),
                                              hintText:
                                                  'Agency / Program Number Filter'),
                                        ),
                                      )
                                    ]),
                              ),
                              ApptDataTable()
                            ],
                          )
                        : Text("not initialized"),
                  ),
                ),
              ],
            ),
            // ),
            if (backgroundDisable)
              Container(color: ColorDefs.colorDisabledBackground),

            TopDrawerWidget(),
            AuditPage()
          ],
        ),
      ),
    );
  }
}

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
    print("doing build for New Audit Dialog");
    List<DropdownMenuItem<String>> dropdown(List<String> stringArray) {
      List<DropdownMenuItem<String>> dropDownList =
          stringArray.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();
      return dropDownList;
    }

    // String selectedFormattedTime = DateFormat.jm().format(DateTime.now());

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            // mainAxisSize: MainAxisSize.min,

            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  // flex: 1,
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Audit Type"),
                  Text("Program Type"),
                  Text("Date"),
                  Text("Start Time"),
                ],
              )),
              SizedBox(width: 20),
              Expanded(
                  // flex: 1,
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    isExpanded: true,
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
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedProgType ?? "Select",
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 100,
                    style: ColorDefs.textBodyBlack20,
                    underline: Container(
                      height: 2,
                      color:
                          (selectedProgType == "") ? Colors.red : Colors.green,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        selectedProgType = newValue;
                      });
                    },
                    items: dropdown(programTypeDropDownMenu),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime selectedDatex;
                      selectedDatex = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child,
                          );
                        },
                      );

                      setState(() {
                        selectedDate = selectedDatex;
                      });
                    },
                    child:
                        Text(DateFormat('EEE MM-dd-yyyy').format(selectedDate)),
                    // selectedFormattedDate,
                    //     style: ColorDefs.textBodyBlue20),
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay selectedTimeRTL = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        // builder: (BuildContext context,
                        //     Widget child) {
                        //   return Directionality(
                        //     textDirection: TextDirection.LTR,
                        //     child: child,
                        //   );
                        // },
                      );
                      setState(() {
                        selectedTime = selectedTimeRTL;
                      });
                    },
                    child: Text(selectedTime.format(context).toString()),
                  ),
                ],
              ))
            ],
          ),
          LookAhead(
            lookAheadCallback: (List<String> val) {
              selectedSiteName = val[0];
              selectedProgramNumber = val[1];
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          )
        ],
      ),
    );
  }
}
