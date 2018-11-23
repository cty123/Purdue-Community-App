import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Login extends StatelessWidget {
  void _onSubmit() {
    print("Login");
  }

  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;
  String get password => _pass.text;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(controller: _user, decoration: new InputDecoration(hintText: 'Enter a username'),),
            new TextField(controller: _pass, decoration: new InputDecoration(hintText: 'Enter a username'), obscureText: true,),
            new RaisedButton(onPressed: (){ _onSubmit(); }, child: new Text('Submit'),)
          ],
        ),
      ),
    );
  } 
}