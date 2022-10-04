import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Pages/Login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
            push(
              context,
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
                child:ImageWidget(img: "$link/uploads/${store["stimg"]}",fit: BoxFit.cover),
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
