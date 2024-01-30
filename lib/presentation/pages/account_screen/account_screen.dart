import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Account detail"),
          const SizedBox(
            height: 12,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Name"),
                    Text("User 1"),
                  ],
                ),
                Row(
                  children: [
                    Text("Email"),
                    Text("user1@mail.com"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            child: Expanded(
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout),
                label: const Text("Log out"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
