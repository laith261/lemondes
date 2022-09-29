import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Widgets/for_all.dart';
import 'package:provider/provider.dart';

import '../Functions/User.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SizedBox(
              width: 300,
              child: FutureBuilder<Map>(
                builder: (context, snap) {
                  if (snap.hasData && snap.data!.isNotEmpty) {
                    List data = snap.data!["data"];
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          // push(context, Items(order: _data![i]["orid"]));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(vertical: 7),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          child: Text(data[i]["text"]),
                        ),
                      ),
                    );
                  }
                  if (snap.hasData && snap.data!.isEmpty) {
                    return const Empty();
                  }
                  return const Loading();
                },
                future: https
                    .postMap({"notify": context.read<User>().user!["uid"]}),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
