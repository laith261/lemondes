import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  SharedPreferences prefs;
  LocalData(this.prefs);

  // get data from local storage
  Future<String?> get(String name) async => prefs.getString(name);

  // get user data from local storage
  Future<Map?> getUser() async {
    var data = prefs.getString("user");
    return data == null ? null : jsonDecode(data);
  }

  // set data from local storage
  Future<void> set(String name, String content) async {
    prefs.setString(name, content);
  }

  //delete local data
  Future<void> delete(String name) async {
    prefs.remove(name);
  }

  // ceck if user login
  Future<bool> userCheck(Function login) async {
    bool t = false;
    await getUser().then((value) {
      if (value != null) {
        login(value);
        t = true;
      }
    });
    return t;
  }
}
