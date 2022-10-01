import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'Functions.dart';

class User extends ChangeNotifier {
  Map? user;

  Future<void> login(Map data) async {
    local?.set("user", jsonEncode(data));
    user = data;
    await FirebaseMessaging.instance.subscribeToTopic(data["uid"].toString().replaceAll("=", ""));
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(user!["uid"].toString().replaceAll("=", ""));
    local?.delete("user");
    user = null;
    notifyListeners();
  }
}
