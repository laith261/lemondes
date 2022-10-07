import 'package:flutter/material.dart';

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
      child: Row(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ImageWidget(
                img: item["img"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text(item["name"])),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () => delete(item["id"]),
                        icon: const Icon(Icons.close)),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${item["price"]}"),
                    Row(
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
