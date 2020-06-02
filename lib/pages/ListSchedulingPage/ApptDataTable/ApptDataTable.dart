import 'dart:async';
import 'dart:convert';

import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/pages/developer/hiveTest/Contact.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'CalendarResult.dart';
import 'CalendarResultsDataSource.dart';
import 'CustomPaginatedDataTable.dart';

// FutureBuilder<String>(
//   future: _calculation, // a Future<String> or null
//   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//     switch (snapshot.connectionState) {
//       case ConnectionState.none: return new Text('Press button to start');
//       case ConnectionState.waiting: return new Text('Awaiting result...');
//       default:
//         if (snapshot.hasError)
//           return new Text('Error: ${snapshot.error}');
//         else
//           return new Text('Result: ${snapshot.data}');
//     }
//   },
// )

class ApptDataTable extends StatefulWidget {
  CalendarResultsDataSource _calendarResultsDataSource =
      CalendarResultsDataSource([]);

  @override
  _ApptDataTableState createState() => _ApptDataTableState();
}

class _ApptDataTableState extends State<ApptDataTable> {
  @override
  String filterText = "";

  CalendarResultsDataSource _calendarResultsDataSource =
      CalendarResultsDataSource([]);

  bool isLoaded = false;
  String lastFilterText = "";
  bool filterTimeToggle;
  int _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> getField(CalendarResult d), int columnIndex,
      bool ascending) {
    _calendarResultsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void getData() {
    print("entered getData");
    Box calendarBox = Provider.of<ListCalendarData>(context).calendarBox;
    List<CalendarResult> calendarResults = [];
    if (calendarBox != null) {
      calendarResults = calendarBox.values.toList() as List<CalendarResult>;
    }

    List<CalendarResult> filteredCalendarResults = filter(calendarResults);

    calendarResults = filterTimeApply(filteredCalendarResults);

    // List<CalendarResult> calendarResults =
    //     convertResultsToCalendar(filteredMapCalendarResults);

    bool firstload_or_StartFiltering_or_DeleteFilter_or_AddEvent = !isLoaded ||
        (lastFilterText != filterText && filterText != "") ||
        (lastFilterText.length == 1 && filterText == "") ||
        Provider.of<ListCalendarData>(context, listen: false).newEventAdded;

    if (firstload_or_StartFiltering_or_DeleteFilter_or_AddEvent) {
      setState(() {
        _calendarResultsDataSource = CalendarResultsDataSource(calendarResults);
        isLoaded = true;
        Provider.of<ListCalendarData>(context, listen: false).lastFilterValue =
            filterText;
        Provider.of<ListCalendarData>(context, listen: false).newEventAdded =
            false;
      });
    }
  }

  List<CalendarResult> filter(List<CalendarResult> listToFilter) {
    List<CalendarResult> filteredResults = [];
    if (filterText != "") {
      for (CalendarResult result in listToFilter) {
        if (result.agency.toLowerCase().contains(filterText.toLowerCase())) {
          filteredResults.add(result);
        } else if (result.programNum
            .toLowerCase()
            .contains(filterText.toLowerCase())) {
          filteredResults.add(result);
        }
      }
      return filteredResults;
    }
    return listToFilter;
  }

  Map<String, DateTime> getTimeRange() {
    DateTime now = DateTime.now();
    DateTime future = now.add(Duration(days: 7));
    DateTime past = now.subtract(Duration(days: 7));
    return {'past': past, 'future': future};
  }

  List<CalendarResult> filterTimeApply(List<CalendarResult> listToFilter) {
    List<CalendarResult> filteredResults = [];

    if (filterTimeToggle) {
      Map<String, DateTime> range = getTimeRange();
      for (CalendarResult result in listToFilter) {
        DateTime resultTime = result.startDateTime;
        if (resultTime.isAfter(range['past']) &&
            resultTime.isBefore(range['future'])) {
          filteredResults.add(result);
        }
      }
      return filteredResults;
    }
    return listToFilter;
  }

  @override
  Widget build(BuildContext context) {
    bool initialized = Provider.of<ListCalendarData>(context).initialized;
    filterTimeToggle = Provider.of<ListCalendarData>(context).filterTimeToggle;

    lastFilterText =
        Provider.of<ListCalendarData>(context, listen: false).lastFilterValue;
    filterText = Provider.of<ListCalendarData>(context).filterValue;
    print("building paginated data table");
    getData();
    print("BUILD PAGINATEDDATATABLE2");
    return !initialized
        ? (Text("Initializing..."))
        : Expanded(
            child: Container(
              color: ColorDefs.colorTimeBackground,
              child: SingleChildScrollView(
                child: CustomPaginatedDataTable(
                  onPageChanged: (value) {
                    // print("onPageChanged value: $value");
                    // print(
                    //     'onPageChanged _calendarResultsDataSource.rowCount: ${_calendarResultsDataSource.rowCount}');
                    // print('_rowsPerPage: $_rowsPerPage');
                    // if (value + _rowsPerPage > _calendarResultsDataSource.rowCount) {
                    //   print(
                    //       "adjust!!!! to: ${_calendarResultsDataSource.rowCount - value}");
                    //   _rowsPerPage = _calendarResultsDataSource.rowCount - value;
                    //   print(_rowsPerPage);
                    //   // setState(() {});
                    //   // _normalRowPerPage =
                    // }
                  },
                  source: _calendarResultsDataSource,
                  showCheckboxColumn: false,
                  headingRowHeight: 70,
                  rowsPerPage: _rowsPerPage,
                  onRowsPerPageChanged: (int value) {
                    setState(() {
                      print("value: $value");
                      print(
                          "_calendarResultsDataSource.rowCount: ${_calendarResultsDataSource.rowCount}");
                      _rowsPerPage = value;
                      print(_rowsPerPage);
                    });
                  },
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  // onSelectAll: _calendarResultsDataSource.selectAll,
                  columnSpacing: 0,
                  dataRowHeight: 50,
                  horizontalMargin: 0,
                  columns: <DataColumn>[
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Date',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (CalendarResult d) => d.getDateFormatted(),
                                columnIndex,
                                ascending)),
                    DataColumn(
                      label: Expanded(
                          child: Center(
                              child: Text('Start',
                                  style: ColorDefs.textBodyBlue20))),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CalendarResult d) => d.startTime,
                              columnIndex, ascending),
                    ),
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Agency',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.agency,
                                columnIndex, ascending)),
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Prog. #',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.programNum,
                                columnIndex, ascending)),
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Audit Type',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.auditType,
                                columnIndex, ascending)),
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Prog. Type',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.programType,
                                columnIndex, ascending)),
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Auditor',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.auditor,
                                columnIndex, ascending)),
                    DataColumn(
                        label: Expanded(
                            child: Center(
                                child: Text('Status',
                                    style: ColorDefs.textBodyBlue20))),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.status,
                                columnIndex, ascending)),
                  ],
                ),
              ),
            ),
          );
  }
}
