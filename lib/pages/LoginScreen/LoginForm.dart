import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:provider/provider.dart';
import 'package:auditor/providers/GeneralData.dart';

import 'package:flutter/foundation.dart';

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
  var _userController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: .2 * Provider.of<GeneralData>(context).mediaArea.width),
      color: ColorDefs.colorTopHeader,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(height: 20),
            AutoSizeText(
              "Sign in to GCFD",
              style: ColorDefs.textBodyBlack30,
              maxLines: 1,
              minFontSize: 5,
            ),
            Container(height: 70),
            Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 10),
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Username", style: ColorDefs.textBodyBlack20))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _userController,
                onChanged: (input) =>
                    _onChangeField(input: input, from: "username"),
                // validator: (input) => !input.contains('@')
                //     ? "make sure your username has a '@'"
                //     : null,
                onSaved: (input) => _username = input,
                style: ColorDefs.textBodyBlack20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorDefs.colorLoginBackground,
                  // labelText: 'Username',
                  labelStyle: ColorDefs.textBodyBlack20,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 40),
            Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 10),
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password", style: ColorDefs.textBodyBlack20))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _passwordController,
                onChanged: (input) =>
                    _onChangeField(input: input, from: "password"),
                validator: (input) => input.length < 1
                    ? "your password requires at least 6 characters"
                    : null,
                onSaved: (input) => _password = input,
                obscureText: _obscureText,
                style: ColorDefs.textBodyBlack20,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
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
                  // labelText: 'Password',
                  labelStyle: ColorDefs.textBodyBlack20,
                ),
              ),
            ),
            Container(height: 3),
            RaisedButton(
                onPressed: () {
                  setState(() {
                    _userController.text = "MXOTestAud1";
                    _passwordController.text = "Password1";
                    _enabledLoginButton = true;
                  });
                },
                child: Text("fast login")),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 10.0),
              child: ListTile(
                title: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 50.0),
                  child: DecoratedBox(
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
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: 56.0, maxWidth: 30.0),
                      child: FlatButton(
                        disabledTextColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        onPressed: _enabledLoginButton ? _submit : null,
                        child: Text('Log In',
                            style: _enabledLoginButton
                                ? ColorDefs.textBodyWhite30
                                : ColorDefs.textBodyGrey20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 20)
          ]),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_username);
      print(_password);
      Dialogs.showAlertDialog(context);
      bool isAuthenticated = false;
      bool isError = false;
      String errorString = "";
      try {
        isAuthenticated = await Authentication.authenticate(
            username: _username, password: _password);
      } catch (error) {
        print(error);
        isAuthenticated = false;
        isError = true;
        errorString = error.toString();
      }

      if (isAuthenticated) {
        Provider.of<GeneralData>(context, listen: false).username = _username;
        Navigator.push(
          context,
          PageRouteBuilder<void>(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (_, __, ___) => //StatsFl(
                ListSchedulingPage(),
            // ),
          ),
        );
      } else {
        Navigator.of(context).pop();
        if (!isError) {
          Dialogs.failedAuthentication(context);
        } else {
          Dialogs.failedAuthenticationWithError(context, errorString);
        }
      }
    }
  }

  void _onChangeField({@required String input, @required String from}) {
    if (input == "version") {
      Dialogs.showVersionDialog(context);
      return;
    }

    if (input == "developer") {
      Dialogs.showDeveloperMenu(context);
      return;
    }

    if (from == "username") if (input.length > 1) {
      _dirtyUsername = true;
    } else {
      _dirtyUsername = false;
    }

    if (from == "password") if (input.length > 1) {
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
