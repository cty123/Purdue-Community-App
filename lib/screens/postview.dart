import 'package:flutter/material.dart';
import 'package:hello_world/components/postItem.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/models/comment.dart';
import 'package:loadmore/loadmore.dart';
import 'package:hello_world/utils/post_utils.dart';

class PostListPage extends StatefulWidget {
  PostListPage({Key key}) : super(key: key);

  @override
  _PostListPage createState() => new _PostListPage();
}

class _PostListPage extends State<PostListPage>{
  static List<Post> _posts = new List();

  // Add post to the post list
  void _addPost() {
    User u1 = new User('u1', 'email1');

    Comment c1 = new Comment(u1, 'Comments');

    Post p = new Post('title', 'content', 'avatar_url', ['url1'], u1, [c1]);

    if (this.mounted){
      setState(() {
        _posts.add(p);
      });
    }
  }

  Future<Null> _refreshList() async{
    try {
      List<Post> _newPosts = await PostUtils.pullPosts();

      print(_newPosts);

      if (this.mounted){
        setState(() {
          _newPosts.addAll(_posts);
          _posts = _newPosts;
        });
      }

    }catch(e) {
      // Show error messagebox
      print(e);
    } 

    return null;
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    _addPost();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Post'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.control_point),
            onPressed: _addPost,
          ),
        ]
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: _refreshList,
          child: LoadMore(
            onLoadMore: _loadMore,
            whenEmptyLoad: false,
            textBuilder: DefaultLoadMoreTextBuilder.english,
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return PostItem(_posts[index]);
              },
            ),
          ),
        )
      )
    );
  }
}