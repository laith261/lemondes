import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'for_all.dart';

class Item extends StatelessWidget {
  const Item({Key? key, required this.item, this.store})
      : super(key: key);
  final Map item;
  final String? store;

  @override
  Widget build(BuildContext context) {
    double total = item["price"] == null
        ? 0
        : double.parse(item["qty"]) * double.parse(item["price"]);
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        onTap: item["type"] == "img"
            ? null
            : () => launchUrl(Uri.parse(item["link"])),
        leading: SizedBox(
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Builder(builder: (context) {
              String url = item["type"] == "img"
                  ? item["link"]
                  : store != null
                      ? "$store"
                      : "logo.png";
              return ImageWidget(img: url);
            }),
          ),
        ),
        trailing: Text("\$$total"),
        title: Text("${item["qty"]} X \$${item["price"] ?? 0}"),
        subtitle: item["type"] == "link"
            ? Text("${item["color"]} - ${item["size"]}")
            : null,
      ),
    );
  }
}
