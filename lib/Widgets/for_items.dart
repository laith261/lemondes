import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'for_all.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({Key? key, required this.item, this.store})
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
        onTap: item["type"] == "img"
            ? null
            : () => launchUrl(Uri.parse(item["link"])),
        leading: SizedBox(
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Builder(builder: (context) {
              String url = item["type"] == "img"
                  ? "$link/uploads/${item["link"]}"
                  : store != null
                      ? "$link/uploads/$store"
                      : "$link/uploads/logo.png";
              if (url.substring(url.length - 3) == "svg") {
                return SvgPicture.network(
                  url,
                  placeholderBuilder: (context) => const Loading(),
                );
              }
              return CachedNetworkImage(
                  placeholder: (context, i) => const Loading(), imageUrl: url);
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
