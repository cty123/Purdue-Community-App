import 'package:flutter/material.dart';
import 'package:hello_world/models/comment.dart';

class CommentItem extends StatelessWidget {
  Comment _comment;

  CommentItem(this._comment);

  @override
  Widget build(BuildContext context) {
    return (new Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left:8.0, top: 8.0, bottom: 8.0),
            child: new Text(
              _comment.user.username,
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold),
            ),
          ),
          new TextField(
            controller: new TextEditingController(text: _comment.content),
            decoration: new InputDecoration(
                contentPadding: const EdgeInsets.all(8.0)),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            enabled: false,
          ),
          new Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 8.0),
            child:new Text('${_comment.date}',)
          )
        ],
      ),
    ));
  }
}
