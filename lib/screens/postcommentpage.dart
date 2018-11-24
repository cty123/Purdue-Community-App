import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'dart:convert';

class PostCommentPage extends StatelessWidget {
  final Post _post;

  static final TextEditingController _controller = new TextEditingController();

  PostCommentPage(this._post);

  String get content => _controller.text;

  void _onSubmit() {
    print(json.encode(content));
  }

  @override
  Widget build(BuildContext context) {
    return (
      new Scaffold(
        appBar: new AppBar(
          title: new Text('Add Comment'),
        ),
        body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            new Card(
              child: new TextField(controller: _controller, 
                decoration: new InputDecoration(hintText: 'Enter Comment',
                  contentPadding: const EdgeInsets.all(8.0)
                ), 
                maxLines: 20,
              ),
            ),
            new RaisedButton(onPressed: _onSubmit, child: new Text('Submit'),)
          ],
        ),
        ),
      )
    );
  }
}