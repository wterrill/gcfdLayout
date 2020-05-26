import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ApptDataTable/CustomPaginatedDataTable.dart';

Future<List<Result>> fetchResults(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/comments');

  // Use the compute function to run parseResults in a separate isolate
  return compute(parseResults, response.body);
}

// A function that will convert a response body into a List<Result>
List<Result> parseResults(String responseBody) {
  final dynamic parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<Result>((Map<String, dynamic> json) => Result.fromJson(json))
      .toList() as List<Result>;
}

class Result {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Result({this.postId, this.id, this.name, this.email, this.body});

  bool selected = false;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      postId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}

class ResultsDataSource extends DataTableSource {
  final List<Result> _results;
  ResultsDataSource(this._results);

  void _sort<T>(Comparable<T> getField(Result d), bool ascending) {
    _results.sort((Result a, Result b) {
      if (!ascending) {
        final Result c = a;
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
    if (index >= _results.length) return null;
    final Result result = _results[index];
    return DataRow.byIndex(
        index: index,
        selected: result.selected,
        onSelectChanged: (bool value) {
          if (result.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            result.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven ? Colors.blue : Colors.red,
              child: Center(child: Text('${result.postId}')))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven ? Colors.blue : Colors.red,
              child: Center(child: Text('${result.id}')))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven ? Colors.blue : Colors.red,
              child: Center(child: Text('${result.name}')))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven ? Colors.blue : Colors.red,
              child: Center(child: Text('${result.email}')))),
          DataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven ? Colors.blue : Colors.red,
              child: Center(child: Text('${result.body}')))),
        ]);
  }

  @override
  int get rowCount => _results.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Result result in _results) result.selected = checked;
    _selectedCount = checked ? _results.length : 0;
    notifyListeners();
  }
}

class JsonDataTableDemo extends StatefulWidget {
  ResultsDataSource _resultsDataSource = ResultsDataSource([]);
  bool isLoaded = false;

  @override
  _JsonDataTableDemoState createState() => _JsonDataTableDemoState();
}

class _JsonDataTableDemoState extends State<JsonDataTableDemo> {
  ResultsDataSource _resultsDataSource = ResultsDataSource([]);
  bool isLoaded = false;
  int _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(
      Comparable<T> getField(Result d), int columnIndex, bool ascending) {
    _resultsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  Future<void> getData() async {
    final results = await fetchResults(http.Client());
    if (!isLoaded) {
      setState(() {
        _resultsDataSource = ResultsDataSource(results);
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Expanded(
      child: SingleChildScrollView(
        child: CustomPaginatedDataTable(
            // header: const Text(''),
            headingRowHeight: 20,
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            onSelectAll: _resultsDataSource._selectAll,
            columnSpacing: 0,
            dataRowHeight: 30,
            horizontalMargin: 0,
            columns: <DataColumn>[
              DataColumn(
                  label: Expanded(child: Center(child: Text('postId'))),
                  numeric: false,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                      (Result d) => d.postId, columnIndex, ascending)),
              DataColumn(
                  label: Expanded(child: Center(child: Text('id'))),
                  numeric: false,
                  onSort: (int columnIndex, bool ascending) =>
                      _sort<num>((Result d) => d.id, columnIndex, ascending)),
              DataColumn(
                  label: Expanded(child: Center(child: Text('Name'))),
                  numeric: false,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (Result d) => d.name, columnIndex, ascending)),
              DataColumn(
                  label: Expanded(child: Center(child: Text('Data'))),
                  numeric: false,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (Result d) => d.email, columnIndex, ascending)),
              DataColumn(
                  label: Expanded(child: Center(child: Text('Body'))),
                  numeric: false,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (Result d) => d.body, columnIndex, ascending)),
            ],
            source: _resultsDataSource),
      ),
    );
  }
}
