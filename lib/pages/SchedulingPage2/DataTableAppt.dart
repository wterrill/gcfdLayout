import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DataTableAppt extends StatelessWidget {
  const DataTableAppt({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataColumn> getColumns() {
      List<DataColumn> columns = [];
      for (var i = 0; i < 32; i++) {
        columns.add(DataColumn(
            label: Text("Head$i", style: ColorDefs.textBodyWhite20)));
      }
      return columns;
    }

    List<DataCell> getCells() {
      List<DataCell> cells = [];
      for (var i = 0; i < 32; i++) {
        cells.add(DataCell(Text("beers $i ${Random().nextInt(100)}",
            style: ColorDefs.textBodyBlue20)));
      }
      return cells;
    }

    List<DataRow> getRows() {
      List<DataRow> rows = [];
      for (var i = 0; i < 32; i++) {
        rows.add(DataRow(cells: [...getCells()]));
      }
      return rows;
    }

    return Expanded(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: [...getColumns()], rows: [...getRows()]),
          )),
    );
  }
}
