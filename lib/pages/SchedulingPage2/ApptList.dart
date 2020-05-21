import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class TableSimple extends StatelessWidget {
  TableSimple(
      {@required this.data,
      @required this.titleColumn,
      @required this.titleRow});

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StickyHeadersTable(
        columnsLength: titleColumn.length,
        rowsLength: titleRow.length,
        columnsTitleBuilder: (i) => Expanded(
            child: Text(titleColumn[i], style: ColorDefs.textBodyWhite10)),
        rowsTitleBuilder: (i) => Text(titleRow[i]),
        contentCellBuilder: (i, j) =>
            Expanded(child: Text(data[i][j], style: ColorDefs.textBodyBlue10)),
        // legendCell: Text('Sticky Legend'),
      ),
    );
  }
}
