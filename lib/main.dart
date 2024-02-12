import 'package:InOut/core/constant/theme.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  print("Injecting...");
  await setup();
  print("Inject complete!");

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MainApp(
    token: prefs.getString("token"),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.token,
  });

  final token;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        body: SplashScreen(
          token: widget.token,
        ),
      ),
    );
  }
}
