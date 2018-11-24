import 'package:flutter/material.dart';

class PopMenuItem extends StatelessWidget{
  final Icon icon;
  final String text; 

  PopMenuItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        new Container(
          child: new Text(text.toString()),
          padding: EdgeInsets.only(left: 8.0),
        )
      ],
    );
  }
}