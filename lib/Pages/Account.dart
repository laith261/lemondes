import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Widgets/for_all.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool send = false;
  Map? userData;
  Future<Map>? data;

  @override
  void initState() {
    super.initState();
    local!.userCheck(context.read<User>().login).then((value) {
      if (!value) {
        Navigator.pop(context);
      }
    });
    data = https.postMap({
      "udata": context.read<User>().user!["uid"],
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SizedBox(
              width: 300,
              child: FutureBuilder<Map>(
                builder: (context, snap) {
                  if (snap.hasData && snap.data!["st"]) {
                    userData = snap.data!["data"];
                    return SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: MyInput(
                                    save: (value) =>
                                        userData!["fname"] = value!,
                                    label: 'First Name',
                                    value: userData!["fname"],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: MyInput(
                                    save: (value) =>
                                        userData!["lname"] = value!,
                                    label: 'Last name',
                                    value: userData!["lname"],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInput(
                              save: (value) => userData!["mobile"] = value!,
                              label: 'Mobile',
                              value: userData!["mobile"],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInput(
                              save: (value) => userData!["mobile2"] = value!,
                              label: 'Mobile 2',
                              value: userData!["mobile2"],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInput(
                              save: (value) => userData!["address"] = value!,
                              label: 'Address',
                              value: userData!["address"],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInput(
                              save: (value) => userData!["address2"] = value!,
                              label: 'address 2',
                              value: userData!["address2"],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInput(
                              save: (value) => userData!["insta"] = value!,
                              label: 'Instagram',
                              value: userData!["insta"],
                            ),
                            const SizedBox(height: 15),
                            AnimatedCrossFade(
                              firstChild: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Loading(),
                              ),
                              secondChild: SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_form.currentState!.validate()) {
                                      _form.currentState!.save();
                                      setState(() => send = true);
                                      userData!["uid"] =
                                          context.read<User>().user!["uid"];
                                      https.postMap({
                                        "accountupdata": jsonEncode(userData)
                                      }).then((value) {
                                        setState(() => send = false);
                                        snakBar(value['mess'], value["st"],
                                            context);
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              crossFadeState: send
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 500),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Loading();
                },
                future: data,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
