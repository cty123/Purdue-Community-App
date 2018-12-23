import 'package:flutter/material.dart';
import 'package:hello_world/utils/post_utils.dart';
import 'package:hello_world/components/dialog.dart';
import 'package:hello_world/models/post.dart';

class EditPost extends StatefulWidget {
  final Post _post; 

  EditPost(this._post);

  // Create state object
  _EditPost createState() => _EditPost();
}

class _EditPost extends State<EditPost> {
   // Define text controllers
  TextEditingController _titleController;
  TextEditingController _contentController;

  // Define strings to get controller texts
  String get title => _titleController.text;
  String get content => _contentController.text;

  @override
  void initState() {
    super.initState();

    // Initialize text controller
    _titleController = new TextEditingController();
    _titleController.text = widget._post.title;
    _contentController = new TextEditingController();
    _contentController.text = widget._post.content;
  }

  void _onSubmit() async {
    try {
      // Get result boolean value
      bool res = await PostUtils.updatePost(title, content, widget._post.id);

      // Check if the post is created successfully
      if (res) {
        // Update the data
        widget._post.title = title;
        widget._post.content = content;

        // Pop to return to the main page
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        // Display error message
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return new ErrorDialog(
                  "Failed", "Make sure you are authorized to do so or the post might be deleted");
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
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Edit'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            new Card(
              child: new TextField(
                controller: _titleController,
                decoration: new InputDecoration(
                    hintText: 'Title goes here',
                    contentPadding: const EdgeInsets.all(8.0)),
                maxLines: 1,
              ),
            ),
            new Card(
              child: new TextField(
                controller: _contentController,
                decoration: new InputDecoration(
                    hintText: 'Content goes here',
                    contentPadding: const EdgeInsets.all(8.0)),
                maxLines: 20,
              ),
            ),
            new RaisedButton(
              onPressed: () {
                _onSubmit();
              },
              child: new Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}