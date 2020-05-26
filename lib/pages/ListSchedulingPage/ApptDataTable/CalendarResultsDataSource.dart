import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/main.dart';
import 'package:flutter/material.dart';

import 'CalendarResult.dart';

class CalendarResultsDataSource extends DataTableSource {
  final List<CalendarResult> _calendarResults;
  CalendarResultsDataSource(this._calendarResults);

  void sort<T>(Comparable<T> getField(CalendarResult d), bool ascending) {
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
    return DataRow.byIndex(
        index: index,
        selected: calendarResult.selected,
        onSelectChanged: (bool value) {
          print(calendarResult.agency);

          // showDialog<void>(
          //   barrierDismissible: true,
          //   context: navigatorKey.currentState.overlay.context,
          //   builder: (BuildContext context) {
          //     return Material(
          //       child: Text(
          //           "agency: ${calendarResult.agency}, ${calendarResult.auditType}, ${calendarResult.programType}, ${calendarResult.programNum}, ${calendarResult.auditor}"),
          //     );
          //   },
          // );

          showDialog<void>(
            context: navigatorKey.currentState.overlay.context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Material(
                      child: Text(
                          "agency: ${calendarResult.agency}, ${calendarResult.auditType}, ${calendarResult.programType}, ${calendarResult.programNum}, ${calendarResult.auditor}"),
                    );
                    // return MyDialog();
                  },
                ),
              );
            },
          );

          // if (calendarResult.selected != value) {
          //   _selectedCount += value ? 1 : -1;
          //   assert(_selectedCount >= 0);
          //   calendarResult.selected = value;
          //   notifyListeners();
          // }
        },
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
  int get selectedRowCount => 0; //_selectedCount;

  // void selectAll(bool checked) {
  //   for (CalendarResult calendarResult in _calendarResults)
  //     calendarResult.selected = checked;
  //   _selectedCount = checked ? _calendarResults.length : 0;
  //   notifyListeners();
  // }
}
