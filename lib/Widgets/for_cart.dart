import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';

import 'for_all.dart';

class CartWidget extends StatelessWidget {
  const CartWidget(
      {Key? key,
        required this.item,
        required this.delete,
        required this.change})
      : super(key: key);
  final Map item;
  final Function(String) delete;
  final Function(String, int) change;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              spreadRadius: -15,
              blurRadius: 20,
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedNetworkImage(
                  placeholder: (context, i) => const Loading(),
                  imageUrl: "$link/uploads/${item["img"]}",
                  width: 50),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Text(item["name"])),
              const SizedBox(
                width: 10,
              ),
              Text("\$${item["price"]}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: item["qun"] == 1
                            ? null
                            : () => change(item['id'], -1),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    Text("${item["qun"]}",
                        style: const TextStyle(fontSize: 18)),
                    IconButton(
                        onPressed: () => change(item['id'], 1),
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => delete(item["id"]),
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }
}
