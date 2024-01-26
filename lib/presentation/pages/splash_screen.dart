import 'package:flutter/material.dart';
import 'package:flutter_rust_application/presentation/pages/dashboard_screen.dart';
import 'package:flutter_rust_application/presentation/pages/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.token});

  final token;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        (token == null)
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
      },
    );

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: "icon-tag",
              child: Image.asset(
                "assets/images/icon.png",
                width: 125,
                height: 125,
              ),
            ),
          ),
          const Positioned(
            bottom: 40,
            child: Column(
              children: [
                Opacity(
                  opacity: .4,
                  child: Text(
                    "from",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  ),
                ),
                Text(
                  "Nama Application",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
