import 'package:flutter/material.dart';
import 'package:lemondes/Widgets/for_all.dart';

import '../Functions/Functions.dart';
import '../Widgets/for_stores.dart';

class Stores extends StatefulWidget {
  const Stores({Key? key, required this.location}) : super(key: key);
  final String location;

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  @override
  Widget build(BuildContext context) {
    double count =
        (MediaQuery.of(context).size.width / 225).floorToDouble().toInt() + 1;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.location.toUpperCase()),
          ),
          body: FutureBuilder<Map>(
            future: https.postMap({"location": widget.location}),
            builder: (context, snap) {
              if (snap.hasData && snap.data!.isEmpty) {
                return const Empty();
              }
              if (snap.hasData && snap.data!.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: count.toInt()),
                  itemCount: snap.data!["data"].length,
                  itemBuilder: (context, i) => Store(
                    store: snap.data!["data"][i],
                    location: widget.location,
                  ),
                );
              }
              return const Loading();
            },
          )),
    );
  }
}
