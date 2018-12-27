import 'package:flutter/material.dart';
import 'package:hello_world/utils/post_utils.dart';
import 'package:hello_world/components/dialog.dart';
import 'dart:io';

class NewPost extends StatefulWidget {
  // Create state object
  _NewPost createState() => _NewPost();
}

class _NewPost extends State<NewPost> {
  List<File> imageFiles;

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
    _contentController = new TextEditingController();

    imageFiles = new List();
    imageFiles.add(new File(""));
    imageFiles.add(new File(""));
  }

  List<Widget> _buildImageBar() {
    List<Widget> imgBar = new List();

    // Build widget
    for (var f in imageFiles) {
      Widget w = new Image.asset('assets/images/icons8-plus-50.png');
      imgBar.add(w);
    }

    return imgBar;
  }

  void _onSubmit() async {
    try {
      // Get result boolean value
      bool res = await PostUtils.createNewPost(title, content);

      // Check if the post is created successfully
      if (res) {
        // Pop to return to the main page
        Navigator.of(context).pop();
      } else {
        // Display error message
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return new ErrorDialog(
                  "Failed", "Post creation failed for unknown reason");
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

  void _addImage() {

    setState(() {
      imageFiles.add(new File(""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            new Text('New Post'),
          ],
        ),
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
            new Row(
              children: _buildImageBar()
            ),
            new RaisedButton(
              onPressed: () {
                _addImage();
              },
              child: new Text('Add Images - (Up to 5)'),
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
