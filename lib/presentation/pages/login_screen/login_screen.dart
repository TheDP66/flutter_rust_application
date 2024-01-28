import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/presentation/pages/login_screen/widgets/login_form.dart';
import 'package:InOut/presentation/pages/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            const SizedBox(
              height: 80,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  40,
                  20,
                  30,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    const Expanded(
                      child: LoginForm(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
