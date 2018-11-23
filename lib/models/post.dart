import 'package:hello_world/models/user.dart';
import 'package:hello_world/models/comment.dart';

class Post {
  String title;
  String content;
  String avatar_url;
  List<String> image_urls;
  User user;
  List<Comment> comments;

  Post(this.title, this.content, this.avatar_url, this.image_urls, this.user, this.comments);
}