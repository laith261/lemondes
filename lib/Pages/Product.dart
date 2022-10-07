import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';

import '../Widgets/for_all.dart';

class Product extends StatelessWidget {
  const Product({Key? key, required this.item}) : super(key: key);
  final Map item;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomButton(
          function: () {
            addToCart(item);
            snakBar("Item Added To Cart", true, context);
          },
          text: "Add To Cart:\$${item["price"]}",
        ),
        extendBody: true,
        appBar: AppBar(title: const Text("Product")),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Hero(
                  tag: item["id"] + "con",
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ImageWidget(
                      img: item["img"],
                      size: 400,
                    ),
                  ),
                ),
                Text(
                  item["name"],
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "\$${item["price"]}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(.70),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  item["detail"],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(.70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addToCart(Map item) {
    local!.get("cart").then((value) {
      Map data = value == null ? {} : jsonDecode(value);
      if (data.containsKey(item["id"])) {
        data[item["id"]]!["qun"]++;
      } else {
        data[item["id"]] = {
          "id": item["id"],
          "name": item["name"],
          "price": item["price"],
          "qun": 1,
          "img": item["img"],
          "detail": item["detail"],
          "store": item["store"],
        };
      }
      local!.set("cart", jsonEncode(data));
    });
  }
}
