import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffFED8D4),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xffFED8D4),
      secondary: const Color(0xff343a40),
    ),
    // appbar
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xff343a40),
      ),
      centerTitle: true,
      foregroundColor: Color(0xff343a40),
    ),
    // drawer
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xffFED8D4),
    ),
    // button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0xff343a40),
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) => const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        ),
      ),
    ),
    // text button
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0xff343a40)),
    )),
    // input
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),
    ),
  );
}
