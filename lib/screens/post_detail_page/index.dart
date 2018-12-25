import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/screens/post_edit_page/index.dart';
import 'package:hello_world/screens/comment_post_page/index.dart';
import 'package:hello_world/screens/comment_view_page/index.dart';
import 'package:hello_world/components/popmenuitem.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  final List<PopMenuItem> _pop_options = [
    new PopMenuItem(Icon(Icons.add), 'Add Comment'),
    new PopMenuItem(Icon(Icons.edit), 'Edit'),
    new PopMenuItem(Icon(Icons.comment), 'View Comments')
  ];

  PostDetail(this.post);

  _PostDetail createState() => _PostDetail();
}

class _PostDetail extends State<PostDetail> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: '${widget.post.content}');
  }

  // Control menu action
  void _menu_action(PopMenuItem item) {
    switch (item.text) {
      case 'Add Comment':
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new PostCommentPage(widget.post)));
        break;
      case 'Edit':
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new EditPost(widget.post)));
        break;
      case 'View Comments':
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new CommentPage(widget.post)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Row(
              children: <Widget>[
                new Text('${widget.post.title}'),
              ],
            ),
            actions: <Widget>[
              new PopupMenuButton<PopMenuItem>(
                  icon: Icon(Icons.add), // overflow menu
                  onSelected: _menu_action,
                  itemBuilder: (BuildContext context) {
                    return widget._pop_options.map((PopMenuItem item) {
                      return PopupMenuItem<PopMenuItem>(
                        child: item,
                        value: item,
                      );
                    }).toList();
                  }),
            ]),
        body: new ListView(children: <Widget>[
          new Card(
            child: Column(
              children: <Widget>[
                new Container(
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 8.0, top: 8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg'),
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              '${widget.post.user.username}',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'RobotoMono',
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )),
                new TextField(
                  controller: _controller,
                  decoration: new InputDecoration(
                      hintText: 'Enter Comment',
                      contentPadding: const EdgeInsets.all(8.0)),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  enabled: false,
                ),
              ],
            ),
          )
        ]));
  }
}
