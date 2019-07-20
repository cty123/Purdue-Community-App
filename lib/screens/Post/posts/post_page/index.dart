import 'package:flutter/material.dart';
import 'package:hello_world/screens/Post/posts/post_page/postItem.dart';
import 'package:hello_world/models/post.dart';
import 'package:loadmore/loadmore.dart';
import 'package:hello_world/utils/post_utils.dart';
import 'package:hello_world/components/popmenuitem.dart';
import 'package:hello_world/screens/Post/posts/new_post_page/index.dart';

class PostListPage extends StatefulWidget {
  PostListPage({Key key}) : super(key: key);

  final List<PopMenuItem> _popOptions = [
    new PopMenuItem(Icon(Icons.add), 'New Post'),
  ];

  @override
  _PostListPage createState() => new _PostListPage();
}

class _PostListPage extends State<PostListPage> {
  static List<Post> _posts = new List();
  static bool isFinished;

  @override
  void initState() {
    super.initState();
    isFinished = false;
  }

  void _menuAction(PopMenuItem item) {
    switch (item.text) {
      case 'New Post':
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (ctx) => new NewPost()));
        break;
    }
  }

  Future<Null> _refreshList() async {
    try {
      List<Post> _newPosts = await PostUtils.pullPosts();
      isFinished = false;
      if (this.mounted) {
        setState(() {
          _posts = new List();
          _posts.addAll(_newPosts.reversed);
        });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> _loadMore() async {
    try {
      List<Post> _newPosts = await PostUtils.pullMore();
      if (_newPosts.length == 0) {
        isFinished = true;
      }
      if (this.mounted) {
        setState(() {
          _posts.addAll(_newPosts.reversed);
        });
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Post'), 
        actions: <Widget>[
          PopupMenuButton<PopMenuItem>(
            icon: Icon(Icons.add),
            onSelected: _menuAction,
            itemBuilder: (BuildContext context) {
              return widget._popOptions.map((PopMenuItem item) {
                return PopupMenuItem<PopMenuItem>(
                  child: item,
                  value: item,
                );
              }).toList();
            }),
        ]),
        body: Center(
          child: RefreshIndicator(
            onRefresh: _refreshList,
            child: LoadMore(
              isFinish: isFinished,
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
        )));
  }
}
