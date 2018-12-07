import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/screens/login.dart';
import 'package:hello_world/screens/register_page/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: <String, WidgetBuilder>{
        'Home': (BuildContext context) => new Home(),
        'Signup': (BuildContext context) => new RegisterPage(),
        'Signin': (BuildContext context) => new LoginPage(),
      },
      home: new LoginPage(),
    );
  }
}