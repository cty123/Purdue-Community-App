import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/utils/auth_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatelessWidget {

  logoutButtonClicked(BuildContext context) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences _sharedPreferences = await _prefs;
    await AuthUtils.logoff(_sharedPreferences);
  }

  loginButtonClicked(BuildContext context) async {
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: RaisedButton(
              color: Colors.grey,
              child: Text("Login"),
              onPressed: () => loginButtonClicked(context),
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: RaisedButton(
              color: Colors.red,
              child: Text("Logout"),
              onPressed: () => loginButtonClicked(context),
            )
          )
        ],
      )
    );
  }
}
