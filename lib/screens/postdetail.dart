import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('${post.title}'),
      ),

      body: Text('${post.content}'),
    );
  }
}