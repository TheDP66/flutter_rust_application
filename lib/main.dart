import 'dart:io';

import 'package:InOut/injection.dart';
import 'package:InOut/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:permission_handler/permission_handler.dart';
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
    Future<void> _checkPermissions() async {
      print("======================================== Check permission start!");

      // Check if permissions are granted
      if (Platform.isAndroid) {
        await Permission.storage.request().isGranted;
        await Permission.photos.request().isGranted;
        await Permission.videos.request().isGranted;
        await Permission.audio.request().isGranted;
      } else {
        await Permission.storage.request().isGranted;
      }

      if (Platform.isAndroid) PathProviderAndroid.registerWith();
      if (Platform.isIOS) PathProviderIOS.registerWith();
      print(
          "======================================== Check permission finished!");
    }

    @override
    void initState() {
      super.initState();
      _checkPermissions();
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          background: Colors.grey[100],
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SplashScreen(
          token: widget.token,
        ),
      ),
    );
  }
}
