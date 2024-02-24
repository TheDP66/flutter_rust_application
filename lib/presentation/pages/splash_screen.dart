import 'package:InOut/core/utils/permission.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String? token;

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString("token");
    });
  }

  @override
  void initState() {
    super.initState();
    checkPermissions();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        (token == null) ? context.go("/login") : context.go("/dashboard");
      },
    );

    return Scaffold(
      body: Container(
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
      ),
    );
  }
}
