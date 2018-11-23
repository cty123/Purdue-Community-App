import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:zefyr/zefyr.dart';
import 'package:hello_world/components/postdetail.dart';
import 'dart:convert';

class PostDetail extends StatefulWidget {
  final Post post;

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Row(children: <Widget>[
          new Text('${widget.post.title}'),
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
          IconButton(icon: Icon(Icons.control_point), onPressed: null,),
          IconButton(icon: Icon(Icons.edit), onPressed: null,),
          IconButton(icon: Icon(Icons.comment), onPressed: null,),
        ]
      ),

      body: ZefyrScaffold(
        child: new Card(
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