import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purdue Community',
      home: new Home(),
    );
  }
}