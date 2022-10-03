import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Widgets/for_all.dart';

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  var cusd = TextEditingController();
  var ctyr = TextEditingController();
  var iqd = TextEditingController();
  var usd = TextEditingController();
  Future<Map<String, dynamic>>? _data;

  void exchange(tyr, usdd) {
    usd.text = (double.parse(ctyr.text) / double.parse(tyr)).toStringAsFixed(2);
    iqd.text =
        (double.parse(cusd.text) * double.parse(usdd)).toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    cusd.text = "1";
    ctyr.text = "14";
    _data = https.postMap({"currency": ""});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Currency"),
          ),
          body: FutureBuilder<Map>(
            future: _data,
            builder: (context, snap) {
              if (snap.hasData) {
                exchange(
                    snap.data!["data"][0]["tyr"], snap.data!["data"][0]["usd"]);
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyInput(
                                  controller: cusd,
                                  label: "USD",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MyInput(
                                  controller: iqd,
                                  label: "IQD",
                                  onlyRead: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyInput(
                                  controller: ctyr,
                                  label: "TRY",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MyInput(
                                  controller: usd,
                                  label: "USD",
                                  onlyRead: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () => exchange(
                                snap.data!["data"][0]["tyr"],
                                snap.data!["data"][0]["usd"]),
                            child: const Text(
                              "Exchange",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Loading();
            },
          )),
    );
  }
}
