import 'package:InOut/presentation/pages/dashboard_screen.dart';
import 'package:InOut/presentation/pages/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.token});

  final token;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        (token == null)
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
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
