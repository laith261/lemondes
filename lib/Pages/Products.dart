import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Widgets/for_all.dart';
import 'package:provider/provider.dart';

import '../Functions/Functions.dart';
import '../Functions/User.dart';
import '../Widgets/for_products.dart';
import 'Cart.dart';
import 'Login.dart';

class Products extends StatefulWidget {
  const Products({Key? key, required this.store}) : super(key: key);
  final String store;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isShow = false;
  Future<Map>? _data;
  Map<String, List> filter = {"types": [], "sizes": [], "colors": []};

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    double count =
        (MediaQuery.of(context).size.width / 250).floorToDouble().toInt() + 1;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            push(
                context,
                context.read<User>().user != null
                    ? const Cart()
                    : const Login());
          },
          child: const Icon(Icons.shopping_cart_rounded),
        ),
        appBar: AppBar(
          title: Text(widget.store),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() => isShow = !isShow);
                },
                icon: const Icon(Icons.filter_alt_rounded)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
                  Visibility(
                    visible: !isShow,
                    child: FutureBuilder<Map>(
                      builder: (context,snap) {
                        if(snap.hasData && (snap.data!["data"] as List).isNotEmpty) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: count.toInt()),
                            itemBuilder: (context, i) =>
                                ProductWidget(
                                  data: snap.data!["data"][i],
                                ),
                            itemCount: snap.data!["data"].length,
                          );
                        }
                        else if(snap.hasData && (snap.data!["data"] as List).isEmpty){
                          return const Empty();
                        }
                        return const Loading();
                      },
                      future: _data,
                    ),
                  ),
              Visibility(
                visible: isShow,
                maintainState: true,
                child: Filters(
                    gitFilter: gitFilter,
                    resetFilter: resetFilter,
                    key: const ValueKey("filters"),
                    add: addFilter,
                    remove: removeFilter,
                    isIn: isIn),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isIn(String type, String value) => filter[type]!.contains(value);
  void addFilter(String name, String value) => filter[name]!.add(value);
  void removeFilter(String name, String value) => filter[name]!.remove(value);
  void resetFilter() => filter = {"types": [], "sizes": [], "colors": []};
  void getItems() {
    _data=https.postMap({"local": widget.store, "filter": jsonEncode(filter)});
  }

  void gitFilter() {
    setState(() {
      isShow = false;
      _data = null;
    });
    getItems();
  }
}
