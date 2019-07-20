import 'package:flutter/material.dart';
import 'package:hello_world/utils/post_utils.dart';
import 'package:hello_world/components/dialog.dart';
import 'dart:io';
import 'package:hello_world/screens/Post/posts/new_post_page/components/imagePicker.dart';

class NewPost extends StatefulWidget {
  // Create state object
  _NewPost createState() => _NewPost();
}

class _NewPost extends State<NewPost> {
  // Declear file array corresponding to the upload files
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

    // Initialize image file list
    imageFiles = new List();
  }

  List<Widget> _buildImageBar() {
    // Init imgBar list
    List<Widget> imgBar = new List();

    // Define size of each image 
    double imgSize = (MediaQuery.of(context).size.width) / 5;

    // Build widget
    for (var f in imageFiles) {
      Widget w = new Image.file(f, width: imgSize, height: imgSize);
      imgBar.add(w);
    }
    
    // Add the trailing add image icon
    imgBar.add(new Image.asset('assets/images/icons8-plus-50.png'));

    // Return built image widgets
    return imgBar;  
  }

  void _onSubmit() async {
    try {
      // Get result boolean value
      bool res = await PostUtils.createNewPost(title, content, imageFiles);

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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new ErrorDialog("Failed", 'Error: $e');
          }
        );
    }
  }

  // Add image function
  Future _addImage() async {
    // Redirect to image selection page and wait for return value
    var img = await Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new ImagePickerPage()));
    
    // Save the returned image to the image array
    if (img != null) {
      setState(() {
        imageFiles.add(img);
      });
    }

    // Debug
    print("Returning from image selection page, img: $img");
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
              onPressed: _addImage,
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
