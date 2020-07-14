// import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
// import 'package:recase/recase.dart';

class LookAhead extends StatefulWidget {
  LookAhead(
      {Key key,
      this.lookAheadCallback,
      this.setValue,
      this.disable,
      this.programNumber})
      : super(key: key);
  final Function lookAheadCallback;
  final String setValue;
  final bool disable;
  final String programNumber;

  @override
  _LookAheadState createState() => _LookAheadState();
}

class _LookAheadState extends State<LookAhead> {
  @override
  void initState() {
    super.initState();

    _typeAheadController.text = widget.setValue;
  }

  final TextEditingController _typeAheadController = TextEditingController();
  dynamic suggestion;

  @override
  Widget build(BuildContext context) {
    SiteList siteList = Provider.of<SiteData>(context).siteList;
    if (siteList == null) {
      siteList = SiteList(siteList: [
        Site(
            programDisplayName:
                "For first use, please allow the device to sync")
      ]);
    }
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
            Iterable<Site> subsites = siteList.siteList.where((Site site) {
              String sitename = site.programDisplayName;
              sitename = sitename.toLowerCase();
              if (siteList.siteList.length == 1) {
                return true;
              }
              return sitename.contains(pattern);
            });
            Iterable<String> subsubsites = subsites.map((subsite) {
              String displayName = subsite.programDisplayName;
              return displayName;
            });
            return subsubsites;
          },
          itemBuilder: (context, String suggestion) {
            return GestureDetector(
              onPanDown: (_) {
                print(suggestion);
                if (widget.disable) {
                  suggestion = widget.setValue + " - " + widget.programNumber;
                }
                _typeAheadController.text = suggestion;

                List<String> nameArray = [];
                List<String> tempArray = suggestion.split(" - ");
                if (tempArray.length == 2) {
                  nameArray = tempArray;
                }
                if (tempArray.length > 2) {
                  String biggerName = "";
                  for (int i = 0; i < tempArray.length - 1; i++) {
                    if (i == 0) {
                      biggerName = biggerName + tempArray[i];
                    } else {
                      biggerName = biggerName + " - " + tempArray[i];
                    }
                  }
                  nameArray.add(biggerName);
                  nameArray.add(tempArray[tempArray.length - 1]);
                }

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
            if (widget.disable) {
              suggestion = widget.setValue + " - " + widget.programNumber;
            }
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
