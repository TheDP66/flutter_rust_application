import 'package:InOut/core/constant/theme.dart';
import 'package:InOut/core/services/go_router.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/pages/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await setup();

    runApp(const MainApp());
  } catch (e) {
    runApp(const ErrorScreen());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: goRouter,
    );
  }
}
