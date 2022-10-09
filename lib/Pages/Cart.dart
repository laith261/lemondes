import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Widgets/for_all.dart';

import 'package:lemondes/Widgets/for_cart.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List data = [];
  int length = 0;
  double total = 0;

  void getCart() {
    data = [];
    length = 0;
    Map holder = local!.get("cart") == null
        ? {"total": 0, "items": {}}
        : jsonDecode(local!.get("cart")!);
    data = holder["items"].values.toList();
    length = data.length;
    total = holder["total"];
    setState(() {});
  }

  void delete(String id) {
    Map tData = jsonDecode(local!.get("cart")!);
    print("$id $tData");
    tData["total"] -=
        tData["items"][id]["qun"] * double.parse(tData["items"][id]["price"]);
    tData["items"].remove(id);
    local!.set("cart", jsonEncode(tData));
    getCart();
  }

  void change(String id, int opr) {
    Map tData = jsonDecode(local!.get("cart")!);
    tData["items"][id]["qun"] += opr;
    tData["total"] += double.parse(tData["items"][id]["price"]) * opr;
    local!.set("cart", jsonEncode(tData));
    getCart();
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:total==0?null:BottomButton(
            text: "Check Out Total : \$$total",
            function: total == 0
                ? null
                : () {
                    https.postMap({
                      "submitorder": jsonEncode({
                        "uid": context.read<User>().user!["uid"],
                        "order": data,
                      })
                    }).then((value) {
                      if (value["st"]) {
                        local!.delete("cart");
                        getCart();
                      }
                      snakBar(value["mess"], value["st"], context);
                    });
                  }),
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: Builder(builder: (context) {
          if (data.isEmpty) return const Empty();
          return Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 300,
              child: ListView.builder(
                itemCount: length,
                itemBuilder: (context, i) {
                  return CartWidget(
                    item: data[i],
                    change: change,
                    delete: delete,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
