import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    primary: Colors.blueAccent,
    surface: Colors.grey[100],
    inverseSurface: Colors.black,
    brightness: Brightness.light,
    primaryContainer: Colors.grey[100],
    secondaryContainer: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.blueAccent,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(Colors.blueAccent),
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
    barBackgroundColor: Colors.grey[100],
    applyThemeToAll: true,
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    textTheme: const CupertinoTextThemeData(
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: "Poppins",
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    primary: Colors.blueAccent,
    brightness: Brightness.dark,
    surface: const Color(0xFF1B1B1F),
    inverseSurface: Colors.white,
    primaryContainer: const Color(0xFF1B1B1F),
    secondaryContainer: const Color.fromARGB(255, 22, 22, 25),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(Colors.blueAccent),
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromARGB(255, 22, 22, 25),
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
    barBackgroundColor: Color(0xFF1B1B1F),
    applyThemeToAll: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blueAccent,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
