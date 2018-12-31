import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPage createState() => _ImagePickerPage();
}

class _ImagePickerPage extends State<ImagePickerPage> {
  File _image;

  Future takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future selectPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text('Select a image file'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: _image == null ? 
              Text('No image selected') : new Image.file(_image),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new RaisedButton(
              onPressed: selectPhoto,
              child: new Text('Select a photo'),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(8.0),
            child: new RaisedButton(
              onPressed: takePhoto,
              child: new Text('Take a photo'),
            ),
          ),
        ],
      ),
    );
  }
}
