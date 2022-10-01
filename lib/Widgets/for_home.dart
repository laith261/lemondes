import 'package:flutter/material.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:lemondes/Pages/Account.dart';
import 'package:lemondes/Pages/Orders.dart';
import 'package:provider/provider.dart';

import '../Pages/Currency.dart';
import '../Pages/Link.dart';
import '../Pages/Login.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 150,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            // show if user logout
            Selector<User, Map?>(
              selector: (_, user) => user.user,
              builder: (_, data, __) {
                return Visibility(
                  visible: data == null,
                  child: Column(
                    children: [
                      DrawerButton(
                        icon: Icons.login_rounded,
                        text: "Login",
                        func: () {
                          push(context, const Login());
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            DrawerButton(
              icon: Icons.link,
              text: "Link",
              func: () => push(context, const LinkPage()),
            ),
            DrawerButton(
              icon: Icons.currency_exchange,
              text: "Currency Exchange",
              func: () => push(context, const Currency()),
            ),
            // show if user login
            Selector<User, Map?>(
              selector: (_, user) => user.user,
              builder: (_, data, __) {
                return Visibility(
                  visible: data != null,
                  child: Column(
                    children: [
                      DrawerButton(
                        icon: Icons.account_circle_rounded,
                        text: "Account",
                        func: () => push(context, const Account()),
                      ),
                      DrawerButton(
                        icon: Icons.view_list_rounded,
                        text: "My Orders",
                        func: () => push(context, const Orders()),
                      ),
                      DrawerButton(
                        icon: Icons.logout_rounded,
                        text: "Logout",
                        func: () {
                          context.read<User>().logout();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton(
      {Key? key, required this.func, required this.icon, required this.text})
      : super(key: key);
  final void Function() func;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Icon(icon, size: 25),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeImage extends StatelessWidget {
  const HomeImage({Key? key, required this.image, required this.func})
      : super(key: key);
  final String image;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            blurRadius: 20,
            spreadRadius: -20,
          )
        ]),
        child: Image.asset("assets/images/$image"),
      ),
    );
  }
}
