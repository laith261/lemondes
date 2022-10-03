import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Functions.dart';

class Http {
  Http();

  // http post
  Future<String> post({Map<String, String>? data}) async {
    var url = Uri.parse("$link/appapi.php");
    var response = await http.post(
      url,
      body: data,
    );
    return response.body;
  }

  // http get
  Future<String> get({Map? query}) async {
    String que = query == null ? "" : "?${replace(query.toString())}";
    var url = Uri.parse("$link/appapi.php$que");
    var response = await http.get(
      url,
    );
    return response.body;
  }

  Future<Map<String, dynamic>> getMap(Map<String, String> map,
          {Map? query}) async =>
      await get(query: query).then((value) => jsonDecode(value));

  Future<Map<String, dynamic>> postMap(Map<String, String>? data) async =>
      await post(data: data).then((value) => jsonDecode(value));

  String replace(String word) {
    word = word.replaceAll(RegExp(r' '), '');
    word = word.replaceAll(RegExp(r':'), '=');
    word = word.replaceAll(RegExp(r','), '&');
    word = word.replaceAll(RegExp(r'{'), '');
    word = word.replaceAll(RegExp(r'}'), '');
    return word;
  }
}
