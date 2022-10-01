import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Functions/Functions.dart';
import '../Pages/Items.dart';
import 'for_all.dart';

class Order extends StatelessWidget {
  const Order({Key? key, required this.item}) : super(key: key);
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                blurRadius: 20,
                spreadRadius: -15),
          ]),
      child: ListTile(
        onTap: () => push(
          context,
          Items(
            order: item["oid"],
            store: item["stimg"],
          ),
        ),
        title: Text(item["store"]),
        leading: SizedBox(
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: CachedNetworkImage(
                placeholder: (context, i) => const Loading(),
                imageUrl: "$link/uploads/${item["stimg"]}"),
          ),
        ),
        trailing: Text("\$${item["price"]}"),
        subtitle: Text("${item["date"]} - ${item["status"]}"),
      ),
    );
  }
}
