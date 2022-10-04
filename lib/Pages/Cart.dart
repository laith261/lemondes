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
  List<Widget> widgets = [];
  int length = 0;
  double total = 0;

  void getCart() {
    data = [];
    total = 0;
    widgets = [];
    length = 0;
    local!.get("cart").then((value) {
      Map holder = value == null ? {} : jsonDecode(value);
      data = holder.values.toList();
      length = data.length;
      loop().then((value) => setState(() {}));
    });
  }

  Future<void> loop() async {
    for (var i = 0; i < length; i++) {
      total += data[i]["qun"] * double.parse(data[i]["price"]);
      widgets.add(CartWidget(
        item: data[i],
        change: change,
        delete: delete,
      ));
    }
  }

  void delete(String id) {
    local!.get("cart").then((value) {
      Map tdata = jsonDecode(value!);
      tdata.remove(id);
      local!.set("cart", jsonEncode(tdata));
      getCart();
    });
  }

  void change(String id, int opr) {
    local!.get("cart").then((value) {
      Map tdata = jsonDecode(value!);
      tdata[id]["qun"] += opr;
      local!.set("cart", jsonEncode(tdata));
      getCart();
    });
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
        bottomNavigationBar: ColoredBox(
          color: Theme.of(context).colorScheme.secondary,
          child: ElevatedButton(
            onPressed: total == 0
                ? null
                : () {
                    https.postMap({
                      "submitorder": jsonEncode({
                        "uid": context.read<User>().user!["uid"],
                        "order": data,
                      })
                    }).then((value) {
                      if (value["st"]) {
                        local!.delete("cart").then((value) {
                          getCart();
                        });
                      }
                      snakBar(value["mess"], value["st"], context);
                    });
                  },
            child: Text(
              "Check Out Total : \$$total",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
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
              child: ListView(
                children: widgets,
              ),
            ),
          );
        }),
      ),
    );
  }
}
