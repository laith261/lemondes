import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Widgets/for_all.dart';
import 'package:provider/provider.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var form = GlobalKey<FormState>();
  bool send = false;
  Map<String, String> singup = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SingUp"),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 300,
                child: Form(
                  key: form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyInput(
                              save: (value) => singup["fname"] = value!,
                              label: 'First Name',
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: MyInput(
                              save: (value) => singup["lname"] = value!,
                              label: 'Last name',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["email"] = value!,
                        label: 'Email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["pass"] = value!,
                        label: 'Password',
                        hideText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["repass"] = value!,
                        label: 'Repeat Password',
                        hideText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["city"] = value!,
                        label: 'City',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["faddress"] = value!,
                        label: 'Address',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["laddress"] = value!,
                        label: 'Address 2',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["mobile"] = value!,
                        label: 'Mobile',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["mobile2"] = value!,
                        label: 'Mobile 2',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => singup["insta"] = value!,
                        label: 'Instagram Link',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AnimatedCrossFade(
                        firstChild: const Loading(),
                        secondChild: SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                form.currentState!.save();
                                setState(() => send = true);
                                https.postMap({"singup": jsonEncode(singup)}).then((value){
                                  if (value["st"]) {
                                    context.read<User>().login(value['data']);
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('Home'));
                                  } else {
                                    setState(() => send = false);
                                    snakBar(
                                        value['mess'], value["st"], context);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "SingUp",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        crossFadeState: send
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
