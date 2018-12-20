import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthUtils {

  // Keys to store and fetch data from SharedPreferences
  static final String authTokenKey = 'auth_token';
  static final String userIdKey = 'user_id';
  static final String nameKey = 'name';
  static final String passKey = 'pass';

  // Stores the authentication token
  static String authToken;
  static String username;
  static String password; 

  static insertDetails(SharedPreferences prefs, var response, String username, String password) {
    // Get user object
    var user = response['user'];
    // Set auth token
    prefs.setString(authTokenKey, user['token']);
    // Set user_id
    prefs.setString(userIdKey, user['_id']);
    // Set username
    prefs.setString(nameKey, username);
    // Set password
    prefs.setString(passKey, password);
  }

  static logoff(SharedPreferences prefs) {
    prefs.clear();
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
    var url = "http://66.253.159.146:3000/users/login";
    try {
      http.Response res = await http.post(url, body: {"username": username, "password": password});
      return json.decode(res.body);
    }catch (e) {
      print(e);
    }
  } 

  /*
  * Restore the login status from local storage
  */
  static restoreLoginStatus(SharedPreferences prefs) async {
    // Get authToken
    authToken = prefs.getString(authTokenKey);

    // Restore username and password from local storage
    username = prefs.getString(nameKey);
    password = prefs.getString(passKey);

    // Get response data
    var res = await login(username, password);

    try { 
      // Check if the login status is successful
      if (res['status'] == "Success") {
        return true;
      }
    }catch(e) {
      print(e);
      return false;
    }

    return false;
  }
}