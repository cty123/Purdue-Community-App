import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';

class PostEditPage extends StatelessWidget {
  final Post post;

  final TextEditingController _controller = new TextEditingController();

  PostEditPage(this.post);

  void onSave() {

  }

  Widget build(BuildContext context) {
    return (new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.assignment_turned_in),
            onPressed: onSave,
          ),
        ],
      ),
      body: new Card(
        child: new TextField(
          controller: _controller,
          decoration: new InputDecoration(
              hintText: 'Enter Comment',
              contentPadding: const EdgeInsets.all(8.0)),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          enabled: true,
        ),
      ),
    ));
  }
}
