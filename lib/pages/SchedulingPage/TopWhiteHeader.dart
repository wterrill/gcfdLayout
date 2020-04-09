import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/colorDefs.dart';

class TopWhiteHeader extends StatelessWidget {
  const TopWhiteHeader({Key key}) : super(key: key);

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
                image: AssetImage('images/GCFD_Logo.jpg'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 5.0, 0.0, 5.0),
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
