import 'package:hello_world/models/user.dart';
import 'package:hello_world/models/comment.dart';

class Post {
  String id;
  String title;
  String content;
  String avatar_url;
  List<String> image_urls;
  User user;
  int num_comments;
  String postDate;

  Post(this.id, this.title, this.content, this.avatar_url, this.image_urls, this.user, this.num_comments, this.postDate);
}