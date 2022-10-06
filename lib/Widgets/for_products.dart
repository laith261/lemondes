import 'package:lemondes/Functions/Functions.dart';
import 'package:flutter/material.dart';

import '../Pages/Product.dart';
import 'for_all.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: data["instock"] == "true" ? 1 : .5,
      child: InkWell(
        onTap: () {
          if (data["instock"] == "true") {
            push(context, Product(item: data));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: data["id"],
                  child: ImageWidget(img: data["img"]),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    data["name"],
                    overflow: TextOverflow.ellipsis,
                  )),
              Expanded(flex: 1, child: Text("\$${data["price"]}")),
            ],
          ),
        ),
      ),
    );
  }
}

class Filters extends StatelessWidget {
  const Filters(
      {Key? key,
      required this.add,
      required this.remove,
      required this.isIn,
      required this.resetFilter,
      required this.gitFilter})
      : super(key: key);
  final Function(String, String) add;
  final Function(String, String) remove;
  final Function isIn;
  final Function resetFilter;
  final Function gitFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: StatefulBuilder(builder: (context, set) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => set(() {
                              resetFilter();
                            }),
                        icon: const Icon(Icons.unpublished_rounded)),
                    ElevatedButton(
                        onPressed: () => gitFilter(),
                        child: const Text("Filter"))
                  ],
                ),
                FiltersBox(
                  key: const ValueKey("f1"),
                  isIn: isIn,
                  data: types,
                  name: "Types",
                  add: add,
                  remove: remove,
                ),
                FiltersBox(
                  key: const ValueKey("f2"),
                  isIn: isIn,
                  data: sizes,
                  name: "Sizes",
                  add: add,
                  remove: remove,
                ),
                FiltersBox(
                  key: const ValueKey("f3"),
                  isIn: isIn,
                  data: colors,
                  name: "Colors",
                  add: add,
                  remove: remove,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class FiltersBox extends StatefulWidget {
  const FiltersBox(
      {Key? key,
      required this.name,
      required this.data,
      required this.add,
      required this.remove,
      required this.isIn})
      : super(key: key);
  final String name;
  final List data;
  final Function(String name, String value) add;
  final Function(String name, String value) remove;
  final Function isIn;
  @override
  State<FiltersBox> createState() => _FiltersBoxState();
}

class _FiltersBoxState extends State<FiltersBox> {
  int length = 0;

  @override
  void initState() {
    super.initState();
    length = widget.data.length;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, set) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("By ${widget.name}"),
            const Divider(color: Colors.black, thickness: 1),
            for (var i = 0; length > i; i++)
              CheckboxListTile(
                title: Text(widget.data[i]),
                value: widget.isIn(widget.name.toLowerCase(), widget.data[i]),
                onChanged: (value) {
                  if (value == true) {
                    widget.add(widget.name.toLowerCase(), widget.data[i]);
                  } else {
                    widget.remove(widget.name.toLowerCase(), widget.data[i]);
                  }
                  set(() {});
                },
              )
          ],
        );
      },
    );
  }
}

List<String> types = [
  "Top",
  "Pants",
  "Skirt",
  "Dress",
  "Jumpsuit",
  "Shoes",
  "Accessory",
  "Makeup",
  "Home",
];
List<String> sizes = [
  "S",
  "M",
  "L",
  "XS",
  "XL",
  "XXL",
  "XXXL",
  "1Xl",
  "2Xl",
  "3XL",
  "4XL",
  "5XL",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
];
List<String> colors = [
  "Black",
  "White",
  "Gray",
  "Brown",
  "Orange",
  "Purple",
  "Burgundy",
  "Red",
  "Blue",
  "Green",
  "Yallow",
  "Multicolor",
];
