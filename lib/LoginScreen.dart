import 'package:flutter/material.dart';
import 'package:gcfdlayout/SchedulingPage5.dart';
import 'colorDefs.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key key}) : super(key: key);

// }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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
                      Text("Sign in to GCFD", style: ColorDefs.textBodyBlack30),
                      Container(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          style: ColorDefs.textBodyBlack20,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorDefs.colorLoginBackground,
                            labelText: 'Username',
                            labelStyle: ColorDefs.textBodyBlack20,
                          ),
                        ),
                      ),
                      Container(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          obscureText: _obscureText,
                          style: ColorDefs.textBodyBlack20,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                ;
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                                print(_obscureText);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                child: _obscureText
                                    ? Icon(Icons.visibility,
                                        color: ColorDefs.colorDarkBackground)
                                    : Icon(Icons.visibility_off,
                                        color: ColorDefs.colorDarkBackground),
                              ),
                            ),
                            filled: true,
                            fillColor: ColorDefs.colorLoginBackground,
                            labelText: 'Password',
                            labelStyle: ColorDefs.textBodyBlack20,
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
                                style: ColorDefs.textBodyBlack10),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 10.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: _obscureText
                                  ? ColorDefs.colorUserAccent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                  width: 2.0,
                                  color: _obscureText
                                      ? Colors.transparent
                                      : Colors.grey)),
                          child: FlatButton(
                            disabledTextColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            onPressed: _obscureText
                                ? () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder<void>(
                                            transitionDuration:
                                                Duration(seconds: 2),
                                            pageBuilder: (_, __, ___) =>
                                                SchedulingPage5()));
                                  }
                                : null,
                            child: Text('Log in',
                                style: _obscureText
                                    ? ColorDefs.textBodyBlack20
                                    : ColorDefs.textBodyGrey20),
                          ),
                        ),
                        // child: ListTile(
                        //   title: OutlineButton(

                        //       borderSide: BorderSide(
                        //           width: _obscureText? 0.0 : 8.0,
                        //           color: ColorDefs.colorTopDrawerBackground),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               new BorderRadius.circular(50.0)),
                        //       child: Text("Log in",
                        //           style: ColorDefs.textBodyBlack10),
                        // onPressed: _obscureText
                        //     ? null
                        //     : () {
                        //         Navigator.push(
                        //             context,
                        //             PageRouteBuilder<void>(
                        //                 transitionDuration:
                        //                     Duration(seconds: 2),
                        //                 pageBuilder: (_, __, ___) =>
                        //                     SchedulingPage5()));
                        //       }),
                        // ),
                      )
                    ])),
              )),
        ),
      ]),
    );
  }
}
