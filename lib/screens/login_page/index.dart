import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/utils/auth_utils.dart';
import 'package:hello_world/components/dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Declare text input controller
  TextEditingController _user, _pass;

  // Initialize local storage
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Declare local preference setting
  SharedPreferences _sharedPreferences;

  // Bind strings to test inpute controller
  String get username => _user.text;
  String get password => _pass.text;

  @override
  void initState() {
    // Call super method
    super.initState();

    // Check async function to retrieve login status
    _restoreLoginStatus();

    // Initialize username and password field controllers
    _user = new TextEditingController();
    _pass = new TextEditingController();
  }

  _restoreLoginStatus() async {
    // Initialize shared preference
    _sharedPreferences = await _prefs;

    // Restore login status from local storage and verify login status
    bool isLoggedIn = await AuthUtils.restoreLoginStatus(_sharedPreferences);

    //Check status with authToken
    if (isLoggedIn) {
      print("Loging Page: AuthToken: Read: ${AuthUtils.authToken}");

      // Redirect the user to "Home" page
      Navigator.of(context).pushReplacementNamed('Home');
    }
  }

  _onSubmit() async {
    // Wait for login API to respond
    final response = await AuthUtils.login(username, password);

    // Check request status
    if (response['status'] == "Success") {
      print("Logging Successful: Response: ${response}");

      // Wait for localstorage to store user data
      await AuthUtils.insertDetails(_sharedPreferences, response, username, password);

      // Redirect user to home page
      Navigator.of(context).pushReplacementNamed('Home');
    } else {
      // Print out response data
      print(response);

      // Show dialog that says the issues the user is encountering
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new ErrorDialog("Failed", response['message']);
          });
    }
  }

  _toSignUp() {
    // Regirect user to "Signup" page
    Navigator.of(context).pushReplacementNamed('Signup');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sign In'),
      ),
      body: new ListView(
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
              controller: _pass,
              decoration: new InputDecoration(hintText: 'Enter a password'),
              obscureText: true,
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new RaisedButton(
              onPressed: () {
                _onSubmit();
              },
              child: new Text('Sign In'),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new RaisedButton(
              onPressed: () {
                _toSignUp();
              },
              child: new Text('Sign Up'),
            ),
          )
        ],
      ),
    );
  }
}
