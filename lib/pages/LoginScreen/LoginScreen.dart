import 'package:flutter/material.dart';
import 'package:gcfdlayout/Definitions/colorDefs.dart';
import 'LoginForm.dart';

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
                child: LoginForm(),
              )),
        ),
      ]),
    );
  }
}

// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;
//   final myController = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     myController.dispose();
//     super.dispose();
//   }
