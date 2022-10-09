import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';

class LinkPage extends StatefulWidget {
  const LinkPage({Key? key}) : super(key: key);

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  var theLink = TextEditingController();

  @override
  void initState() {
    theLink.text = link;
    super.initState();
  }

  @override
  void dispose() {
    theLink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: theLink,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      link = theLink.text;
                      local.set("link", link);
                      snakBar("done", true, context);
                      setState(() {});
                    },
                    child: const Text("save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
