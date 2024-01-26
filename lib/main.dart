import 'package:flutter/material.dart';
import 'package:flutter_rust_application/injection.dart';
import 'package:flutter_rust_application/presentation/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setup();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MainApp(
    token: prefs.getString("token"),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.token});

  final token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SplashScreen(
          token: token,
        ),
      ),
    );
  }
}
