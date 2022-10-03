import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Pages/Reset.dart';
import 'package:lemondes/Pages/SingUp.dart';

import 'package:lemondes/Widgets/for_all.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var form = GlobalKey<FormState>();
  bool send = false;
  Map<String, String> login = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
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
                      MyInput(
                        save: (value) => login["email"] = value!,
                        label: 'Email',
                        valida: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return "Fill with 7 Char or more";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInput(
                        save: (value) => login["pass"] = value!,
                        label: 'Password',
                        hideText: true,
                        // valida: (value){
                        //   if(value!=null || value!.isEmpty || value.length<6){
                        //     return "Fill with 7 Char or more";
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AnimatedCrossFade(
                        firstChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Loading(),
                        ),
                        secondChild: SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                form.currentState!.save();
                                setState(() => send = true);
                                https.postMap(
                                    {"login": jsonEncode(login)}).then((value) {
                                  if (value["st"]) {
                                    context.read<User>().login(value['data']);
                                    Navigator.pop(context);
                                  } else {
                                    setState(() => send = false);
                                    snakBar(
                                        value['mess'], value["st"], context);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        crossFadeState: send
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            push(context, const Reset());
                          },
                          child: const Text("Forgot Password?")),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            push(context, const SingUp());
                          },
                          child: const Text("Don`t Have Account? SingUp"))
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
