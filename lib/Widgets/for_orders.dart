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
      child: ListTile(
        onTap: () => push(
          context,
          Items(
            order: item["oid"],
            store: item["stimg"],
            theOrder: item,
          ),
        ),
        title: Text(item["store"]),
        leading: SizedBox(
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: ImageWidget(
              img: item["stimg"],
              fit: BoxFit.cover,
            ),
          ),
        ),
        trailing: Text("\$${item["price"]}"),
        subtitle: Text("${item["date"]} - ${item["status"]}"),
      ),
    );
  }
}
