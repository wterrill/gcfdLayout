import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PaginatedDataTableList extends StatefulWidget {
  const PaginatedDataTableList({Key key}) : super(key: key);

  @override
  _PaginatedDataTableListState createState() => _PaginatedDataTableListState();
}

class _PaginatedDataTableListState extends State<PaginatedDataTableList> {
  DataTableSource dts = DTS();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // child: SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        child:
            // Container(child: Text("beer"))
            PaginatedDataTable(
          header: Text("This is a header"),
          columns: [
            DataColumn(label: Text("col#1")),
            DataColumn(label: Text("col#2")),
            DataColumn(label: Text("col#3")),
            DataColumn(label: Text("col#4")),
            DataColumn(label: Text("col#5")),
            DataColumn(label: Text("col#1")),
            DataColumn(label: Text("col#2")),
            DataColumn(label: Text("col#3")),
            DataColumn(label: Text("col#4")),
            DataColumn(label: Text("col#5")),
            DataColumn(label: Text("col#1")),
            DataColumn(label: Text("col#2")),
            DataColumn(label: Text("col#3")),
            DataColumn(label: Text("col#4")),
            DataColumn(label: Text("col#5")),
          ],
          source: dts,
          onRowsPerPageChanged: (r) {
            setState(
              () {
                _rowsPerPage = r;
              },
            );
          },
          rowsPerPage: _rowsPerPage,
        ),
      ),
    );
  }
}

class DTS extends DataTableSource {
  @override
  getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("#cell$index")),
      DataCell(Text("#cell2$index")),
      DataCell(Text("#cell3$index")),
      DataCell(Text("#cell4$index")),
      DataCell(Text("#cell5$index")),
      DataCell(Text("#cell$index")),
      DataCell(Text("#cell2$index")),
      DataCell(Text("#cell3$index")),
      DataCell(Text("#cell4$index")),
      DataCell(Text("#cell5$index")),
      DataCell(Text("#cell$index")),
      DataCell(Text("#cell2$index")),
      DataCell(Text("#cell3$index")),
      DataCell(Text("#cell4$index")),
      DataCell(Text("#cell5$index")),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
