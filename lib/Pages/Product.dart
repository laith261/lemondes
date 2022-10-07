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
        appBar: AppBar(
          title: const Text("Product"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              collapsedHeight: 175,
              flexibleSpace: Center(
                child: Hero(
                  tag: item["id"],
                  child: ImageWidget(
                    img: item["img"],
                    size: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item["name"],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(item["detail"],
                        style: const TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            )
          ],
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
