// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Pages/Login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';

import '../Pages/Forms.dart';
import '../Pages/Products.dart';
import 'for_all.dart';

class Store extends StatelessWidget {
  const Store({
    Key? key,
    required this.store,
    required this.location,
  }) : super(key: key);
  final Map store;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          if (context.read<User>().user == null && location != "Local") {
            push(context, const Login());
          } else {
            push(context,
              location == "Local"
                  ? Products(
                store: store['name'],
              )
                  : Forms(
                store: store['name'],
              ),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: extension(store["stimg"]) == ".svg"
                    ? SvgPicture.network(
                  "$link/uploads/${store["stimg"]}",
                  placeholderBuilder: (context) => const Loading(),
                  fit: BoxFit.cover,
                  clipBehavior: Clip.none,
                )
                    : CachedNetworkImage(
                  placeholder: (context, i) => const Loading(),
                  imageUrl: "$link/uploads/${store["stimg"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(store['name']),
          ],
        ),
      ),
    );
  }
}
