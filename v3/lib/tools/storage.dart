import 'package:flutter_1800/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class StorageUtil {
  //Save user information to local storage
  static saveUser(Map map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", convert.jsonEncode(map));
  }

  //Clear all data from local storage
  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //Clear user information from local storage, but this feature is not used to ensure that users do not need to log in frequently
  static clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  //Retrieving user information from local storage
  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("user");
    if (userJson != null && userJson.isNotEmpty) {
      Map<String, dynamic> userMap = convert.jsonDecode(userJson);
      User user = User.fromMap(userMap);
      return user;
    }
    return null;
  }
}
