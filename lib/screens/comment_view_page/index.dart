import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/models/comment.dart';
import 'package:hello_world/components/commentitem.dart';
import 'package:hello_world/utils/comment_util.dart';

class CommentPage extends StatefulWidget {
  final Post post;

  CommentPage(this.post);

  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  // Define displaying comment list
  List<Comment> _commentList = new List();

  // Set page to default 1
  int page = 1;

  @override
  void initState() {
    super.initState();

    // Call _refreshList 
    _refreshList();
  }

  Future<Null> _refreshList() async{
    List<Comment> result = await CommentUtils.fetchComments(widget.post.id, page);
    
    if (this.mounted){
      setState(() {
        _commentList = new List();
        _commentList.addAll(result);
        page = 1;
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
          onRefresh: _refreshList,
          child: ListView.builder(
            itemCount: _commentList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return CommentItem(_commentList[index]);
            },
          )
        ),
      )
    );
  }
}