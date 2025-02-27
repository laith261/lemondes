import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lemondes/Functions/Functions.dart';
import 'package:lemondes/Functions/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Functions/Local.dart';
import 'Functions/Theme.dart';
import 'Pages/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  local = LocalData(await SharedPreferences.getInstance());
  await Firebase.initializeApp();
  iosPrecession();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ),
    ),
  );
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    local.userCheck(context.read<User>().setLogin);
    link = local.get("link") ?? link;
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
