import 'package:flutter/material.dart';
import 'package:lemondes/Widgets/for_all.dart';

import '../Functions/Functions.dart';
import '../Widgets/for_items.dart';

class Items extends StatefulWidget {
  const Items({Key? key, required this.order, this.store}) : super(key: key);
  final String order;
  final String? store;

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
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
                  future: https.postMap({"oid": widget.order}),
                  builder: (context, snap) {
                    if (snap.hasData && (snap.data!["data"] as List).isEmpty) {
                      return const Empty();
                    }
                    if (snap.hasData &&
                        (snap.data!["data"] as List).isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, i) => ItemsWidget(
                          store: widget.store,
                          item: snap.data!["data"][i],
                        ),
                        itemCount: snap.data!["data"]!.length,
                      );
                    }
                    return const Loading();
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
