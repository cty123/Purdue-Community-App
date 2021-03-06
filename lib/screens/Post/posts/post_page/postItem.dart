import 'package:flutter/material.dart';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/screens/Post/posts/post_detail_page/index.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem(this.post);

  void _postDetail(BuildContext ctx) {
    Navigator.of(ctx)
        .push(new MaterialPageRoute(builder: (ctx) => new PostDetail(post)));
  }

  List<Widget> _buildImageBar(BuildContext context) {
    // Construct the list bar
    List<Widget> imgBar = new List();

    // Define size of each image
    double imgSize = (MediaQuery.of(context).size.width - 32) / 3;

    // Loop through the image list and the maximum loop count is 3
    int c = 0;
    while (c < post.image_urls.length && c < 3) {
      // Construct individual image square
      Container temp_c = new Container(
        padding: EdgeInsets.only(left: 8.0),
        width: imgSize,
        child: Image.network(post.image_urls[c], fit: BoxFit.cover),
      );

      // Add Image square to the widget list
      imgBar.add(temp_c);

      // Increment counter
      c++;
    }

    return imgBar;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: GestureDetector(
            onTap: () {
              _postDetail(context);
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
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
                            '${post.user.username}',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
                  Container(
                    padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      '${post.title}',
                      maxLines: 5,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      '${post.content}',
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${post.postDate}',
                            style: TextStyle(
                                fontSize: 12.0, fontStyle: FontStyle.italic),
                          ))),
                  Container(
                    padding: EdgeInsets.only(top: 8.0, right: 8.0),
                    height: 150,
                    child: Row(
                      children: _buildImageBar(context)
                    ),
                  ),
                  Container(
                      child: Row(children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 16.0, bottom: 8.0, right: 8.0),
                      child: Icon(Icons.comment),
                    ),
                    Text('${post.num_comments}'),
                    Text(' Comments'),
                  ]))
                ],
              ),
            )));
  }
}
