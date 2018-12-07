import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthUtils {
  static final String endPoint = '/api/v1/auth_user';

  // Keys to store and fetch data from SharedPreferences
  static final String authTokenKey = 'auth_token';
  static final String userIdKey = 'user_id';
  static final String nameKey = 'name';
  static final String roleKey = 'role';

  static String getToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  static insertDetails(SharedPreferences prefs, var response) {
    prefs.setString(authTokenKey, response['auth_token']);
    var user = response['user'];
    prefs.setInt(userIdKey, user['id']);
    prefs.setString(nameKey, user['name']);
  }

  static register(String username, String password, String email) async {
    var url = "http://66.253.159.146:3000/users/register";
    try {
      http.Response res = await http.post(url, body: {"username": username, "password": password, "email": email});
      return json.decode(res.body);
    }catch (e) {
      print(e);
    }
  }

  static login(String username, String password) async {
    var url = "http://66.253.159.146:3000/users/register";
    try {
      http.Response res = await http.post(url, body: {"username": username, "password": password});
      return json.decode(res.body);
    }catch (e) {
      print(e);
    }
  } 
}
