import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:zefyr/zefyr.dart';
import 'package:hello_world/screens/posteditpage.dart';
import 'package:hello_world/screens/postcommentpage.dart';
import 'package:hello_world/components/postdetail.dart';
import 'package:hello_world/components/popmenuitem.dart';
import 'dart:convert';

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
  ZefyrController _controller;
  FocusNode _focusNode;
  NotusDocument _document;

  @override
  void initState() {
    super.initState();
    // Create an empty document or load existing if you have one.
    // Here we create an empty document:
    _document = new NotusDocument();
    _controller = new ZefyrController(_document);
    _focusNode = new FocusNode();
  }

  void _menu_action(PopMenuItem item) {
    switch(item.text) {
      case 'Add Comment':
        Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (ctx) => new PostCommentPage(widget.post)
              )
            );
        break;
      case 'Edit':
        Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (ctx) => new PostEditPage(widget.post)
              )
            );
        break;
      case 'View Comment': 
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Row(children: <Widget>[
          new Text('Author: ${widget.post.user.username}'),
          // new IconButton(
          //   icon: Icon(Icons.touch_app),
          //   onPressed: (){
          //     var data = json.decode(json.encode(_controller.document.toJson()));
          //     NotusDocument nd = new NotusDocument.fromJson(data);
          //     print(nd.toString());
          //     setState(() {
          //       _controller = new ZefyrController(nd);           
          //     });
          //   },
          // )
        ],),
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
              }
            ),
        ]
      ),

      body: new Card(
        child: ZefyrScaffold(
          child: ZefyrEditor(
            enabled: true,
            controller: _controller,
            focusNode: _focusNode,
          ),
        )
      )
    );
  }
}