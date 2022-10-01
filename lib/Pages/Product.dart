import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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
        bottomNavigationBar: ColoredBox(
          color: Theme.of(context).colorScheme.secondary,
          child: ElevatedButton(
            onPressed: () {
              addToCart(item);
              snakBar("Item Added To Cart", true, context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Add To Cart", style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.add_shopping_cart_rounded, size: 20),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              collapsedHeight: 200,
              flexibleSpace: Hero(
                  tag: item["id"],
                  child: CachedNetworkImage(
                    placeholder: (context, i) => const Loading(),
                    imageUrl: "$link/uploads/${item["img"]}",
                    fit: BoxFit.contain,
                  )),
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
                        Text(
                          "\$${item["price"]}",
                          style: const TextStyle(fontSize: 18),
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
                    child: Text(item["detail"], style: const TextStyle(fontSize: 18)),
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
