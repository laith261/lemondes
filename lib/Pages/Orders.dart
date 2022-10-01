import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Widgets/for_all.dart';
import 'package:lemondes/Widgets/for_orders.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    local!.userCheck(context.read<User>().login).then((value) {
      if (!value) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SizedBox(
              width: 300,
              child: FutureBuilder<Map>(
                future: https.postMap({"orders": context.read<User>().user!["uid"]}),
                builder: (context,snap) {
                  if(snap.hasData && (snap.data!["data"] as List).isNotEmpty){
                    return ListView.builder(
                      itemBuilder: (context, i) => Order(
                        item: snap.data!["data"][i],
                      ),
                      itemCount: snap.data!["data"].length,
                    );
                  }
                  if(snap.hasData && (snap.data!["data"] as List).isEmpty){
                   return const Empty();
                  }
                  return const Loading();
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
