import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/utils/auth_utils.dart';

class LoginPage extends StatefulWidget {

  @override
	_LoginPageState createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _user, _pass;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
	SharedPreferences _sharedPreferences;
  String get username => _user.text;
  String get password => _pass.text;

  @override
  void initState() {
    super.initState();
    // Check login status
    _onSubmit();

    // Initialize username and password field controllers
    _user = new TextEditingController();
    _pass = new TextEditingController();
  }

  _onSubmit() async {
    _sharedPreferences = await _prefs;

    String authToken = AuthUtils.getToken(_sharedPreferences);

		if(authToken != null) {
			Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed('Home');
		}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(controller: _user, decoration: new InputDecoration(hintText: 'Enter a username'),),
            new TextField(controller: _pass, decoration: new InputDecoration(hintText: 'Enter a password'), obscureText: true,),
            new RaisedButton(onPressed: (){ _onSubmit(); }, child: new Text('Submit'),)
          ],
        ),
      ),
    );
  } 
}