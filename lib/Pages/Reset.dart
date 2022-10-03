import 'package:flutter/material.dart';

import '../Functions/Functions.dart';
import '../Widgets/for_all.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  var form = GlobalKey<FormState>();
  bool send = false;
  String email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reset Password"),
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
                        save: (value) => email = value!,
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
                                https.postMap({"password-reset": email}).then(
                                    (value) {
                                  if (value["st"]) {
                                    setState(() => send = false);
                                    snakBar(
                                        value['mess'], value["st"], context);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Send",
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
