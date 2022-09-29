import 'package:flutter/material.dart';
import 'package:lemondes/Widgets/for_home.dart';


class Global extends StatelessWidget {
  const Global({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Global"),
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
                      func: () {
                        // push(context, const Stores(location: "Uae"));
                      },
                      image: 'uae.png',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    HomeImage(
                      func: () {
                        // push(context, const Stores(location: "Turkey"));
                      },
                      image: 'turkey.png',
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
