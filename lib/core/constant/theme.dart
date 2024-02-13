import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    primary: Colors.blueAccent,
    background: Colors.grey[100],
    inverseSurface: Colors.black,
    brightness: Brightness.light,
    primaryContainer: Colors.grey[100],
    secondaryContainer: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(Colors.blueAccent),
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
    background: const Color(0xFF1B1B1F),
    inverseSurface: Colors.white,
    primaryContainer: const Color(0xFF1B1B1F),
    secondaryContainer: const Color.fromARGB(255, 22, 22, 25),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(Colors.blueAccent),
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
