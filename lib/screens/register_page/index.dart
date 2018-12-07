import 'package:flutter/material.dart';
import 'package:hello_world/utils/auth_utils.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
	_RegisterPage createState() => new _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController _user, _pass, _passConfirm, _email;
  String get username => _user.text;
  String get email => _email.text;
  String get password => _pass.text;
  String get passwordConfirm => _passConfirm.text;

  _processSignUp() async {

    final response = await AuthUtils.register(username, password, email);
    if (response['status'] == "Success") {
      Navigator.of(context).pushReplacementNamed('Home');
    } else {
      print(response);
    }
  }

  _toSignIn() {
    Navigator.of(context).pushReplacementNamed('Signin');
  }

  @override
  void initState() {
    super.initState();

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
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(controller: _user, decoration: new InputDecoration(hintText: 'Enter a username'),),
            new TextField(controller: _email, decoration: new InputDecoration(hintText: 'Enter a email'),),
            new TextField(controller: _pass, decoration: new InputDecoration(hintText: 'Enter a password'), obscureText: true,),
            new TextField(controller: _passConfirm, decoration: new InputDecoration(hintText: 'Enter a password'), obscureText: true,),
            new RaisedButton(onPressed: (){_processSignUp();}, child: new Text('Sign Up'),),
            new RaisedButton(onPressed: (){_toSignIn();}, child: new Text('Sign In'),)
          ],
        ),
      ), 
    );
  } 
}