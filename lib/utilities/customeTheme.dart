import 'package:flutter/material.dart';

import 'consts.dart';

/*const Color primaryColor = Color(0xFF002964);
const Color secondaryColor = Color(0xFFFF1235);*/



final customTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation : 20,
    backgroundColor : secondaryColor,
  ),
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 25,
      color: primaryColor,
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return Colors.redAccent; //<-- SEE HERE
          return null; // Defer to the widget's default.
        },
      ),
    )
  ),
  scaffoldBackgroundColor: bgColor,
);