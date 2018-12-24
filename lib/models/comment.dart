import 'package:hello_world/models/user.dart';

class Comment {
  User user;
  String content;
  String id;
  String date;

  Comment(this.id, this.user, this.content, this.date);
}