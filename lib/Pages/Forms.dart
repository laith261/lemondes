import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:provider/provider.dart';

import '../Widgets/for_forms.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key, required this.store}) : super(key: key);
  final String store;

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey widgets = GlobalKey();
  String note = "";
  final List<Map<String, String>> _forms = [
    {"link": "", "size": "", "color": "", "quantity": ""}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.store),
          actions: [
            IconButton(
                onPressed: () {
                  addForm();
                },
                icon: const Icon(Icons.add_rounded)),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    StatefulBuilder(
                      key: widgets,
                      builder: (context, sta) {
                        return Column(
                          children: [
                            for(var i=0;i<_forms.length;i++)
                              FormWidget(
                                delete: delete,
                                data: _forms[i],
                                index: i,
                                onsave: saveValue,
                              )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FormText(
                          label: 'Note',
                          value: note,
                          onsave: (value) {
                            note = value!;
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          submit();
                        }
                      },
                      child: const Text("Submit"),
                    ),
                    const SizedBox(
                      height: 15,
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

  void addForm() {
    _form.currentState!.save();
    widgets.currentState!.setState(() {
      _forms.add({"link": "", "size": "", "color": "", "quantity": ""});
    });
  }

  void saveValue(int index,String name,String? value) {
    _forms[index][name] = value!;
  }

  void delete(int index) {
    _form.currentState!.save();
    widgets.currentState!.setState(() {
      _forms.removeAt(index);
    });
  }

  void submit() {
    https.postMap({
      "formsorders": jsonEncode({
        "orders": _forms,
        "uid": context.read<User>().user!["uid"],
        "note": note,
        "store": widget.store,
      }),
    }).then((value) {
      if (value["st"]) {
        _forms.clear();
        note = "";
        addForm();
      }
      snakBar(value["mess"], value["st"], context);
    });
  }
}
