import 'package:auditor/Definitions/Dialogs.dart';
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
    Color selectColor(String programType) {
      Color color = ColorDefs.colorAlternateLight;

      if (programType == "Healthy Student Market") {
        color = ColorDefs.colorAudit1;
      }
      if (programType == "Senior Adults Program") {
        color = ColorDefs.colorAudit2;
      }
      if (programType == "Pantry Audit") {
        color = ColorDefs.colorAudit3;
      }
      if (programType == "Congregate Audit") {
        color = ColorDefs.colorAudit4;
      }
      return color;
    }

    return DataRow.byIndex(
        index: index,
        selected: calendarResult.selected,
        onSelectChanged: (bool value) {
          print(value);
          print(calendarResult.agency);
          Dialogs.showAuditInfo(
              navigatorKey.currentState.overlay.context, calendarResult);
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Text('${calendarResult.agency}',
                        style: ColorDefs.textBodyWhite15,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
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
                    child: Container(
                  color: selectColor(calendarResult.programType),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('${calendarResult.auditType}',
                        style: ColorDefs.textBodyWhite15),
                  ),
                )),
              ))),
          // DataCell(Container(
          //     height: double.infinity,
          //     width: double.infinity,
          //     color: index.isEven
          //         ? ColorDefs.colorAlternatingDark
          //         : ColorDefs.colorDarkBackground,
          //     child: Padding(
          //       padding: const EdgeInsets.all(2.0),
          //       child: Center(
          //           child: Text('${calendarResult.programType}',
          //               style: ColorDefs.textBodyWhite15)),
          //     ))),
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
}
