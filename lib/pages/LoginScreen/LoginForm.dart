import 'package:flutter/material.dart';
import 'package:gcfdlayout/Definitions/colorDefs.dart';
import 'package:gcfdlayout/pages/SchedulingPage/SchedulingPage.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String _username, _password;
  bool _dirtyUsername = false;
  bool _dirtyPassword = false;
  bool _enabledLoginButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorDefs.colorTopHeader,
      // height: 380,
      // width: 300,
      // decoration: new BoxDecoration(
      //   color: ColorDefs.colorTopHeader,
      //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
      // ),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(height: 10),
          Text("Sign in to GCFD", style: ColorDefs.textBodyBlack30),
          Container(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              onChanged: (input) =>
                  _onChangeField(input: input, from: "username"),
              validator: (input) => !input.contains('@')
                  ? "make sure your username has a '@'"
                  : null,
              onSaved: (input) => _username = input,
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
              onChanged: (input) =>
                  _onChangeField(input: input, from: "password"),
              validator: (input) => input.length < 6
                  ? "your password requires at least 6 characters"
                  : null,
              onSaved: (input) => _password = input,
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
                    padding: const EdgeInsetsDirectional.only(end: 12.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("I forgot my password",
                    style: ColorDefs.textBodyBlack10),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 10.0),
            child: ListTile(
              title: DecoratedBox(
                decoration: BoxDecoration(
                    color: _enabledLoginButton
                        ? ColorDefs.colorUserAccent
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                        width: 2.0,
                        color: _enabledLoginButton
                            ? Colors.transparent
                            : Colors.grey)),
                child: FlatButton(
                  disabledTextColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  onPressed: _enabledLoginButton ? _submit : null,
                  child: Text('Log in',
                      style: _enabledLoginButton
                          ? ColorDefs.textBodyBlack20
                          : ColorDefs.textBodyGrey20),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_username);
      print(_password);
      Navigator.push(
          context,
          PageRouteBuilder<void>(
              transitionDuration: Duration(seconds: 2),
              pageBuilder: (_, __, ___) => SchedulingPage()));
    }
  }

  void _onChangeField({@required String input, @required String from}) {
    if (from == "username") if (input.length > 3) {
      _dirtyUsername = true;
    } else {
      _dirtyUsername = false;
    }

    if (from == "password") if (input.length > 3) {
      _dirtyPassword = true;
    } else {
      _dirtyPassword = false;
    }

    bool bothDirtyAndNotEnabled =
        _dirtyUsername && _dirtyPassword && !_enabledLoginButton;
    bool enabledButOnlyOneIsDirty =
        _enabledLoginButton && (!_dirtyUsername || !_dirtyPassword);
    if (bothDirtyAndNotEnabled) {
      setState(() {
        _enabledLoginButton = true;
      });
    }
    if (enabledButOnlyOneIsDirty) {
      setState(() {
        _enabledLoginButton = false;
      });
    }
  }
}
