import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/comment.dart';

class CommentPage extends StatefulWidget {
  final Post post;

  CommentPage(this.post);

  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {

  List<Comment> _comment_list;

  @override
  void initState() {
    super.initState();
    _comment_list = new List();
  }

  Widget build(BuildContext context){
    return (
      new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Comment Section'
          ),
        ),
        body: new ListView(
          
        ),
      )
    );
  }
}