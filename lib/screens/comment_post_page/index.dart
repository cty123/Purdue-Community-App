import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/utils/comment_util.dart';
import 'package:hello_world/components/dialog.dart';

class PostCommentPage extends StatefulWidget {
  // Targetting post
  final Post _post;
  
  // Constructor
  PostCommentPage(this._post);

  _PostCommentPage createState() => _PostCommentPage();
}

class _PostCommentPage extends State<PostCommentPage> {
  final GlobalKey<ScaffoldState> _scaffordKey = new GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Comment Posted'));

  // Corresponding text controller
  TextEditingController _controller;

  // Getter
  String get content => _controller.text;

  @override
  void initState() {
    super.initState();

    // Initialize text controller
    _controller = new TextEditingController();
  }

  // Button Action
  Future<Null> _onSubmit() async {
    try {
      // Get result boolean value
      bool res = await CommentUtils.postComments(widget._post.id, content);

      // Check if the post is created successfully
      if (res) {
        // Display snackbar
        _scaffordKey.currentState.showSnackBar(snackBar);

        // Wait for 500 ms
        await new Future.delayed(const Duration(milliseconds: 500));
        
        // Pop to return to the main page
        Navigator.of(context).pop();
      } else {
        // Display error message
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return new ErrorDialog(
                  "Failed", "Comment creation failed for unknown reason");
            });
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new ErrorDialog("Failed", 'Error: $e');
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (
      new Scaffold(
        key: _scaffordKey,
        appBar: new AppBar(
          title: new Text('Add Comment'),
        ),
        body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            new Card(
              child: new TextField(controller: _controller, 
                decoration: new InputDecoration(hintText: 'Enter Comment',
                  contentPadding: const EdgeInsets.all(8.0)
                ), 
                maxLines: 20,
              ),
            ),
            new RaisedButton(onPressed: _onSubmit, child: new Text('Submit'),)
          ],
        ),
        ),
      )
    );
  }
}