// import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/LoginScreen/LoginScreen.dart';
import 'package:auditor/pages/developer/DeveloperMenu.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

class TopWhiteHeaderWidget extends StatefulWidget {
  const TopWhiteHeaderWidget({Key key}) : super(key: key);

  @override
  _TopWhiteHeaderWidgetState createState() => _TopWhiteHeaderWidgetState();
}

class _TopWhiteHeaderWidgetState extends State<TopWhiteHeaderWidget> {
  final filterTextController = TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        // Top header (white)
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: ColorDefs.colorTopHeader,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              child: Hero(
                tag: "GCFD_Logo",
                child: Image(
                  image: AssetImage('assets/images/GCFD_Logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 450,
              child: TextField(
                onChanged: (text) {
                  if (text.toLowerCase() == "version") {
                    Dialogs.showVersionDialog(context);
                  }
                  if (text.toLowerCase() == "developer") {
                    Navigator.of(context).pop();
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (context) => DeveloperMenu()),
                    );
                  }
                  Provider.of<ListCalendarData>(context, listen: false)
                      .updateFilterValue(filterTextController.text);
                },
                controller: filterTextController,
                style: ColorDefs.textBodyBlack20,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        filterTextController.clear();
                        Provider.of<ListCalendarData>(context, listen: false)
                            .updateFilterValue(filterTextController.text);
                      },
                      icon: Icon(Icons.clear),
                    ),
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.teal,
                      ),
                    ),
                    hintText:
                        '                    Agency / Program Number Filter'),
              ),
            ),

            if (Provider.of<GeneralData>(context, listen: true).syncInProgress)
              CircularProgressIndicator(),
            if (Provider.of<GeneralData>(context, listen: true).syncInProgress)
              Text(
                Provider.of<GeneralData>(context).syncMessage,
                style: ColorDefs.textBodyBlack10,
              ),
            // RaisedButton(
            //     color: Colors.blue,
            //     child: Text("Developer"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //       Navigator.push<dynamic>(
            //         context,
            //         MaterialPageRoute<dynamic>(
            //             builder: (context) => DeveloperMenu()),
            //       );
            //     }),

            //
            //
            //

            // Theme(
            //   data: Theme.of(context).copyWith(
            //     cardColor: Colors.purple,
            //     brightness: Brightness.light,
            //     primaryColor: Colors.lightBlue[800],
            //     accentColor: Colors.cyan[600],
            //   ),
            //   child:
            PopupMenuButton<String>(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorDefs.colorUserAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorDefs.colorDarkBackground,
                                width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                          ),
                          child: Icon(
                            Icons.person,
                            color: ColorDefs.colorDarkBackground,
                            size: 30.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          Provider.of<GeneralData>(context, listen: false)
                                  .username ??
                              "generic login",
                          style: ColorDefs.textBodyBlack20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              color: ColorDefs.colorAlternatingDark,
              elevation: 3,
              offset: Offset(0, 43),
              onSelected: (dynamic result) {
                Navigator.of(context).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => LoginScreen()),
                );
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  // value: WhyFarther.harder,
                  child: Text('Logout'),
                ),
                // const PopupMenuItem<WhyFarther>(
                //   value: WhyFarther.smarter,
                //   child: Text('Being'),
                // ),
              ],
            ),
            //)
          ],
        ),
      ),
    );
    // end of top white bar
  }
}
