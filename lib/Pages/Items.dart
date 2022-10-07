import 'package:flutter/material.dart';
import 'package:lemondes/Widgets/for_all.dart';

import '../Functions/Functions.dart';
import '../Widgets/for_items.dart';
import '../Widgets/for_orders.dart';

class Items extends StatefulWidget {
  const Items({Key? key, required this.order, this.store, this.theOrder})
      : super(key: key);
  final String? store;
  final Map? theOrder;
  final String order;

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  Map? order;
  @override
  void initState() {
    order = widget.theOrder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Items"),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SizedBox(
              width: 300,
              child: FutureBuilder<Map>(
                future: https.postMap({
                  "oid": widget.order,
                  "getorder": "${widget.theOrder == null}"
                }),
                builder: (context, snap) {
                  if (snap.hasData && (snap.data!["data"] as List).isNotEmpty) {
                    order = snap.data!["order"];
                  }
                  return ListView(
                    children: [
                      if (order != null)
                        Hero(
                          tag: order!["oid"],
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2,
                            child: Order(
                              item: order!,
                            ),
                          ),
                        ),
                      if (order != null) const SizedBox(height: 20),
                      if (snap.hasData && snap.data!["data"].isNotEmpty)
                        for (var i = 0; i < snap.data!["data"].length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Item(
                              store: widget.store,
                              item: snap.data!["data"][i],
                            ),
                          ),
                      if (snap.hasData && (snap.data!["data"] as List).isEmpty)
                        const Empty(),
                      if (!snap.hasData) const Loading()
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
