import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class LookAhead extends StatefulWidget {
  LookAhead({Key key}) : super(key: key);

  @override
  _LookAheadState createState() => _LookAheadState();
}

class _LookAheadState extends State<LookAhead> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> sites =
        Provider.of<SiteData>(context).rowsAsListOfValues;
    return Scaffold(
      appBar: AppBar(
        title: Text("look ahead test"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration<String>(
                  autofocus: true,
                  // style: DefaultTextStyle.of(context)
                  //     .style
                  //     .copyWith(fontStyle: FontStyle.italic),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: this._typeAheadController),
              suggestionsCallback: (pattern) async {
                pattern = pattern.toLowerCase();
                var subsites = sites.where((site) {
                  print(pattern);
                  String sitename = site[1];
                  print(sitename);
                  sitename = sitename.toLowerCase();
                  print(sitename);
                  return sitename.contains(pattern);
                }); //.toList();
                Iterable<String> subsubsites =
                    subsites.map((subsite) => subsite[1]);
                return subsubsites;
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(title: Text(suggestion));
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion;
              })
        ],
      ),
    );
  }
}
