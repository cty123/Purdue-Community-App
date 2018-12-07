import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/screens/login.dart';

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
      },
      home: new LoginPage(),
    );
  }
}