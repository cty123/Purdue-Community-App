import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/utils/auth_utils.dart';

class PostUtils {
  static int page = 1;

  static pullPosts() async {
    var url = "http://66.253.159.146:3000/post";
    
    // Wait for HTTP response
    http.Response res = await http.get(url,
        headers: {"Authorization": "Bearer " + AuthUtils.authToken});

    // Parse message body
    var res_obj = json.decode(res.body);

    /*
    * TODO: Error handling
    */

    // Get posts data
    var posts = res_obj['posts'];

    // Construct return postarray
    List<Post> _newPosts = [];

    for (var p in posts) {

      // Parse user object for the author of the post
      User u = new User(p['user']['username'], p['user']['email']);

      // Parse post object
      Post new_post = Post(p['title'], p['content'], 'avatar', ['url1'], u, null);

      // Add the post in the post array
      _newPosts.add(new_post);
    }

    // Reset current page to 1
    page = 1;

    return _newPosts;
  }

  static pullMore() async {
    page += 1;
    
    var url = "http://66.253.159.146:3000/post?page=${page}";

    // Wait for HTTP response
    http.Response res = await http.get(url,
        headers: {"Authorization": "Bearer " + AuthUtils.authToken});

    // Parse message body
    var res_obj = json.decode(res.body);


    // Get posts data
    var posts = res_obj['posts'];

    // Construct return postarray
    List<Post> _newPosts = [];

    for (var p in posts) {

      // Parse user object for the author of the post
      User u = new User(p['user']['username'], p['user']['email']);

      // Parse post object
      Post new_post = Post(p['title'], p['content'], 'avatar', ['url1'], u, null);

      // Add the post in the post array
      _newPosts.add(new_post);
    }

    return _newPosts;
  }
}