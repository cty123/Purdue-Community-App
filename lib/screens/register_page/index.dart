import 'package:flutter/material.dart';
import 'package:hello_world/utils/auth_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => new _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  TextEditingController _user, _pass, _passConfirm, _email;
  String get username => _user.text;
  String get email => _email.text;
  String get password => _pass.text;
  String get passwordConfirm => _passConfirm.text;

  _processSignUp() async {
    final response = await AuthUtils.register(username, password, email);
    if (response['status'] == "Success") {
      AuthUtils.insertDetails(_sharedPreferences, response);
      Navigator.of(context).pushReplacementNamed('Home');
    } else {
      print(response);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Failed"),
              content: new Text(response['message']),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  _initPrefs() async {
    _sharedPreferences = await _prefs;
  }

  _toSignIn() {
    Navigator.of(context).pushReplacementNamed('Signin');
  }

  @override
  void initState() {
    super.initState();

    // Initialize preference settings
    _initPrefs();

    // Initialize username and password field controllers
    _user = new TextEditingController();
    _email = new TextEditingController();
    _pass = new TextEditingController();
    _passConfirm = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sign up'),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new TextField(
              controller: _user,
              decoration: new InputDecoration(hintText: 'Enter a username'),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new TextField(
              controller: _email,
              decoration: new InputDecoration(hintText: 'Enter a email'),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new TextField(
              controller: _pass,
              decoration: new InputDecoration(hintText: 'Enter a password'),
              obscureText: true,
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new TextField(
              controller: _passConfirm,
              decoration: new InputDecoration(hintText: 'Enter a password'),
              obscureText: true,
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new RaisedButton(
              onPressed: () {
                _processSignUp();
              },
              child: new Text('Sign Up'),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new RaisedButton(
              onPressed: () {
                _toSignIn();
              },
              child: new Text('Sign In'),
            ),
          ),
        ],
      ),
    );
  }
}
