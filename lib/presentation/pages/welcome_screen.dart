import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/presentation/pages/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: [
          const SizedBox(
            height: 140,
          ),
          Hero(
            tag: "icon-tag",
            child: Image.asset(
              "assets/images/icon-white.png",
              width: 150,
              height: 80,
            ),
          ),
          const Text(
            "Your in and out management",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              40,
              20,
              30,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                ButtonFullWidth(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                ButtonFullWidth(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text("New to InOut? Sign up!"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
