// import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class LookAhead extends StatefulWidget {
  LookAhead({Key key, this.lookAheadCallback, this.setValue}) : super(key: key);
  final Function lookAheadCallback;
  final String setValue;

  @override
  _LookAheadState createState() => _LookAheadState();
}

class _LookAheadState extends State<LookAhead> {
  @override
  void initState() {
    // TODO: implement initState
    _typeAheadController.text = widget.setValue;
  }

  final TextEditingController _typeAheadController = TextEditingController();
  dynamic suggestion;

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> sites =
        Provider.of<SiteData>(context).rowsAsListOfValues;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration<String>(
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Enter agency name or program number',
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
            });
            Iterable<String> subsubsites = subsites.map((subsite) {
              String progNum = subsite[0] as String;
              String name = subsite[2] as String;
              String agencyName = subsite[1] as String;

              return name.titleCase + " - " + progNum;
            });
            return subsubsites;
          },
          itemBuilder: (context, String suggestion) {
            return GestureDetector(
              onPanDown: (_) {
                print(suggestion);
                _typeAheadController.text = suggestion;

                List<String> nameArray = suggestion.split(" - ");
                print("name: ${nameArray[0]} program number: ${nameArray[1]}");
                widget.lookAheadCallback(nameArray);
              },
              child: Container(
                color: ColorDefs.colorAlternatingDark,
                child: ListTile(
                  dense: true,
                  title: Text(suggestion),
                ),
              ),
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
