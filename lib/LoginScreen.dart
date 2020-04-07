import 'package:flutter/material.dart';
import 'package:gcfdlayout/SchedulingPage5.dart';
import 'colorDefs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            color: ColorDefs.colorTopHeader,
            child: Center(
                child: Hero(
              tag: "GCFD_Logo",
              child: Image(
                image: AssetImage('images/GCFD_Logo.jpg'),
              ),
            )),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
              color: ColorDefs.colorDarkBackground,
              child: Center(
                child: Container(
                    height: 380,
                    width: 300,
                    decoration: new BoxDecoration(
                      color: ColorDefs.colorTopHeader,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(height: 10),
                      Text("Sign in to GCFD", style: ColorDefs.textBodyText1),
                      Container(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorDefs.colorLoginBackground,
                            labelText: 'Username',
                            labelStyle: ColorDefs.textBodyText1,
                          ),
                        ),
                      ),
                      Container(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorDefs.colorLoginBackground,
                            labelText: 'Password',
                            labelStyle: ColorDefs.textBodyText1,
                          ),
                        ),
                      ),
                      Container(height: 3),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("I forgot my password",
                                style: ColorDefs.textBodyText1Small),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 10.0),
                        child: ListTile(
                          title: OutlineButton(
                              borderSide: BorderSide(
                                  width: 8.0,
                                  color: ColorDefs.colorTopDrawerBackground),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              child: Text("Log in",
                                  style: ColorDefs.textBodyText1),
                              onPressed: () {
                                // Navigate to the second screen using a named route.
                                // Navigator.pushNamed(context, '/calendar');

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SchedulingPage5()));

                                Navigator.push(
                                    context,
                                    PageRouteBuilder<void>(
                                        transitionDuration:
                                            Duration(seconds: 2),
                                        pageBuilder: (_, __, ___) =>
                                            SchedulingPage5()));
                              }),
                        ),
                      )
                    ])),
              )),
        ),
      ]),
    );
  }
}
