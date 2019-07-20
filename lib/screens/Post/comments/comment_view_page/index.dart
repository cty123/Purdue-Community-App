import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/models/comment.dart';
import 'package:hello_world/screens/Post/comments/comment_view_page/commentitem.dart';
import 'package:hello_world/utils/comment_util.dart';
import 'package:loadmore/loadmore.dart';

class CommentPage extends StatefulWidget {
  final Post post;

  CommentPage(this.post);

  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  // Define displaying comment list
  List<Comment> _commentList = new List();
  // Set isFinished to false by default
  bool isFinished = false;

  // Set page to default 1
  int page = 1;

  @override
  void initState() {
    super.initState();

    // Call _refreshList 
    _refreshList();
  }

  Future<Null> _refreshList() async{
    // Reset page to 1
    page = 1;

    // Obtain teh result from util function
    List<Comment> result = await CommentUtils.fetchComments(widget.post.id, page);

    // Only update the list when the page is mounted
    if (this.mounted){
      setState(() {
        _commentList = result;
      });
    }

    isFinished = false;

    return null;
  }


  Future<bool> _loadMore() async {
    try {
      // Increment page by 1
      page += 1;

      // Get more posts
      List<Comment> _newComments = await CommentUtils.fetchComments(widget.post.id, page);

      if (_newComments.length == 0) {
        isFinished = true;
      }

      // Setstate
      if (this.mounted) {
        setState(() {
          _commentList.addAll(_newComments);
        });
      }
    } catch (e) {
      // Show error messagebox
      print(e);
      return false;
    }

    return true;
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
          child: LoadMore(
            isFinish: isFinished,
            onLoadMore: _loadMore,
            whenEmptyLoad: false,
            textBuilder: DefaultLoadMoreTextBuilder.english,
            child: ListView.builder(
              itemCount: _commentList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return CommentItem(_commentList[index]);
              },
            ),
          ),
        ),
      )
    );
  }
}