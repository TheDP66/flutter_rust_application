import 'dart:io';

import 'package:InOut/core/widgets/layout_app.dart';
import 'package:InOut/presentation/pages/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.token});

  final token;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _checkPermissions() async {
    // Check if permissions are granted
    if (Platform.isAndroid) {
      await Permission.manageExternalStorage.request().isGranted;
      await Permission.photos.request();
      await Permission.videos.request();
      await Permission.audio.request();
    } else {
      await Permission.storage.request();
    }

    if (Platform.isAndroid) PathProviderAndroid.registerWith();
    if (Platform.isIOS) PathProviderIOS.registerWith();
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        (widget.token == null)
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LayoutApp(),
                ),
              );
      },
    );

    return Container(
      color: Colors.blueAccent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: "icon-tag",
              child: Image.asset(
                "assets/images/icon-white.png",
                width: 125,
                height: 125,
              ),
            ),
          ),
          const Positioned(
            bottom: 40,
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                // ? Footer if exist
                // Opacity(
                //   opacity: .4,
                //   child: Text(
                //     "from",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 19,
                //     ),
                //   ),
                // ),
                // Text(
                //   "Nama Application",
                //   style: TextStyle(
                //     fontSize: 24,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
