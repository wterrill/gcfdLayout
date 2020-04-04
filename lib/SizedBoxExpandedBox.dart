import 'package:flutter/material.dart';

import 'colorDefs.dart';

class SizedBoxExpandedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffFFCE00),
                    Color(0xffE86F1C),
                  ],
                ),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.blue)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Container(
                      color: Colors
                          .blueAccent, //remove color to make it transpatrent
                      child: Center(child: Text("This is Sized Box"))),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent, //remove color?
                        border: Border.all(
                            style: BorderStyle.solid, color: colorTopHeader),
                      ),
                      child: Center(child: Text("This is Expanded"))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Center(child: Text("This is Sized Box")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
