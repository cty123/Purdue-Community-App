import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.title, this.message);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this.title),
      content: new Text(this.message),
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
  }
}
