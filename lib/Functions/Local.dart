import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  SharedPreferences prefs;
  LocalData(this.prefs);

  // get data from local storage
  String? get(String name) => prefs.getString(name);

  // get user data from local storage
  Map? getUser() => get("user") == null ? null : jsonDecode(get("user")!);

  // set data from local storage
  void set(String name, String content) => prefs.setString(name, content);

  //delete local data
  void delete(String name) => prefs.remove(name);

  // check if user login
  bool userCheck(Function login) {
    if (getUser() != null) login(getUser());
    return getUser() != null;
  }
}
