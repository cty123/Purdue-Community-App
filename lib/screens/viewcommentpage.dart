import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/models/comment.dart';
import 'package:hello_world/components/commentitem.dart';

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

    User u = new User('username', 'email', 'token');

    Comment c = new Comment(u, 'content');

    _comment_list = [c, c];
  }

  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 2));
    
    if (this.mounted){
      setState(() {
        _comment_list = new List();
      });
    }
    return null;
  }

  Widget build(BuildContext context){
    return (
      new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Comment Section'
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.builder(
            itemCount: _comment_list.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return CommentItem(_comment_list[index]);
            },
          )
        ),
      )
    );
  }
}