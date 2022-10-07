import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Http.dart';
import 'package:lemondes/Functions/Local.dart';

import '../Pages/Items.dart';

// String link = "http://localhost/le";
String link = "https://lemondes.iq";

Http https = Http();
LocalData? local;

// Navigator Push
void push(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
  );
}

snakBar(text, status, context, {Function? action, second}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: second ?? 5),
      content: Text(
        text,
        style: TextStyle(
          color: status ? Colors.black : Colors.white,
        ),
      ),
      action: action == null
          ? null
          : SnackBarAction(
              label: "GO",
              onPressed: () => action(),
            ),
      backgroundColor: status ? Colors.green[200] : Colors.red[400],
    ),
  );
}

void foregroundMessage(context) {
  FirebaseMessaging.onMessage.listen((event) {
    snakBar(event.notification!.body, true, context, action: () {
      push(context, Items(order: event.data["order"]));
    });
  });
}

void openMessage(context) {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    push(context, Items(order: event.data["order"]));
  });
}

void backgroundMessage(context) {
  FirebaseMessaging.instance.getInitialMessage().then((event) {
    if (event != null) {
      push(context, Items(order: event.data["order"]));
    }
  });
}

iosPrecession() async {
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
