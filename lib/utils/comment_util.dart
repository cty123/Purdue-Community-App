import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_world/models/comment.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/utils/auth_utils.dart';
import 'package:intl/intl.dart';

class CommentUtils {

  // Fetch comments from the server
  static fetchComments(String post_id, int page) async {
    var url = "http://66.253.159.146:3000/post/comment?post_id=${post_id}&page=${page}";
    
     // Wait for HTTP response
    http.Response res = await http.get(url,
        headers: {"Authorization": "Bearer " + AuthUtils.authToken});

    // Parse message body
    var res_obj = json.decode(res.body);

    /*
    * TODO: Error handling
    */

    // Get posts data
    var comments = res_obj['comments'];

    // Construct return postarray
    List<Comment> _newComments = [];

    for (var c in comments) {

      // Parse user object for the author of the post
      User u = new User(c['user']['username'], c['user']['email']);

      // Parse Date
      var date = DateTime.parse(c['date']);
      var strdate = new DateFormat.yMMMMd("en_US").format(date);

      // Parse post object
      Comment new_post = Comment(c['_id'], u, c['content'], strdate);

      // Add the post in the post array
      _newComments.add(new_post);
    }

    return _newComments;
  }
}