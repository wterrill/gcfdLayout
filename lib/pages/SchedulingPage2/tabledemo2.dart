import 'dart:async';
import 'dart:convert';

import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/CalendarData.dart';
import 'package:auditor/providers/ExternalDataCalendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'PaginatedDataTable2.dart';

import 'package:auditor/providers/ExternalDataCalendar.dart';
import 'package:intl/intl.dart';

class CalendarResult {
  final String startTime;
  final String agency;
  final String auditType;
  final String programNum;
  final String programType;
  final String auditor;
  final String status;
  final String message;

  DateTime startDateTime;
  // String date;

  CalendarResult(
      {this.startTime,
      this.agency,
      this.auditType,
      this.programNum,
      this.programType,
      this.auditor,
      this.status,
      this.message}) {
    startDateTime = DateTime.parse(startTime);
  }

  String getStartTimeFormatted() {
    return DateFormat.Hm().format(startDateTime).toString();
  }

  String getDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(startDateTime).toString();
  }

  bool selected = false;

  // factory CalendarResult.fromJson(Map<String, dynamic> json) {
  //   return CalendarResult(
  //     date: json['date'] as String,
  //     startTime: json['startTime'] as String,
  //     endTime: json['endTime'] as String,
  //     siteName: json['siteName'] as String,
  //     auditType: json['auditType'] as String,
  //   );
  // }
}

class CalendarResultsDataSource extends DataTableSource {
  final List<CalendarResult> _calendarResults;
  CalendarResultsDataSource(this._calendarResults);

  void _sort<T>(Comparable<T> getField(CalendarResult d), bool ascending) {
    _calendarResults.sort((CalendarResult a, CalendarResult b) {
      if (!ascending) {
        final CalendarResult c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _calendarResults.length) return null;
    final CalendarResult calendarResult = _calendarResults[index];
    return DataRow.byIndex(index: index,
        // selected: calendarResult.selected,
        // onSelectChanged: (bool value) {
        //   if (calendarResult.selected != value) {
        //     _selectedCount += value ? 1 : -1;
        //     assert(_selectedCount >= 0);
        //     calendarResult.selected = value;
        //     notifyListeners();
        //   }
        // },
        cells: <DataCell>[
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 4.0, 4.0, 4.0),
                child: Center(
                    child: Text('${calendarResult.getDateFormatted()}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Text('${calendarResult.getStartTimeFormatted()}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Text('${calendarResult.agency}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Text('${calendarResult.programNum}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Text('${calendarResult.auditType}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Text('${calendarResult.programType}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Text('${calendarResult.auditor}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 4.0, 6.0, 4.0),
                child: Center(
                    child: Text('${calendarResult.status}',
                        style: ColorDefs.textBodyWhite15)),
              ))),
        ]);
  }

  @override
  int get rowCount => _calendarResults.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (CalendarResult calendarResult in _calendarResults)
      calendarResult.selected = checked;
    _selectedCount = checked ? _calendarResults.length : 0;
    notifyListeners();
  }
}

class DataTableDemo2 extends StatefulWidget {
  CalendarResultsDataSource _calendarResultsDataSource =
      CalendarResultsDataSource([]);
  // bool isLoaded = false;

  // final String filterText = "";
  // String filterText;
  // DataTableDemo2({this.filterText});

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo2> {
  String filterText = "";
  CalendarResultsDataSource _calendarResultsDataSource =
      CalendarResultsDataSource([]);
  bool isLoaded = false;
  String lastFilterText = "";
  int _rowsPerPage = PaginatedDataTable2.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> getField(CalendarResult d), int columnIndex,
      bool ascending) {
    _calendarResultsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void getData() {
    print("entered getData");
    final mapCalendarResults = masterDayEvents;

    List<Map<String, String>> filteredMapCalendarResults =
        filter(mapCalendarResults);

    List<CalendarResult> calendarResults =
        convertResultsToCalendar(filteredMapCalendarResults);

    if (!isLoaded || (lastFilterText != filterText && filterText != "")) {
      setState(() {
        _calendarResultsDataSource = CalendarResultsDataSource(calendarResults);
        isLoaded = true;
        Provider.of<CalendarData>(context, listen: false).lastFilterValue =
            filterText;
      });
    }
  }

  List<Map<String, String>> filter(List<Map<String, String>> beer) {
    List<Map<String, String>> filteredResults = [];
    if (filterText != "") {
      for (Map<String, String> result in beer) {
        if (result['agency'].toLowerCase().contains(filterText.toLowerCase())) {
          filteredResults.add(result);
        } else if (result['programNum']
            .toLowerCase()
            .contains(filterText.toLowerCase())) {
          filteredResults.add(result);
        }
      }
      return filteredResults;
    }
    return beer;
  }

  List<CalendarResult> convertResultsToCalendar(
      List<Map<String, String>> mapCalendarResults) {
    return mapCalendarResults.map((result) {
      return CalendarResult(
        startTime: result['startTime'],
        agency: result['agency'],
        auditType: result['auditType'],
        programNum: result['programNum'],
        programType: result['programType'],
        auditor: result['auditor'],
        status: result['status'],
        message: result['message'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    lastFilterText =
        Provider.of<CalendarData>(context, listen: false).lastFilterValue;
    filterText = Provider.of<CalendarData>(context).filterValue;
    print("building paginated data table");
    getData();
    return Expanded(
      child: Container(
        color: ColorDefs.colorTimeBackground,
        child: SingleChildScrollView(
          child: PaginatedDataTable2(
              // header: const Text(''),
              headingRowHeight: 70,
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) {
                setState(() {
                  _rowsPerPage = value;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _calendarResultsDataSource._selectAll,
              columnSpacing: 0,
              dataRowHeight: 50,
              horizontalMargin: 0,
              columns: <DataColumn>[
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child:
                                Text('Date', style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.getDateFormatted(),
                        columnIndex,
                        ascending)),
                DataColumn(
                  label: Expanded(
                      child: Center(
                          child:
                              Text('Start', style: ColorDefs.textBodyBlue20))),
                  numeric: false,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (CalendarResult d) => d.startTime,
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text('Agency',
                                style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.agency,
                        columnIndex,
                        ascending)),
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text('Prog. #',
                                style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.programNum,
                        columnIndex,
                        ascending)),
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text('Audit Type',
                                style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.auditType,
                        columnIndex,
                        ascending)),
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text('Prog. Type',
                                style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.programType,
                        columnIndex,
                        ascending)),
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text('Auditor',
                                style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.auditor,
                        columnIndex,
                        ascending)),
                DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text('Status',
                                style: ColorDefs.textBodyBlue20))),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (CalendarResult d) => d.status,
                        columnIndex,
                        ascending)),
              ],
              source: _calendarResultsDataSource),
        ),
      ),
    );
  }
}
