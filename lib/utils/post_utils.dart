import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_world/models/post.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/utils/auth_utils.dart';
import 'package:intl/intl.dart';
import 'package:hello_world/utils/configs.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class PostUtils {
  static int page = 0;

  static pullPosts() async {
    var url = "${Configs.baseUrl}/post";
    
    // Wait for HTTP response
    http.Response res = await http.get(url,
        headers: {"Authorization": "Bearer " + AuthUtils.authToken});

    // Parse message body
    var res_obj = json.decode(res.body);

    /*
    * TODO: Error handling
    */

    // Reset current page to max_page
    page = res_obj['page'];
    
    // Get posts data
    var posts = res_obj['posts'];

    // Construct return postarray
    List<Post> _newPosts = [];

    for (var p in posts) {

      // Parse user object for the author of the post
      User u = new User(p['user']['username'], p['user']['email']);

      // Parse Date
      var date = DateTime.parse(p['date']);
      var strdate = new DateFormat.yMMMMd("en_US").format(date);

      // Parse post object
      Post new_post = Post(p['_id'], p['title'], p['content'], 'avatar', ['url1'], u, p['comments'].length, strdate);

      // Add the post in the post array
      _newPosts.add(new_post);
    }

    return _newPosts;
  }

  static pullMore() async {
    // Construct return postarray
    List<Post> _newPosts = [];

    // Check if it's currently at the first page
    if (page <= 1) {
      return _newPosts;
    }

    // Decrement by 1
    page -= 1;

    var url = "${Configs.baseUrl}/post?page=${page}";
    
    // Wait for HTTP response
    http.Response res = await http.get(url,
        headers: {"Authorization": "Bearer " + AuthUtils.authToken});

    // Parse message body
    var res_obj = json.decode(res.body);

    // Get posts data
    var posts = res_obj['posts'];

    for (var p in posts) {

      // Parse user object for the author of the post
      User u = new User(p['user']['username'], p['user']['email']);

      // Parse Date
      var date = DateTime.parse(p['date']);
      var strdate = new DateFormat.yMMMMd("en_US").format(date);

      // Parse post object
      Post new_post = Post(p['_id'], p['title'], p['content'], 'avatar', ['url1'], u, p['comments'].length, strdate);

      // Add the post in the post array
      _newPosts.add(new_post);
    }

    return _newPosts;
  }

  static Future<bool> createNewPost(String title, String content, [List<File> imgs]) async {
    var url = "${Configs.baseUrl}";

    Options options = new Options(
      baseUrl: url,
      headers: {
        'Authorization': 'Bearer ${AuthUtils.authToken}'
      }
    );

    // Using dio for easy file upload operation
    Dio dio = new Dio(options);
    List<UploadFileInfo> upFiles = [];

    // Set up file upload list
    if (imgs != null) {
      for (var i = 0; i < imgs.length; i++) {
        upFiles.add(new UploadFileInfo(imgs[i], basename(imgs[i].path)));
      }
    }

    // Fillout the form data
    FormData formData = new FormData.from({
      "title": title,
      "content": content,
      "imgs": upFiles
    });

    // Http request
    var res = await dio.post('/post', data: formData);
    
    // Error handling
    if (res.data['status'] == 'Success') {
      return true;
    }

    return false;
  }

  static Future<bool> updatePost(String title, String content, String post_id) async {
    var url = "${Configs.baseUrl}/post/edit";
    
    // Http request
    http.Response res = await http.post(url, 
      body: {"post_id": post_id, "title": title, "content": content}, 
      headers: {"Authorization": 'Bearer ${AuthUtils.authToken}'});

    // Parse return JSON
    var res_obj = json.decode(res.body);
    
    // Error handling
    if (res_obj['status'] == 'Success') {
      return true;
    }

    return false;
  }
}
