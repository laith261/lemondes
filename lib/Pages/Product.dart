import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';

import '../Widgets/for_all.dart';

class Product extends StatefulWidget {
  const Product({Key? key, required this.item}) : super(key: key);
  final Map item;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: StatefulBuilder(
                builder: (context, set) {
                  return Count(
                    count: count,
                    increase: () => set(() => count += 1),
                    decrease: count == 1 ? null : () => set(() => count += -1),
                  );
                },
              ),
            ),
            Expanded(
              child: BottomButton(
                function: () {
                  addToCart(widget.item);
                  snakBar("Item Added To Cart", true, context);
                },
                text: "Add To Cart : \$${widget.item["price"]}",
                size: 15,
              ),
            ),
          ],
        ),
        extendBody: true,
        appBar: AppBar(title: const Text("Product")),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Hero(
                  tag: widget.item["id"] + "con",
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ImageWidget(
                      img: widget.item["img"],
                      size: 400,
                    ),
                  ),
                ),
                Text(
                  widget.item["name"],
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "\$${widget.item["price"]}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(.70),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.item["detail"],
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
    Map data =
        local.get("cart") == null ? {"total":0,"items":{}} : jsonDecode(local.get("cart")!);
    if (data["items"].containsKey(item["id"])) {
      data["items"][item["id"]]!["qun"]+=count;
    } else {
      data["items"][item["id"]] = {
        "id": item["id"],
        "name": item["name"],
        "price": item["price"],
        "qun": count,
        "img": item["img"],
        "detail": item["detail"],
        "store": item["store"],
      };
    }
    data["total"]+=count*int.parse(item["price"]);
    local.set("cart", jsonEncode(data));
  }
}
