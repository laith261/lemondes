import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Functions/Functions.dart';
import '../Functions/User.dart';
import '../Widgets/for_home.dart';
import 'Global.dart';
import 'Notfy.dart';
import 'Stores.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    openMessage(context);
    foregroundMessage(context);
    backgroundMessage(context);
    local?.userCheck(context.read<User>().login);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            Selector<User, Map?>(
              selector: (_, user) => user.user,
              builder: (_, data, __) {
                return Visibility(
                  visible: data != null,
                  child: IconButton(
                    onPressed: () {
                      push(context, const Notify());
                    },
                    icon: const Icon(Icons.notifications_rounded),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    HomeImage(
                      image: 'global.png',
                      func: () {
                        push(context, const Global());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    HomeImage(
                      func: () {
                        push(context, const Stores(location: "Local"));
                      },
                      image: 'local.png',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
