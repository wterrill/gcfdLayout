import 'package:flutter/material.dart';

import 'colorDefs.dart';

class TopWhiteHeader extends StatelessWidget {
  const TopWhiteHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Top header (white)
      height: 50,
      color: colorTopHeader,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
            child: Image(
              image: AssetImage('images/GCFD_Logo.jpg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorUserAccent, width: 1.0),
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
                        border:
                            Border.all(color: colorDarkBackground, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Icon(
                        Icons.person,
                        color: colorDarkBackground,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Sarah Connor",
                      style: bodyText1,
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
