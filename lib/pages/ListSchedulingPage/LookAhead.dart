import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class LookAhead extends StatefulWidget {
  LookAhead({Key key, this.lookAheadCallback}) : super(key: key);
  Function lookAheadCallback;

  @override
  _LookAheadState createState() => _LookAheadState();
}

class _LookAheadState extends State<LookAhead> {
  final TextEditingController _typeAheadController = TextEditingController();
  dynamic suggestion;

  @override
  Widget build(BuildContext context) {
    // Function beer = widget.lookAheadCallback;
    // print(widget.lookAheadCallback);
    List<List<dynamic>> sites = Provider.of<SiteData>(context)
        .rowsAsListOfValues; //as List<List<dynamic>>;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration<String>(
              autofocus: false,
              // style: DefaultTextStyle.of(context)
              //     .style
              //     .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                labelText:
                    'Enter part of agency name or program number to search',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => _typeAheadController.clear(),
                  icon: Icon(Icons.clear),
                ),
              ),
              controller: _typeAheadController),
          suggestionsCallback: (pattern) async {
            pattern = pattern.toLowerCase();
            var subsites = sites.where((site) {
              print(site.length);
              print(site);
              String sitename = site[3] as String;
              sitename = sitename.toLowerCase();
              return sitename.contains(pattern);
            }); //.toList();
            Iterable<String> subsubsites = subsites.map((subsite) {
              // String nameProgNum = subsite[3] as String;
              String progNum = subsite[0] as String;
              String name = subsite[2] as String;

              return name.titleCase + " - " + progNum;
            });
            return subsubsites;
          },
          itemBuilder: (context, String suggestion) {
            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              dense: true,
              title: Text(suggestion), // .titleCase),
            );
          },
          onSuggestionSelected: (suggestion) {
            _typeAheadController.text = suggestion; //.titleCase;

            List<String> nameArray = suggestion.split(" - ");
            print("name: ${nameArray[0]} program number: ${nameArray[1]}");
            widget.lookAheadCallback(nameArray);
          },
        )
      ],
    );
  }
}
