import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:zefyr/zefyr.dart';

class PostEditPage extends StatelessWidget {
  final Post post;

  PostEditPage(this.post);

  Widget build(BuildContext context) {
    return (
      new Scaffold(
        appBar: new AppBar(title: new Text('Edit'),),
        body: new Text('Edit page'),
      )
    );
  }
}