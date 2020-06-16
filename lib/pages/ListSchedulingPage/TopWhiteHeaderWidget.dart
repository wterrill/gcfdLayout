// import 'package:auditor/providers/LayoutData.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/developer/DeveloperMenu.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

class TopWhiteHeaderWidget extends StatelessWidget {
  const TopWhiteHeaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Top header (white)
      height: 50,
      color: ColorDefs.colorTopHeader,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
            child: Hero(
              tag: "GCFD_Logo",
              child: Image(
                image: AssetImage('assets/images/GCFD_Logo.jpg'),
              ),
            ),
          ),
          RaisedButton(
            color: Colors.yellow,
            child: Text("Generate 50 random Appointments",
                style: ColorDefs.textBodyBlack10),
            onPressed: () {
              Provider.of<ListCalendarData>(context, listen: false)
                  .generateAppointments(50);
            },
          ),
          RaisedButton(
            color: Colors.red,
            child: Text("DELETE ALL", style: ColorDefs.textBodyBlack10),
            onPressed: () {
              Provider.of<ListCalendarData>(context, listen: false)
                  .deleteAllAppointments();
            },
          ),
          RaisedButton(
              color: Colors.blue,
              child: Text("Version"),
              onPressed: () {
                Dialogs.showVersionDialog(context);
              }),
          RaisedButton(
              color: Colors.blue,
              child: Text("Developer"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => DeveloperMenu()),
                );
              }),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
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
                            color: ColorDefs.colorDarkBackground, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
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
                      "Sarah Connor",
                      style: ColorDefs.textBodyBlack20,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    // end of top white bar
  }
}
