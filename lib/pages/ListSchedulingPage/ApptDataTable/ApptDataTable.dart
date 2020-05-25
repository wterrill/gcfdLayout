import 'dart:async';
import 'dart:convert';

import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/ExternalDataCalendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'CalendarResult.dart';
import 'CalendarResultsDataSource.dart';
import 'CustomPaginatedDataTable.dart';

import 'package:auditor/providers/ExternalDataCalendar.dart';

class ApptDataTable extends StatefulWidget {
  CalendarResultsDataSource _calendarResultsDataSource =
      CalendarResultsDataSource([]);

  @override
  _ApptDataTableState createState() => _ApptDataTableState();
}

class _ApptDataTableState extends State<ApptDataTable> {
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
    _calendarResultsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void getData() {
    print("entered getData");
    final mapCalendarResults =
        Provider.of<ListCalendarData>(context).masterEvents;

    List<Map<String, String>> filteredMapCalendarResults =
        filter(mapCalendarResults);

    List<CalendarResult> calendarResults =
        convertResultsToCalendar(filteredMapCalendarResults);

    if (!isLoaded ||
        (lastFilterText != filterText && filterText != "") ||
        Provider.of<ListCalendarData>(context, listen: false).newEventAdded) {
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
        Provider.of<ListCalendarData>(context, listen: false).lastFilterValue;
    filterText = Provider.of<ListCalendarData>(context).filterValue;
    print("building paginated data table");
    getData();
    return Expanded(
      child: Container(
        color: ColorDefs.colorTimeBackground,
        child: SingleChildScrollView(
          child: PaginatedDataTable2(
              showCheckboxColumn: false,
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
              onSelectAll: _calendarResultsDataSource.selectAll,
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
