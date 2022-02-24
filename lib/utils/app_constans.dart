import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color(0xffF2F4F5);
  static const themeColor = Color(0xffBB1FD5);

  static const labelColor = Color(0xff07070b);

  static const double gridSpacing = 7;

  static Map<int, Color> color = {
    50: const Color.fromRGBO(187, 31, 213, .1),
    100: const Color.fromRGBO(187, 31, 213, .2),
    200: const Color.fromRGBO(187, 31, 213, .3),
    300: const Color.fromRGBO(187, 31, 213, .4),
    400: const Color.fromRGBO(187, 31, 213, .5),
    500: const Color.fromRGBO(187, 31, 213, .6),
    600: const Color.fromRGBO(187, 31, 213, .7),
    700: const Color.fromRGBO(187, 31, 213, .8),
    800: const Color.fromRGBO(187, 31, 213, .9),
    900: const Color.fromRGBO(187, 31, 213, 1),
  };

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(primary: Color(0xff07070b)),
    backgroundColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(primary: const Color(0xff07070b)),
    backgroundColor: Colors.black,
  );
}
