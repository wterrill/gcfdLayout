import 'package:flutter/material.dart';
import 'colorDefs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Container(color: ColorDefs.colorDarkBackground),
      ),
    );
  }
}
