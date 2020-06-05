import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'LoginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
              flex: 1,
              child: Container(
                color: ColorDefs.colorTopHeader,
                child: Center(
                    child: Hero(
                  tag: "GCFD_Logo",
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/GCFD_Logo.jpg'),
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
        ),
      ),
    );
  }
}
